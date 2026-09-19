# Slide 模板画廊（slide-typst）

Frama 品牌风格的 Typst 幻灯片模板画廊：`lib.typ` 提供完整设计系统（版式元件 + 配色），`main.typ` + `showcase/` 用 39 页样例把每个元件演示一遍 —— 看到想要的页，连同注释一起整页复制到自己的 deck 即可（"借页"）。

## 特性

- **39 页全样例画廊**：八个家族（封面与开场 / 页面骨架 / 卡片与网格 / 数据元件 / 导航与目录 / 配色与强调 / 常规元素 / 示意图与公式），每页都是一个可整页抄走的自包含样例。
- **Frama 18 色设计系统**：8 种品牌原色 × 深浅两档（`framableu` ～ `framagris`）+ `framagrisdark` / `framagrisdarkest`，全部以 `#let` 导出、接入主题配色槽位。
- **卡片与等高网格**：`boite` 浅色卡片 ×8 + `boitefilled` 实色白字；`stretch-grid` 自动测量自然高度、按行生成等高网格，无需手算 rows。
- **CeTZ 示意图**：`cetz-canvas` 封装 touying 动画机制，示例含闭环架构图、ReAct 循环图。
- **自动目录与页面 chrome**：`outline` 条目样式、页眉标题 + 细线、面包屑、页脚三格、进度条全套 recipe。
- **工程化门禁**：编译零错误零警告、基线校验（页数 / 用法注释数 / 链接数 / API 清单）、CI 硬闸、本地 pre-commit 钩子、GitHub Pages 预览。

> 基线数字（页数 39 / 用法注释 29 / 链接 42 / API 清单）以 `gates.json` 为**单一事实源**，改动只改它；本 README 中的数字只是快照。

## 快速开始

