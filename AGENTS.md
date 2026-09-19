# AGENTS.md

本仓库是一套 **Typst 幻灯片模板画廊**：`lib.typ` 提供设计系统（版式元件与配色），`main.typ` + `showcase/` 用样例演示每个元件的用法，供后续 slide 直接拷贝借鉴（"借页"）。《深入理解 AI Agent》概览 deck 保留在 `feature/ai-agent-book-overview` 分支。

## 构建与验收（硬性门槛）

```bash
typst compile main.typ
```

- 必须**零错误、零警告**。
- **页数以基线为准**：基线（页数/用法计数/链接数）单一事实源在 gates.json，改动只改它；变更日志在 CHANGELOG.md，历史变更记录在 `.slim/deepwork/template-gallery.md`；增删页后必须复核并更新基线（内容增加时优先收紧间距，不要翻页）。
- **内容溢出是静默的**（Typst 把溢出内容压到页脚/截断，不报错、不加页）——每条改动必须人工逐页翻看；agent 只保证编译与页数，视觉与溢出核验归用户。
- 探针文件：自检渲染一律走 /tmp；仓库内不得遗留 `_*.typ` / `_*.pdf` / png / svg 等探针文件。

## 文件地图

| 文件 | 职责 |
|---|---|
| `lib.typ` | 设计系统（唯一 API 源）：配色 frama* 18 色、boite*×8 + boitefilled、stretch-grid、body-slide、keyline/stat/note、section-open/cover、cetz-canvas、figure-block；**冻结，改动需独立评审** |
| `main.typ` | 入口：字体配置、slide-theme、deck 身份元数据（config-info）、封面、快速开始、自动目录、`#include` 显式列举 showcase/* |
| `showcase/show.cover.typ` | 封面 cover（含参数变体）、开场页 section-open（index 有/无、自定义色） |
| `showcase/show.skeleton.typ` | 正文页骨架 body-slide 全套变体 + gap 体系（gap-primary/secondary/0pt/closing-gap） |
| `showcase/show.cards.typ` | boite×8 + boitefilled + stretch-grid 网格（2/3/5 列、gutter）+ 全要素样板页（末页） |
| `showcase/show.data.typ` | keyline（色/字号变体）、stat（默认/定制/stretch 行）、note、alert/frameEmph |
| `showcase/show.nav.typ` | 自动目录 recipe（outline + entry 样式 + outlined:false 技巧）+ chrome（页眉标题+细线、面包屑、页脚三格、进度条） |
| `showcase/show.color.typ` | frama 调色板总览 + slide-accent 色交接演示（节内页级走位仅此一处） |
| `showcase/show.basic.typ` | 常规元素：原生 `table` 表格（frama 风格表头/斑马纹）、`image` 图片（assets/ 样例图）、`link` 超链接（外链 + `<label>` 内链） |
| `showcase/show.cetz.typ` | CeTZ 画布（改编 core.typ 闭环图/ReAct 循环）+ 公式块；合计 ≤3 页 |
| `assets/` | 画廊演示资产（sample-scheme.svg）；借页者按需替换 |
| `.slim/deepwork/template-gallery.md` | 重构计划与验收基线记录（含覆盖率清单），不在 git 中跟踪 |
| `chapters/` | main 上已删除；仅存于 feature 分支 |
| `typst.toml` | 项目元数据（compiler 钉 0.13.1） |
| `gates.json` | 基线单一事实源（页数 38 / 用法 26 / 链接 22 / API 清单）——改基线只改这里 |
| `scripts/verify.py` | 门禁唯一实现（compile 零警告 / 计数 / API / links / pages 分层）本地+CI 共用 |
| `.github/workflows/ci.yml` | CI 门禁（ubuntu，pages=warn 因字体差异） |
| `.pre-commit-config.yaml` | 本地 quick 钩子（无 typst 跳过，exclude lib.typ） |

## 架构原理（2026-09 资深架构重构固化）

- **基线单一事实源**：页数 / 用法计数 / 链接数 / API 清单只写 gates.json，改基线只改它；
  `scripts/verify.py` 是门禁唯一实现（本地 + CI + pre-commit 共用），AGENTS.md 不复制数字。
- **门禁分层**：pages 仅在 macOS（`mdls`，字体完整）走 hard gate；CI（ubuntu 无 Heiti SC，
  分页漂移属预期）与其余场景 pages 为 warn——字体不可捆绑入库，故不以 ubuntu 页数作硬闸。
- **身份边界**：deck 身份元数据（书名/作者/机构/日期）只住 main.typ 的 `slide-theme.with(
  config-info(...))`；lib.typ 零 deck 身份（`cover` 元数据默认一律 none）。
- **show 规则纪律**：show 规则从声明点起全局生效会覆盖先前样式——新家族页面必须先查全
  deck 是否已有同名规则；规则体尽量用代码上下文限定作用域（见 outline recipe）；
  删除 show 规则前统计引用计数（零引用即死规则，删除并同步 lib 注释）。
- **防拆规则**：lib.typ 保持单体（当前 638 行）；只有当超过 ~1000 行、或出现「按节独立
  分发」的真实需求时才评审拆分，不预设 facade。
- **升级协议（锁步）**：维持 typst 0.13.1 + touying 0.7.4 + cetz 0.4.2 + numbly 0.1.0；
  升级必须：① 改 typst.toml compiler 与 CI setup-typst 版本；② 跑 `verify.py --strict-pages`
  全绿；③ 新 PDF 与旧 PDF **逐页对照核验**（视觉/溢出归用户）；④ 更新 CHANGELOG。
  `verify.py` 的 version 检查对主次版本偏离输出 warn。
- **候选待办（暂不实施）**：页脚/进度条本地化（B7）、body-slide 高度 816.9pt 魔数改
  表达式（B10）、framableulight 亮度断层的文档说明。

## 结构约定

### Front Matter（已验证配方，勿乱动）
封面 → `== 快速开始`（裸 level 2，不入目录；若 Touying 报错则退回 `#heading(depth:1, outlined:false)[快速开始]` + section-open）→ `#heading(depth:1, outlined:false)[目录]` + section-open → `== 内容地图`（body-slide + `#outline` + entry 样式）→ 各 `= 家族` sections。

### 家族 sections
- `= 分段名`（level 1）每段紧跟 `#section-open(title, subtitle, color)` 开场页，且必须位于段内第一个 `==` 之前（show.cover 的演示 section-open 是故意的例外：参数演示、自成 slide，不影响段落结构）。
- `== 标题`（level 2）= 单页幻灯片；标题由 Touying 移到页眉渲染，正文写 show heading 规则无效。
- main.typ include 顺序即目录顺序，**显式列举**（禁 glob）。

### 色与强调
- 全书默认 framableu；各家族 section 通过 section-open 的 color 参数换一次色（演示节级换色）。
- 页级换色用 `#slide-accent(色)`，**必须放上一页末尾**；放 `==` 标题前会凭空多插一页。画廊仅 show.color 演示一次页级走位（只注释不渲染错误示例）。

## 注释契约（借页是画廊核心价值）

- 每个 showcase 文件头部：5–15 行家族说明（演示什么元件、与哪些文件交叉引用）。
- 每页入口注释固定三要素：
  - `// 用法:` 这是哪个模板 + 关键参数
  - `// 改这里:` 换内容/参数的具体位置
  - `// ⚠ 坑:` 该页涉及的已知坑点
- 行内注释只给非显然处，优先覆盖"一定会抄错"的清单：
  - `body`/`content`/`main` 不可作具名参数；块内插值须写 `[#变量]` 而非 `[变量]`
  - `stretch: true` 返回规格字典，只交给 stretch-grid；单元格里卡片外面**不要再包 `[]`**
  - 中明度底色（vert/orange/jaune/marron）配深字，深底色才配白字——对比看明度不看饱和度；`boitefilled` 用中明度裸色会发虚，须 `darken(25~30%)`
  - `slide-accent(色)` 放上一页末尾；`section-open` 必须紧跟 `=` 之后、段内第一个 `==` 之前
  - outline entry 样式（Typst 0.13.1）：`it.body()`/`it.page()`/`it.element.location()`，show 规则体须用代码上下文；show 规则从声明点起全局生效，会覆盖此前的 outline 样式
  - 表格用原生 `table`：表头 `table.table.header` 只负责分组/跨页重复，样式写在内部 `table.cell` 上；图片 `image()` 路径相对调用文件目录；内链 `<label>` 须挂在页面标题上，放 body-slide 的 inner 里会被 Touying 丢弃
  - `figure-block` 的 `image(...)` 调用处不要写 width（块内 `set(100%)` 接管）；原生 `figure` 与 `figure-block` 是两条 caption 路径，勿混用
- 校验门禁：`rg -c "// 用法:" showcase/` 计数须 == gates.json 的 usage-comments 基线（CI 自动断言，verify.py）。

## 设计系统速查（lib.typ）

- **配色**：`framableu` / `framavert` / `framarouge` / `framaviolet` / `framaorange` / `framajaune` / `framamarron` / `framagris`（各含 light 变体）+ `framagrisdark` / `framagrisdarkest` + `framagris-soft`（助文灰）；`frameEmph` / `alert` = 橙色加粗（稀有、可选）。
- **页面骨架**：`body-slide(kicker: none, inner: none, closing: none, gap: gap-primary, closing-gap: gap-primary)`；`gap-primary` = 0.3em（keyline 后/收尾前）；`gap-secondary` = 0.4em（主体内段间）。
- **卡片**：`boitebleue` / `boiteverte` / `boiterouge` / `boiteorange` / `boiteviolette` / `boitejaune` / `boitemarron` / `boitegrise`；`boitefilled`（实色白字）；均支持 `stretch: true`（规格字典 → stretch-grid）。
- **网格**：`stretch-grid(..cells, columns, row-gutter, column-gutter, gutter)` —— 自动等高；stat 行高按 `2·T − A` 锚定垂直中心；gutter 三档 token：`gutter-tight` 0.6em / `gutter-primary` 0.8em（默认）/ `gutter-loose` 1em。
- **数据元件**：`keyline(body, color: auto, size: 24pt)`；`stat(amount, label, amount-size: 34pt, color: auto, stretch: false)`；`note(body, color: framagris)`。
- **图注**：`figure-block(img, caption: none, width: 88%, gap: 0.12em, caption-size: 0.63em, caption-color: framagris)` —— 图与图注同宽同左缘，紧贴图下沿；和原生 figure（计数/进目录）是两条路。
- **章节/封面**：`section-open(title(必), subtitle, index, color: auto)` 写入 accent-state + breadcrumb-state；`cover(title, subtitle, author, institution, date)`。
- **CeTZ**：`cetz-canvas(...)` = touying-reducer + cetz.canvas；用于动态架构图。
- 新页面先用现有元件组合，不要发明新容器/装饰语言。

## 协作契约

- 改动先 `git status`；提交信息仓库风格（英文、祈使句）。
- 不删除/重构他人正在工作的文件；后台任务写作用域冲突前先核对。
- 视觉/设计改动由 designer 角色负责；agent 只做机械跟进；收尾后交用户人工核验（溢出、布局、画风）。
- lib.typ 改动默认拒绝，需独立评审后方可进行。
