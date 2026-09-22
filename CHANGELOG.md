# Changelog

本仓库遵循 [Keep a Changelog](https://keepachangelog.com/)。
基线（页数 / 用法计数 / 链接数 / API 清单）的变更只写 gates.json，这里记录行为与结构变化。

## [Unreleased]

### Added（2026-09-22 实色卡案例丰富）
- show.cards 实色卡片页恢复「实色卡 + 中文竖排」组合演示：boitefilled(framaviolet) + stack-ttb「借页即用」，与 rotate SIDEBAR / 灰字竖排列并存，形成「色块 vs 文字」对照层次（DES-4 曾为不拆页抽掉，现微缩竖块释放纵向空间后回归；页数 55 不变）
- show.cards 实色卡片页新增 4 列变体行：framaviolet / framagrisdark 裸色直用（白字 AA 过闸）+ color: auto 跟随强调色（_mid-tone-darken 同步生效）+ stat(stretch: true) 混排等高——演示真实内容页起手式；页内丰富不翻页，基线 usage 42 / api 51 / links 59 全不动

### Changed（2026-09-22 grid-slide 左右分栏页修版面）
- show.grid 左右分栏页底行锚定重排：`rows: (1fr, auto)` + 底部 cell 显式 `align: center + bottom` + scheme 图 `height: 3em → 5em`——原底行 1fr 撑满剩余高度、figure-block 图高随列宽等比放大（内部 `set image(width: 100%)`，lib.typ:226）挤占顶行；现顶行弹性撑满、底图贴页脚、左上图恢复存在感，三区均衡不悬空；⚠坑 补注「顶行用 1fr、底行 auto 并给底部 cell 加 align: center + bottom 可让图锚定页面底部」；页数 55 / usage 42 / api 51 / links 59 全不动

### Added（2026-09-22 DES-6 收口：GLM 二次审核 1–4 项落地）
- scripts/verify.py 新增第 5 项「section-open 区域」检查（硬闸、零基线）：main.typ 内每个 `#section-open(` 到下一个 `=`/`==`/`#heading(` 之间仅允许注释/空行/`#include`，否则 FAIL 报行号——section-open 自成 slide（touying-slide），其后挂任何内容（slide-accent/卡片/正文）都会凭空多插一页；只扫 main.typ，show.cover.typ 连续全页元件演示为故意例外

### Changed（2026-09-22 DES-6 收口：GLM 二次审核 1–4 项落地）
- lib.typ `_mid-tone-darken` 名单制 → WCAG 开放谓词：新增私有 `_contrast-against-white`（`components()` 三通道 sRGB 线性化自算 WCAG 2.0 白字对比度），对比 < 4.5 自动垫深 28%；8 色分区与旧名单逐色一致（jaune 2.34 / vert 3.00 / orange 3.00 / marron 3.31 垫深，rouge 5.31 / violet 6.38 / bleu 7.52 / gris 6.19 不动），借页者自定义色不再漏网，画廊渲染逐字节不变（before/after PDF 对照实证）；非 color 类型（gradient）跳过守卫
- lib.typ `cover` 新增 `year: none` 参数：传历史 date 时可一并传 year 使背景年份大字随 date 一致，缺省取今年（默认路径渲染不变，lib 零 deck 身份边界）
- AGENTS.md：links 联动规则（新增 `=` 家族 → 两处 depth:1 outline 各 +1 → links +2；`==` 演示页不变；links 基线以本机已装 Noto 实测为准）；防拆规则记录 lib.typ 1041 行已过 ~1000 线但无分发需求、维持单体
- lib.typ / show.color.typ 失准注释校正：「放 `==` 标题前会多插一页」→「`section-open` 之后、段内首个 `==` 之前不得挂任何内容」

### Added（2026-09-22 DES-5 美学评审落地）
- show.basic 新增「代码块 · raw」页：framagrislight 浅底 + accent 顶线 1.5pt（与 boite 卡片 3pt 左竖条方向/粗细双差异）、块级 0.78em、行内不加底色不换字号、不加行号；等宽回退链 DejaVu Sans Mono（Typst 内嵌，零新增依赖）→ Noto Sans CJK SC；页数基线 54 → 55，用法注释 41 → 42，链接 59 不变（新增代码块页是 `==` 二级标题，deck 两处 `#outline` 均 `depth: 1` 只收录 `=` 家族标题、不增收二级条目；新页内无 `#link` 调用——本机 Noto 环境实测链接增量为零）
- show.basic 图片页新增图文叠加样例：外层 block + #place 半透明白文字条（⚠坑 ④ 已注明叠加层不进 figure-block——体内 set image(width: 100%) 只管图，叠加物会被当正文排在图下方）
- show.cards 八色卡新增几何角标（色盲冗余：形状×颜色双编码，8 个互异保守码位 ●■▲◆★▼◎◇，0.55em framagrisdark，不独占新行）
- README 新增「换肤（换品牌色）」指南：framableu 引用点语义分类（语义性默认强调色 / 封面固有设计蓝 / 按节强调色）
- show.cetz ⚠坑 补 Touying #pause / #uncover 逐帧动画提示；README CeTZ 特性补一句 slider 定向（画廊保持静态单帧）

### Changed（2026-09-22 DES-5 美学评审落地）
- lib.typ 语义色别名（裁剪版）：新增私有 token `_semantic-default-accent`（下划线前缀，不入 API 清单），收敛 3 处语义引用——`_boite` 兜底默认 / `accent-state` 初值 / `config-colors` primary 槽；封面 6 处 framableu 为固有设计蓝不动、`boitebleue` 的 framableu 是颜色即身份不动；数值等价平移（API 清单 51 不变）

### Changed（2026-09-22 DES-4 美学评审落地）
- 美学 A 组（designer）：仪表盘右上面板 8.5pt→9pt（收紧内侧间距补偿）；调色板 `_swatch` 加 0.4pt 浅灰描边（浅色卡白底可辨）；页 20 引用块压缩为一行金句（出处行移除）；页 21 竖向文本与实色卡整合为紧凑三格条（不拆页）；页 23 五列卡补 0.5em 功能小字
- 美学 B 组：速查族 section-open framajaune→framamarron（白底对比 2.3:1→3.3:1）；页 4 内容地图 closing 精简为"十一族"；表格页 closing 精简（57→25 字）；变体速查 closing 精简（55→26 字）；stat 分段说明样式统一（0.78em + framagrisdark bold）；nav recipe closing 追加 show 规则全局生效警告
- lib.typ（oracle 独立评审通过）：页眉细线 lighten(65%)→lighten(50%)（非 framableu 家族页细线恢复可辨）；section-open 无序号装饰矩形 lighten(87%)→lighten(75%)（恢复柔和可见）
- 链接基线复核 59 不变（先前一度误读为 60——本机缺 Noto 字体时回退渲染的假性计数，字体齐装后复测 lib.typst.app 仍 2 个标注；无基线变更）

### Changed（2026-09-21 字体重构）
- 字体策略重构：默认字体从 `("New Computer Modern", "Heiti SC")` 替换为 `("Noto Sans CJK SC")`（SIL OFL 1.1 开源），跨平台一致，不再依赖 macOS 独占系统字体 Heiti SC；CI 安装 `fonts-noto-cjk-extra`（apt，含 Thin..Black 全字重）、Pages 安装 `font-noto-sans-cjk-sc`（brew cask，勿用 `font-noto-sans-cjk`——家族名无 SC 后缀不匹配），两端均加字重覆盖断言（100/300/350/400/500/700/900）阻断缺字与 `weight: "medium"` 静默回退；分页与基线不变（54 页）
- AGENTS.md 更新字体策略描述与文件地图

### Added（2026-09-21 重构轮）
- 画廊从九族扩为**十一族**：拆分「页面编排」→ 常规元素（show.basic）/ 表格与流程（show.tables）/ 区域编排（show.grid）；设计系统速查移至末位作参考附录
- show.grid 新增「复合网格·仪表盘」样例（rowspan 跨行 + 不等宽列 + 末行 1fr 锚定）与「感谢聆听·结尾页」语义点破（可作 Q&A/联系页，附 body-slide(center: true) 等价说明）
- lib.typ 新增公共导出 `leg-label`（图例字级降档 0.7em×0.8em≈11.9pt，自 show.charts.typ 迁入；API 清单 50 → 51）
- 中性化通用案例（借页即用）：show.cetz 研发迭代闭环（5 节点）+ PDCA 改进环（4 节点）替代 Agent/ReAct；⚠坑 补 CeTZ 坐标 cm 单位 / text() 不随坐标缩放 / 换内容手动对齐

### Changed（2026-09-21 重构轮）
- show.charts 示例数据由「借页元话题」换为通用主题（预算分布 / 区域季度营收 / 月度访问量）；变体速查页改 2 行 grid 修复底部图注对齐；leg-label 调用改引 lib.typ
- 设计系统：stat 默认 amount-size 34 → 30pt（低于 section-open 32pt，层级有序；show.data 显式传参同步）；section-open 左竖条 5 → 6pt（与卡片 3pt 形成粗细层级）；cover 标题 framableu → framableu.darken(4%)（与 header 同路径）；cmp-grid label-width 固定 5.2em → auto（measure 取最宽标签 + 1em padding，保留显式覆盖）；flow-steps 连接线 darken(15%) → `_connector-darken` 命名常量
- 美学打磨：八色卡页每张补功能描述文案示例；show.color jaune 色卡前景 framagrisdark → framagrisdarkest（对比 3.8:1 → ≈12:1）；show.system 字体层级页 stat 标注 34pt → 30pt
- 目录收紧：家族 9 → 11 使内容地图与 nav recipe 演示页的 11 行目录溢出，按文档化逐档技法（条目字号/竖条/行距/gutter）收回 1 页；页数基线 51 → 54，链接 51 → 59，用法注释 40 → 41

### Fixed（2026-09-21 重构轮）
- main.typ 家族计数注释三处自相矛盾（「十个家族」/「八族」/「八大族」）统一为十一族
- show.cetz PDCA 页右栏补第四步「改进」bullet，与四步环信息对等

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