需要 [Typst](https://typst.app) **0.15.1**（钉版本见 `typst.toml`；配套 touying 0.7.4 / cetz 0.4.2 / numbly 0.1.0）。

```bash
typst compile main.typ   # 生成 main.pdf（零错误零警告）
open main.pdf            # 或直接用阅读器打开

typst watch main.typ     # 开发模式：保存即增量重编
```

中文回退字体为 **Heiti SC**（macOS 自带）；在 Linux CI 上字体缺省会带来分页漂移，属已知现象（见下文"门禁分层"）。

## 目录结构

| 路径 | 职责 |
|---|---|
| `lib.typ` | **设计系统唯一 API 源**：44 个公开符号（配色 / 卡片 / 网格 / 页面骨架 / 数据元件 / 章节封面 / CeTZ）。已冻结，改动需独立评审 |
| `main.typ` | 入口：字体配置、slide-theme、deck 身份元数据（书名 / 作者 / 机构 / 日期）、`#include` 显式列举 showcase/* |
| `showcase/show.cover.typ` | 封面 `cover`（含参数变体）、开场页 `section-open`（index 有/无、自定义色） |
| `showcase/show.skeleton.typ` | 正文页骨架 `body-slide` 全套变体 + 间距体系（`gap-primary` / `gap-secondary`） |
| `showcase/show.cards.typ` | `boite`×8 + `boitefilled` + `stretch-grid`（2/3/5 列、gutter）+ 引用块卡片 + 竖向文本 + 全要素样板页 |
| `showcase/show.data.typ` | `keyline`（色/字号变体）、`stat`（默认/定制/stretch 行）、`note`、强调文本 |
| `showcase/show.nav.typ` | 自动目录 recipe（`outline` + 条目样式）+ 页眉 / 面包屑 / 页脚 / 进度条 |
| `showcase/show.color.typ` | frama 调色板总览 + `slide-accent` 页级换色演示 |
| `showcase/show.basic.typ` | 常规元素：原生 `table` 表格（深底白字表头/斑马纹/末行强调）、`image` 图片（含多子图三图一线）、`link` 外链与内链 |
| `showcase/show.cetz.typ` | CeTZ 画布示例（闭环图 / ReAct 循环）+ 公式块 |
| `assets/` | 演示资产（`sample-scheme.svg` / `sample-chart.svg` / `sample-data.svg`），借页者按需替换 |
| `gates.json` | **基线单一事实源**：页数 / 用法注释数 / 链接数 / API 清单 |
| `scripts/verify.py` | 门禁唯一实现（本地 + CI + pre-commit 共用） |
| `.github/workflows/` | `ci.yml` 门禁（ubuntu）+ `pages.yml` Pages 部署（macOS，strict 页数闸 + main.pdf 预览） |
| `.pre-commit-config.yaml` | 本地 quick 钩子（无 typst 时自动跳过，不阻塞提交） |

八个家族的 `main.typ` include 顺序即画廊目录顺序。

## 如何使用（借页指南）

这套画廊的定位是"借页"，核心工作流：

1. **找到想借的页**：打开 `main.pdf` 翻页浏览，或直接看各 `showcase/*.typ`。
2. **整页复制**：把该页所在文件（或整个家族文件）复制进你的 deck，`#include` 引入；再复制对应的 `lib.typ` 元件。
3. **按注释改**：每个 showcase 页顶部固定有三段注释，照它改即可。
   - `// 用法:` —— 这是哪个模板 + 关键参数
   - `// 改这里:` —— 换内容/参数的具体位置
   - `// ⚠ 坑:` —— 该页已知的坑点清单
4. **换身份与换色**：
   - deck 身份（书名 / 作者 / 机构 / 日期）只改 `main.typ` 的 `slide-theme.with(config-info(...))`；
   - 换强调色用 `section-open(title, subtitle, color: ...)`（每节一次）；页内临时走位用 `#slide-accent(色)`，**必须放在上一页末尾**，放标题前会凭空多插一页；
   - 全局字体与正文字号在 `main.typ`（默认 0.85em，中文回退 Heiti SC）。

### 应该用哪个元件

| 想要的效果 | 用这个 |
|---|---|
| 一页正文排版 | `body-slide(kicker, inner, closing, gap: gap-primary)` |
| 浅色强调卡片 | `boitebleue` / `boiteverte` / `boiterouge` / …（共 8 色） |
| 实色卡片（白字） | `boitefilled` |
| 等高的卡片/数字行 | `stretch-grid(..cells, columns: …, gutter: …)` |
| 大数字数据点 | `stat(amount, label)` |
| 分隔细线 | `keyline(body, color, size: 24pt)` |
| 页尾/附注灰字 | `note(body)` |
| 图 + 自动图注 | `figure-block(img, caption: …)` |
| 章节开场页 | `section-open(title, subtitle, color)` |
| 封面 | `cover(title, subtitle, author, institution, date)` |
| 架构示意图 / 流程图 | `cetz-canvas(...)` + CeTZ 绘图命令 |

### 一定会抄错的点（浓缩版）

- **stretch 规格字典**：`stretch: true` 返回的是规格字典（不是内容），只交给 `stretch-grid` 排版；网格单元格里卡片外面不要再包 `[]`。
- **底纹对比看明度不看饱和度**：中明度底色（vert/orange/jaune/marron）配深字；`boitefilled` 用中明度裸色会发虚 —— 元件层已自动垫深 28%，可放心用。
- **换色时序**：`slide-accent(色)` 放上一页末尾；`section-open` 紧跟 `=` 之后、段内第一个 `==` 之前。
- **图注**：`figure-block` 里 `image(...)` 调用处**不要写 width**（块内自动 `set(100%)`）；原生 `figure` 与 `figure-block` 是两条 caption 路径，勿混用。
- **表格**：用原生 `table`；表头 `table.table.header` 只负责分组与跨页重复，列样式写在内部 `table.cell` 上。
- **内链锚点**：`<label>` 须挂在页面标题上，放 `body-slide` 的 inner 里会被 Touying 丢弃。
- **命名禁区**：`body` / `content` / `main` 不可作具名参数；块内插值写 `[#变量]`，不是 `[变量]`。

## 设计系统速览

- **配色 18 色**：`framableu` / `framavert` / `framarouge` / `framaviolet` / `framaorange` / `framajaune` / `framamarron` / `framagris`（各带 light 变体），外加 `framagrisdark` / `framagrisdarkest`；另有一个助文灰 `framagris-soft`。全部是 `#let` 导出的裸色值，可自由组合。
- **卡片**：`boitebleue` / `boiteverte` / `boiterouge` / `boiteorange` / `boiteviolette` / `boitejaune` / `boitemarron` / `boitegrise`（左竖条 + 极浅底 + 圆角 + 舒适内边距）；`boitefilled` 为实色白字。均支持 `stretch: true`。
- **网格**：`stretch-grid` 自动等高；间距三档 token：`gutter-tight` 0.6em / `gutter-primary` 0.8em（默认）/ `gutter-loose` 1em。
- **数据元件**：`keyline(body, color: auto, size: 24pt)`；`stat(amount, label, amount-size: 34pt, color: auto)`（"大数字"锚定行垂直中心）；`note(body, color: framagris)`。
- **图注**：`figure-block(img, caption, width: 88%, caption-size: 0.63em, caption-color: framagris)` —— 图与图注同宽同左缘、紧贴图下沿。
- **章节/封面**：`section-open(...)` 写入 accent 与面包屑状态；`cover(...)` 元数据默认一律 none（deck 身份由 main.typ 注入）。
- **CeTZ**：`cetz-canvas(...)` = touying reducer + cetz canvas，用于逐帧动画的架构图。

> 以上是粗粒度速写；每个元件的完整签名与默认值以 `lib.typ` 为准。

## 工程化与门禁

```bash
python3 scripts/verify.py              # 本机门禁（六项检查）
python3 scripts/verify.py --strict-pages  # 页数升级为硬闸
```

`scripts/verify.py` 是**门禁唯一实现**，本地 / CI / pre-commit 共用，共六项：

| 检查 | 含义 |
|---|---|
| compile | `typst compile main.typ` 零错误零警告 |
| usage-comments | showcase 各页 `// 用法:` 注释总数 == 基线（29） |
| api | `gates.json` API 清单每项都必须是 `lib.typ` 的 `#let` 导出 |
| links | main.pdf 中链接数 == 基线（42） |
| pages | 页数 == 基线（39） |
| version | typst 主次版本与钉版本（0.15.1）一致，偏离只告警 |

**改基线（如增删页）只改 `gates.json`**，并同步 CHANGELOG —— `verify.py` 全绿即可，其它文件不复制数字。

**门禁分层（按运行环境）**：

- **macOS 本地**：`pages` 走硬闸（`mdls` 精确取页数；中文字体完整，页数稳定）。`pre-commit` 钩子默认以 `--strict-pages` 跑全量门禁；机器上没装 typst 时自动跳过、不阻塞提交。
- **CI（ubuntu）**：页面检查降级为 warn —— ubuntu 无 Heiti SC，分页漂移属预期，故不以 ubuntu 页数作硬闸；其余五项硬闸。
- **GitHub Pages**：`pages.yml` 在 macOS runner 上重新编译并跑 strict 门禁，把 `main.pdf` 部署到 Pages 供预览/下载（需在仓库 Settings > Pages 选择 "GitHub Actions" 作为源）。

**溢出是静默的**：Typst 不报溢出错，直接把内容压向页脚/截断。门禁只保证"编译零警告 + 页数对"，**每条改动都要人工逐页翻看确认布局与溢出**。

## 开发 / 贡献

- 提交信息用英文祈使句（如 `Add figure-block caption helper`），与仓库历史保持一致。
- `lib.typ` 是设计系统基座，已冻结 —— 改动默认拒绝，需先独立评审。
- 新页面先用现有元件组合，不要发明新容器/装饰语言；内容增加时优先收紧间距，不要翻页。
- 探索性渲染（编译测试页 / 输出自检 PDF）一律放系统临时目录，**不要**把 `_*.typ` / `_*.pdf` / png / svg 探针文件留在仓库。
- 若要用于自己的 deck，直接复制 `showcase/` 某页并改 `main.typ` 的配置即可，`lib.typ` 原样引用。

## 变更记录

版本行为与结构变化见 [CHANGELOG.md](CHANGELOG.md)；基线数字（页数 / 用法 / 链接 / API）只维护在 `gates.json`。