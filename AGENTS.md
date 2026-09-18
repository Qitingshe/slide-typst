# AGENTS.md

基于《深入理解 AI Agent —— 设计原理与工程实践》的 Typst 幻灯片（全书概览）。本文件面向在此仓库工作的 AI agent：先读它，再动文件。

## 构建与验证（唯一硬性验收标准）

```bash
typst compile main.typ
```

- 必须**零错误、零警告**。
- 整份 deck 必须维持 **55 页**（封面 1 页 + 目标 1 + 目录 1 + 四分段正文）。页数变化 = 回归，需查明。
- 视觉排版核对由**人工**完成；agent 不得声称「视觉正确」，只负责结构、编译与页数。
- 需要自检渲染时用 /tmp 或临时文件，**完成后删除**；仓库内不得遗留 `_*.typ` / `_*.pdf` / png 等探针文件。

## 文件地图

| 文件 | 职责 |
|---|---|
| `main.typ` | 入口：封面、目标、目录、四个 `=` 分段；用 `#include` 串联各章节文件 |
| `lib.typ` | 设计系统 + 页面骨架（看它了解全部可用函数与参数，先读 `排版层级` 注释块） |
| `chapters/core.typ` | 分段「核心公式」：Agent 公式、闭环图（CeTZ）、ReAct、上下文五要素 |
| `chapters/ch01.typ` … `ch10.typ` | 十章速览正文（ch01–ch10），每章 `section-open` 开场页 + 若干 `==` 页 |
| `chapters/engineering.typ` | 分段「工程要点」：Harness 五要素、范式演进、全书数据 |
| `chapters/wrapup.typ` | 分段「小结」：一条主线、展望与行动 |
| `chapters/tour-map.typ` | 分段「十章速览」入口：十章地图页 |

## 结构约定

- `= 分段名`（level 1）每段紧跟 `#section-open(index/title/subtitle/color)` 开场页，且必须位于段内第一个 `==` 之前。
- `== 标题`（level 2）= 单页幻灯片；标题由 Touying 移到页眉渲染，正文里写 `show heading` 规则无效。
- 每章一个有强调色（ch01 蓝 / ch02 蓝 / ch03 紫 / ch04 绿 / ch05 蓝 / ch06 绿 / ch07 紫 / ch08 紫 / ch09 紫 / ch10 紫）。
- 色交接：`#slide-accent(色)` 放在**上一页末尾**（被吸收、不翻页）；放在下一页标题之前会凭空多一页。分段切换由下个 `section-open` 自行声明。
- 页码恒等性：不要增减页面数量；内容增多时优先收紧间距而非翻页。

## 页面骨架（正文页标准形态）

正文页统一使用 `lib.typ` 的 `body-slide` 模板：

```typst
== 标题

#body-slide(
  kicker: [页面金句行（keyline 渲染）],
  inner: [ 主体：stretch-grid / 列表 / 双栏网格 / 公式块 ],
  closing: note[...]   // 或 boitefilled[...]；可省略
)
```

- 间距统一用命名常量：`gap-primary`(0.3em，keyline 后 / 收尾前主节奏)、`gap-secondary`(0.4em，主体内段间)。
- 页面级不留裸字面 `#v(0.xem)`；刻意紧凑页用 `gap: 0pt`，刻意留白用 `closing-gap` 覆盖（如小结签名块 0.7em），都带注释说明。
- 卡片/单元格**内部**的堆叠留白是内容节奏，可使用字面值但须带注释。
- `body-slide` 的具名参数：`kicker` / `inner` / `closing` / `gap` / `closing-gap`。注意 `body`/`content`/`main` 是 Typst 保留的位置参数名，不可用作具名参数；块内插值必须写 `[#变量]` 而非 `[变量]`。
- 金句行本身作为 `#body-slide` 的 `kicker` 传入，模板内以 `#keyline[#kicker]` 形式渲染（变量插值必须带 `#`，`[变量]` 会渲染成字面文本）。

## 设计系统速查（lib.typ）

- 强调色：`framableu` / `framavert` / `framaorange` / `framaviolet` / `framagris` 及 lighten/transparentize 组合；每页主色跟随 `accent-state`。
- 卡片：`boitebleue` / `boiteverte` / `boiteorange` / `boiteviolette` / `boitejaune` / `boitemarron` / `boitegrise` / `boitefilled`（后接 `(color: …)`、`(stretch: true)` 等）。
- `stretch-grid(columns, gutter 或 row/column-gutter, …cells)`：自动等高卡片/stat 网格；单元格里的卡片只写 `#boiteXX(stretch: true)[…]`，**不要**外面再包 `[]` 或加括号。
- 其余元件：`keyline`（金句行 24pt）、`stat(amount-size)[数字][标签]`、`note`（小灰字附注）、`section-open`（章节开场页）、`cover`（封面）。
- 新页面先用现有元件组合（body-slide + stretch-grid + boite* + stat），不要发明新容器/装饰语言；需要通用新能力时先在 `lib.typ` 加文档化函数。

## 协作契约

- 改动先 `git status` 查看未提交内容；提交信息沿用仓库风格（英文、祈使句，如 `Extract standard page skeleton as body-slide template`）。
- 不删除、不重构他人正在工作的文件；后台任务写作用域冲突前先核对。
- 视觉/设计类改动由 designer 角色负责，agent 只做机械性跟进；收尾后检查用户人工核验反馈再继续。