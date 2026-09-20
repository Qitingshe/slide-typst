# Changelog

本仓库遵循 [Keep a Changelog](https://keepachangelog.com/)。
基线（页数 / 用法计数 / 链接数 / API 清单）的变更只写 gates.json，这里记录行为与结构变化。

## [Unreleased]

### Added
- 新增「数据图表」家族（showcase/show.charts.typ，4 页）：根据数据绘制饼图 chart.piechart / 分组柱状 chart.barchart / 线性图 plot.plot+plot.add / 变体速查（环形·堆积·区域）；numbly 0.1.0 首次落地为格式化样板（占比/工时/降幅）；目录 8 → 9 家族
- 新增「表格与流程」家族（showcase/show.tables.typ，4 页）：表格替代语言三组件落地——cmp-grid 对比网格（左灰维度标签 + 双色值单元格）/ term-rows 术语行 / flow-steps 编号流程（横向步骤卡 + 纵向时间线，纵向行高受药丸+箭头字形度量锁死 ≈61.5pt/行，红线已注释）；`body-slide` 新增 `center: true` 垂直居中变体（双 `v(1fr)` 方案，规避 measure 对 outline 塌缩的陷阱）；目录 9 → 10 家族；lib.typ API 46 → 49 公开符号
- verify.py：移除以 rg/ripgrep 为依赖的链接/页数统计（GitHub 托管 runner 镜像不装 ripgrep，
  此前 CI 在 links 检查直接 FileNotFoundError 崩溃），改纯 Python 字节计数，语义逐字节等价；
  compile 检查对非 macOS 的 `unknown font family` 字型缺失 warning 降级 WARN（内容级仍硬闸）
- verify.py：pages 字节回退路径兼容 0.14+ krilla 引擎（页面对象序列化为无空格 `/Type/Page`，
  旧正则恒计 0 → 非 macOS 上 pages 静默恒 WARN），regex 改 `/Type\s*/Page[^sL]`
  （排除 `/Type/Pages` 与每页一个的 `/Type/PageLabel`），实测新旧 PDF 均返回 39
- 页眉细线魔数常量化（B10）：`place(…, line(length: 816.9pt))` → `_header-line-width` 命名
  常量（顶部按 841.89 − 2×12.5pt 推导注释；探针实测 header 内 `layout(width)` 不恒等于
  816.9pt、且 `line(length: 100%)` 在 place 内自噬成 ≈56pt，表达式方案不可行——命名常量
  原值逐字节同渲染，理论零视觉差）
- 页脚三格描述校正为实况（作者 / deck 标题 / 日期+页码（N/M），三色块 0.4em 白字）：
  main.typ config-info 注释、AGENTS.md 文件地图、show.nav.typ 文件头/chrome 页/演示卡文案

### Changed
- 图例字级独立降档（P6 唯一视觉变更）：show.charts.typ 新增 `leg-label` helper（内嵌
  `set text(size: 0.8em)`——cetz-plot 图例无独立字号键，label 是 Typst content），饼图
  ×6 / 柱状 ×4 / 线性 ×3 图例标签全部套用；0.7em 画布 × 0.8em ≈ 11.9pt，低于刻度 14.9pt
  一档；变体速查页无图例不动；页数 44 不变
- 注释清扫：API 地图分行说清「门禁面 46 + 4 个低阶 token 不设门禁」；cetz/numbly 模块绑定
  亦为公共导出的说明；framableulight 亮度断层警告（lib.typ:59）
- 工具链锁步升级：cetz 0.4.2 → 0.5.2，新增 cetz-plot 0.1.4（lib.typ 顶层导出 chart / plot，API 清单 44 → 46；引入时须经 `#let` 再导出——verify.py 的 api 门禁只认顶层 `#let`）；内容地图与 recipe 页按 9 行目录收紧间距，页数基线 39 → 44
- 0.15 新特性纳入：全局字符级两端对齐 `#set par(justify: true, justification-limits: (tracking: (min: -0.01em, max: 0.02em)))`（main.typ，仅中文正文受益，39 页不翻）；表格页表头改「多级分组」示范 `table.header(level: 1, …)` + `table.header(level: 2, …)`（colspan 跨组 / repeat:false 跨页只续子列行 / table stroke 须 `(x: none, …)` 去默认竖线）
- 工具链锁步升级：typst 0.13.1 → 0.15.1（typst.toml / CI / Pages / verify 版本闸同步；链接序列化基线 22 → 42）
- 画廊第四轮反馈落地：show.cards 引用块卡片 + 竖向文本（rotate 侧标 / stack-ttb 中文竖列）、show.basic 表格深底白字表头 + 斑马纹 + 末行强调、新增「多子图 · 三图一线」页（39 页基线 / 用法注释 29）
- 图注演示改「居中路线」：show.basic 单图与多子图 caption 改 `caption: none` + 调用点
  `#align(center)[#text(0.63em, framagris)]` + `#v(0.1em)`（收紧图-题间距）；三张样例 SVG
  viewBox 800×600 → 800×520（裁掉图下 ~80px 空白，元素未溢出）；lib.typ 冻结未动

## [0.1.0] - 2026-09-19

### Added
- 画廊落地（8 家族 showcase，38 页基线）：封面/骨架/cards/data/nav/配色/常规元素/CeTZ 各家族可借页样例
- `figure-block` 图注元件（图与图注同宽同左缘、紧贴图下沿）
- 工程化基座：`typst.toml`（钉 0.13.1）、`gates.json`（基线单一事实源）、`scripts/verify.py`（六项门禁唯一实现）、`.github/workflows/ci.yml`、`.pre-commit-config.yaml`
- 设计 token：`framagris-soft` 助文灰、`gutter-tight`/`gutter-primary`/`gutter-loose` 三档网格距
- GitHub Pages 部署（`.github/workflows/pages.yml`，macOS strict-pages + main.pdf 预览）

### Changed
- 重构：删死 show 规则（figure.caption/footnote）；提取 `_boite-box`/`_filled-box`/`_stat-box` 视觉常量；合并 `_cover-page`/`_opener-page` → `_full-page`；`alert` 改为 `frameEmph` 转发；`cover` 身份默认参数清空（deck 身份住 main.typ）；`boitefilled` 中明度裸色自动垫深 28%（发虚守卫）
- 文档：lib.typ 头部补 API 地图（44 公开符号）与字号阶梯注释；AGENTS.md 补架构原理与升级协议
- 移除书稿 deck（`chapters/` 仅存于 feature 分支）

### Fixed
- 图注与图间距、中明度 boitefilled 白字发虚（此前在 showcase 侧局部 workaround，现已上收到元件层）