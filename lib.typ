// lib.typ - 模版画廊设计系统库
// 供 main.typ 与 showcase/* 借页使用；版本 / API / 页数基线见 gates.json（lib 冻结，改动需独立评审）

// ==== API 地图 ====
// 门禁面 API 49 个，与 gates.json 的 api 清单一一对应（注释双胞胎）；另 4 个低阶
// token 公共导出不设门禁（gates 检查是 ⊇，加进去只有 churn 无保护）：framagris-soft /
// gutter-tight / gutter-primary / gutter-loose。
// 改 API 名（增删/改名）必须同步 gates.json 的 api 清单，否则 verify.py 会断言失败。
// —— 配色 18：framableu framableulight / framavert framavertlight / framarouge framarougelight /
//    framaviolet framavioletlight / framaorange framaorangelight / framajaune framajaunelight /
//    framamarron framamarronlight / framagris framagrislight / framagrisdark framagrisdarkest
// —— 强调文本 2：frameEmph alert
// —— 浅色卡片 8：boitebleue boiteverte boiterouge boiteorange boiteviolette boitejaune boitemarron boitegrise
// —— 强调色流转 3：accent-state slide-accent breadcrumb-state
// —— 数据元件 3：keyline note figure-block
// —— 间距体系 2：gap-primary gap-secondary
// —— 页面/内容件 3：body-slide stat boitefilled
// —— 表格替代语言 3：cmp-grid term-rows flow-steps
// —— 排版驱动器 5：stretch-grid slide-theme cetz-canvas section-open cover
// —— 图表 2：chart plot

// ── 页眉细线满宽常量（B10）────────────────────────────
// 页面内容区宽度 841.89 − 2×12.5pt（页眉左右 0.5em=12.5pt 内缩）≈ 816.9pt。
// ⚠ 探针实测（/tmp 自检）：header 区域内 layout(size => size.width) 返回值与
//   816.9pt 不恒等（isolated probe 816.89 / 真实 deck 820.64），且 `line(length:
//   100%)` 与 layout 包裹两种写法都会把细线渲染成 ≈56pt（place 内自噬宽度），
//   故保留原字面值作命名常量——渲染与旧 PDF 逐字节一致，零视觉差。
#let _header-line-width = 816.9pt

// ==== 字号阶梯 ====
// 绝对字号只在门面/数据件，正文一律 em 相对：
//   cover/section 标题 32pt · stat 数字 34pt · keyline 24pt（数据/门面绝对字号）
//   meta 9.5pt · 小号 10pt（meta/小字用点制）
//   正文 0.85em（main.typ 全局）· 图注 0.63em · 助文 0.75em（em 相对，随主题缩放任动）
// 新增数据件时，先看能否复用现有档位，别再引入第五档绝对字号。

#import "@preview/touying:0.7.4": *
#import themes.university: *
#import "@preview/cetz:0.5.2"
#import "@preview/cetz-plot:0.1.4"
#import "@preview/numbly:0.1.0": numbly

// cetz-plot 0.1.4 的两个命名空间：chart（饼图/柱状图等图表）与 plot（线性图等
// 绘图环境）。借页者 `#import "lib.typ": *` 后直接 #chart.piechart(...) /
// #plot.plot(...) 即可。
// ⚠ 这里刻意用 `#let` 再导出一层，而不是 `#import "...": chart, plot` 直接引名：
//   verify.py 的 api 门禁只认顶层 #let 导出（按 `^#let` 正则检索），直接引名会
//   让「API 地图 ↔ gates.json api 清单」这对双胞胎断连——门禁抓不到这两个符号。
#let chart = cetz-plot.chart
#let plot = cetz-plot.plot
// cetz / numbly 的模块绑定经顶层 import 亦为公共导出（showcase 画布内
// `#import cetz.draw: *` 依赖之）；刻意少一层封装、不设门禁；勿误删。

// ==== Framasoft 配色 ====
// 浅色现代基调：每种「原色」都配有同族浅色。
// 深色槽位：primary / secondary / tertiary / neutral / neutral-dark / neutral-darkest
// 浅色槽位：primary-light / secondary-light / tertiary-light / neutral-light / neutral-lightest
// 全部接入下方 config-colors(...)。

#let framableu = rgb("#0C5B7A")
#let framableulight = rgb("#1290B0")
// ⚠ 亮度断层：同族浅色中该对（blue/light）明度差最小，视觉上几乎同档，勿误当
//   『浅底大块背景』使用（对比优先用 framagrislight / 深色做浅卡）。
#let framavert = rgb("#8E9C48")
#let framavertlight = rgb("#E3EBC7")
#let framarouge = rgb("#CC2D18")
#let framarougelight = rgb("#F9BDBB")
#let framaviolet = rgb("#6A5687")
#let framavioletlight = rgb("#D3C5E8")
#let framaorange = rgb("#EB7239")
#let framaorangelight = rgb("#EBD1C5")
#let framajaune = rgb("#C4A81B")
#let framajaunelight = rgb("#FFEBB5")
#let framamarron = rgb("#A1887F")
#let framamarronlight = rgb("#D7CCC8")
#let framagris = rgb("#616161")
#let framagris-soft = rgb("#767676") // 助文灰：原生 figure/footnote 等次要文字的柔和档
#let framagrislight = rgb("#F5F5F5")
#let framagrisdark = rgb("#3E3E3E")
#let framagrisdarkest = rgb("#000000")

// ==== 强调文本（Framaorange 加粗；刻意保持「稀有、可选」）====
// alert = frameEmph 同义转发（单实现源）：frameEmph 供正文使用，alert 供 config-methods 绑定。
#let frameEmph(body) = text(fill: framaorange, weight: "bold", body)
#let alert(body) = frameEmph(body)

// ==== 浅色强调卡片（对应 \boiteXXX）====
// 左竖条(3pt) + 约 5%–8% 的极浅底色 + 无重边框 + 圆角 + 舒适内边距。
// 保留原有公共函数名与「单内容参数」签名。
// stretch: true 时返回「规格字典」而非内容：(cell: …, color: …, content: …)
// 或 (cell: "stat", …, amount: …, label: …)。这些字典只交给模板级
// stretch-grid(...) 排版 —— 它自动测量自然高度、按行取最大、生成等高网格
// （columns 传整数，无需 rows）；stat 的「大数字」锚定行垂直中心，行高取
// 2·T - A（T = 数字+间距+标签天然高，A = 数字行高），标签恰好以行底收口、
// 不溢出到下方内容。不使用 grid.cell（作为直接子元素才生效，被 context 包裹
// 会被吞掉）；boitefilled/stat 的 color: auto 在测量/渲染时按强调色解析。
// 浅色卡片视觉盒（左竖条语言常量唯一出处）：_boite 非 stretch 路径、
// stretch-grid（_spec-render / 测量）共用。数值红线：3pt 竖条 / lighten(93%) /
// 4pt 圆角 / inset (x:12pt, y:9pt) 逐字保持，勿漂移。
// - width: none → 自然宽（普通卡片）；传长度 → 定宽（stretch-grid 测量）。
// - fill-height: true → 满高拉伸盒 + 内盒 inset（stretch-grid 单元内渲染）。
#let _boite-box(content, color, width: none, fill-height: false) = {
  if fill-height {
    block(
      radius: 4pt,
      fill: color.lighten(93%),
      stroke: (left: (paint: color, thickness: 3pt)),
      width: 100%,
      height: 100%,
    )[#block(inset: (x: 12pt, y: 9pt))[#content]]
  } else {
    block(
      width: if width == none { auto } else { width },
      inset: (x: 12pt, y: 9pt),
      radius: 4pt,
      fill: color.lighten(93%),
      stroke: (left: (paint: color, thickness: 3pt)),
    )[#content]
  }
}

#let _boite(content, color: framableu, stretch: false) = {
  if stretch {
    // 交给 stretch-grid 排版：返回规格字典
    (cell: "boite", color: color, content: content)
  } else {
    _boite-box(content, color)
  }
}

#let boitebleue(content, stretch: false) = _boite(content, color: framableu, stretch: stretch)
#let boiteverte(content, stretch: false) = _boite(content, color: framavert, stretch: stretch)
#let boiterouge(content, stretch: false) = _boite(content, color: framarouge, stretch: stretch)
#let boiteorange(content, stretch: false) = _boite(content, color: framaorange, stretch: stretch)
#let boiteviolette(content, stretch: false) = _boite(content, color: framaviolet, stretch: stretch)
#let boitejaune(content, stretch: false) = _boite(content, color: framajaune, stretch: stretch)
#let boitemarron(content, stretch: false) = _boite(content, color: framamarron, stretch: stretch)
#let boitegrise(content, stretch: false) = _boite(content, color: framagris, stretch: stretch)

// ==== 排版层级 ====
// 在 0.85em 正文（≈21pt）之上叠加可复用层级：
//   二级标题（heading level 2，show 规则见 main.typ）≈ 1.5em —— 每页大标题
//   keyline（金句行）      24pt   —— 每页主结论
//   正文页骨架：body-slide —— keyline 结论 → 主体 → 收尾，间距统一收口
//   stat（大数字）         amount-size —— 数据可视化数字
//   note（附注）           0.75em 灰色  —— 澄清 / 出处
//
// 每页强调色：用 #slide-accent(色值) 声明；之后本页的二级标题、keyline、
// stat、boitefilled 会自动沿用该色，也可用 color: 参数逐处覆盖。
//
// ⚠ 放置位置（Touying 分页注意）：请把 #slide-accent(...) 写在「上一页内容的
//   末尾」作为收尾声明。若把它放在某页 `==` 标题之前（包括 section 标题之后），
//   Touying 会在两页之间凭空多插一页空页。每章第一页可省略声明——直接沿用
//   上一章末尾留下的颜色（全书默认 framableu）。

/// 全局强调色状态（默认 framableu）。
/// 仅供内部使用；页面请调用 slide-accent 声明强调色。
#let accent-state = state("slide-accent", framableu)

/// 设置当前页/当前章强调色。
/// - color (color): 强调色色值，如 framaorange / framaviolet。
///   声明后，后续 keyline、stat、boitefilled 与二级标题自动采用该色。
/// ⚠ 请写在「上一页末尾」；写在 `==` 标题前会多出一页空页。
#let slide-accent(color) = accent-state.update(color)

/// 面包屑状态：内页右上角显示的「当前章 / 分段」短标签。
/// 由 `section-open(...)` 开场页写入（如「第 2 章 · 上下文工程」），
/// 普通内页的 header-right 只读取；未设置时（none）不渲染任何东西。
#let breadcrumb-state = state("breadcrumb", none)

/// keyline —— 金句行：大号、加粗、居中的主结论。
/// - body (content): 结论文本。
/// - color (color, auto): 文字色；默认 auto = 跟随当前强调色。
/// - size (length): 字号，默认 24pt。
/// 示例：#keyline[上下文决定能力上限]
#let keyline(body, color: auto, size: 24pt) = {
  let use-accent = color == auto
  context {
    let c = if use-accent { accent-state.get() } else { color }
    block(breakable: false)[
      #align(center, text(size: size, weight: "bold", fill: c)[#body])
    ]
  }
}

/// note —— 附注行：小号灰字，用于澄清、出处与补充说明。
/// - body (content): 附注文本。
/// - color (color): 文字色，默认 framagris。
/// 示例：#note[细节见第 8 章]
#let note(body, color: framagris) = text(size: 0.75em, fill: color)[#body]

// ==== 图像与图注 ====
/// 图像＋图注的组合块：图与图注共享同一宽度与左缘，图注紧贴图下沿。
/// - img (content): `image(...)` 调用，**调用处不要写 width**——块内 set(100%) 接管。
/// - caption (content, none): 图注文本，自由 content（保留手写"图 1："风格）；none 则无注。
/// - width (length/ratio): 图与图注共享宽度，默认 88%。
/// - gap (length): 图↔图注间距，默认 0.12em（正文 21.25pt ≈2.5pt；em 随正文等比缩放）。
/// - caption-size (length): 图注字号，默认 0.63em。
/// - caption-color (color): 图注颜色，默认 framagris。
/// ⚠ 与原生 figure 是两条路：本例不自动编号、不进目录；原生 figure/footnote 样式按需自行声明。
#let figure-block(
  img,
  caption: none,
  width: 88%,
  gap: 0.12em,
  caption-size: 0.63em,
  caption-color: framagris,
) = [
  #block(width: width)[
    #set image(width: 100%)
    #img
  ]
  #if caption != none [
    #v(gap)
    #block(width: width)[
      #text(size: caption-size, fill: caption-color)[#caption]
    ]
  ]
]

// ==== 正文页骨架模板 + 节奏间距 ====
// 页面级留白只有两种节奏源：gap-primary（主节奏：keyline 后 / 收尾前）与
// gap-secondary（次级节奏：主体内段间，如公式↔网格、网格↔列表）。
#let gap-primary = 0.3em
#let gap-secondary = 0.4em

// 网格 gutter 三档（stretch-grid 默认取 primary；按页面密度选 tight / loose）
#let gutter-tight = 0.6em
#let gutter-primary = 0.8em
#let gutter-loose = 1em

/// body-slide —— 标准正文页骨架：keyline 结论 → 主体 → 收尾。
/// - kicker (content, none): 页面主结论行，交给 keyline 渲染；省略则无结论行。
/// - inner (content): 主体内容（stretch-grid / 列表 / 双栏网格 / 公式块…）。
/// - closing (content, none): 收尾块（note / boitefilled / boiteXXX / 自定义内容），省略则无。
/// - gap (length): keyline 与主体之间的留白，默认 gap-primary；刻意紧凑的整页可传 0pt。
/// - closing-gap (length): 收尾块前的留白，默认同 gap-primary。
/// - center (bool): true 时 inner [+ closing] 在 kicker 下方的剩余空间内垂直居中
///   （kicker 保持顶部锚定，不参与居中）；默认 false 保持顶对齐。
/// 用法：
///   #body-slide(
///     kicker: [结论],
///     inner: [#stretch-grid(columns: 3, gutter: 1em, …)],
///     closing: note[附注],
///   )
#let body-slide(
  kicker: none,
  inner: none,
  closing: none,
  gap: gap-primary,
  closing-gap: gap-primary,
  center: false,
) = {
  if center {
    // 垂直居中模式（kicker 顶锚 + inner[+closing] 居中）：
    // kicker 保持顶部锚定（v(gap) 仍在其下方），不参与居中。
    // inner[+closing] 在 kicker 下方的剩余空间内用 v(1fr)/v(1fr) 上下居中。
    // 两个 1fr 均分剩余高度，由排版器在真实布局里自适应任何内容高；
    // 内容超高时 fr 收缩到 0（永不引入溢出）。
    // ⚠ v(1fr)/v(1fr) 优于 measure 测量法（解决目录页 outline 条目塌缩），
    //   详情见 9 月 commit 注释。
    [#if kicker != none [#keyline[#kicker] #v(gap)]
      #v(1fr)
      #inner
      #if closing != none [#v(closing-gap) #closing]
      #v(1fr)]
  } else {
    [#if kicker != none [#keyline[#kicker] #v(gap)]
      #inner
      #if closing != none [#v(closing-gap) #closing]]
  }
}

// 大数字盒（数据元件常量唯一出处）：bold 大数字 / 0.14em 数字↔标签间距 /
// 0.8em framagris 灰标签。返回规格字典供 stat 三路径消费：
// - amt          → 数字单行（stretch 渲染 / 测量单独 measure 数字行高 A）
// - stack        → 双居中列（stretch 渲染的 layout 内容、测量 T 用）
// - stack-single → 单居中列（plain 渲染：整列作为一个居中单元，与双居中视觉不同）
// 数值红线：0.14em / 0.8em framagris 逐字保持，勿漂移。
// ⚠ ① color 需已解析（调用方在 context 内处理 accent-state）——纯函数不能取 state；
//   ② 测量用的 T/A 长度无法借 context/layout 表达式传出（它们只产出 content），
//   故长度计算保留在调用方的 context 块内，_stat-box 只提供结构 dict。
#let _stat-box(amount, label, color, amount-size: 34pt) = (
  amt: text(size: amount-size, weight: "bold", fill: color)[#amount],
  stack-single: [
    #align(center)[
      #text(size: amount-size, weight: "bold", fill: color)[#amount]
      #v(0.14em)
      #text(size: 0.8em, fill: framagris)[#label]
    ]
  ],
  stack: [
    #align(center)[
      #text(size: amount-size, weight: "bold", fill: color)[#amount]
    ]
    #v(0.14em)
    #align(center)[#text(size: 0.8em, fill: framagris)[#label]]
  ],
)

/// stat —— 大数字：超大强调色数字 + 灰色小标签。
/// - amount (content): 大数字本体，可传字符串或数学内容。
/// - label (content): 数字下方的灰色解释。
/// - amount-size (length): 数字字号，默认 34pt。
/// - color (color, auto): 数字色；默认 auto = 跟随当前强调色。
/// 示例：#stat[10][正文章节]
/// 带定制：#stat(amount-size: 40pt, color: framaviolet, [10], [正文章节])
#let stat(amount, label, amount-size: 34pt, color: auto, stretch: false) = {
  if stretch {
    // 交给 stretch-grid 排版：返回规格字典（color 保留 auto，渲染时按强调色解析）
    (cell: "stat", amount-size: amount-size, color: color, amount: amount, label: label)
  } else {
    context {
      let c = if color == auto { accent-state.get() } else { color }
      let d = _stat-box(amount, label, c, amount-size: amount-size)
      block(breakable: false)[#d.stack-single]
    }
  }
}

// 中明度裸色发虚守卫：framajaune / framavert / framaorange / framamarron 底色配白字
// 对比不足，自动垫深 28%；其余颜色（深色原色、已显式垫深、auto 解析色）原样不动。
#let _mid-tone-darken(c) = if c == framajaune or c == framavert or c == framaorange or c == framamarron {
  c.darken(28%)
} else {
  c
}

// 实色卡片视觉盒（boitefilled 非 stretch 路径、stretch-grid 渲染与测量共用）：
// 白字 + 4pt 圆角 + inset (x:12pt, y:9pt)；color: auto 在渲染/测量时按强调色解析，
// 解析结果再过 _mid-tone-darken 发虚守卫（两分支共用同一 c，单点生效）。
// 数值红线：rgb("#FFFFFF") / 4pt / 12×9 逐字保持，勿漂移。
#let _filled-box(content, color, width: none, fill-height: false) = {
  context {
    let c = _mid-tone-darken(if color == auto { accent-state.get() } else { color })
    if fill-height {
      block(
        width: 100%,
        height: 100%,
        radius: 4pt,
        fill: c,
      )[
        #block(inset: (x: 12pt, y: 9pt))[
          #text(fill: rgb("#FFFFFF"))[#content]
        ]
      ]
    } else {
      block(
        width: if width == none { auto } else { width },
        inset: (x: 12pt, y: 9pt),
        radius: 4pt,
        fill: c,
      )[
        #text(fill: rgb("#FFFFFF"))[#content]
      ]
    }
  }
}

/// boitefilled —— 实色填充卡片（boite 系列的对偶变体）：
/// 底色为强调色、内容为白字，适合放「结论 / 高反差」信息。
/// 中明度裸色（framajaune / framavert / framaorange / framamarron）自动垫深
/// 28%（_mid-tone-darken 发虚守卫）；若想硬控，直接传已垫深色（如 framaorange.darken(28%)）。
/// - content (content): 卡片内容。
/// - color (color, auto): 填充色；默认 auto = 跟随当前强调色。
/// 示例：#boitefilled[*结论* 缺工具定义 → 行动归零]
#let boitefilled(content, color: auto, stretch: false) = {
  if stretch {
    // 交给 stretch-grid 排版：返回规格字典（color 保留 auto，渲染时按强调色解析）
    (cell: "filled", color: color, content: content)
  } else {
    _filled-box(content, color)
  }
}

// ==== stretch-grid：自动等高卡片网格模板 ====
/// stretch-grid —— 自动等高卡片网格模板（stretch 卡片的排版器，通用格式）。
/// - ..cells: 由 boiteXXX / boitefilled / stat（stretch: true）产生的规格字典。
/// - columns: 列数（整数，各列等分）。
/// - row-gutter / column-gutter: 行/列间距；传 gutter 时二者同用该值。
/// 自动测量各格自然高度、按行取最大 → 等高网格（无需手动 rows）。
/// stat 行高取 2·T - A（T: 数字+间距+标签天然高；A: 数字行高），使「大数字」
/// 锚定行垂直中心、标签恰好以行底收口（零溢出，不与下方内容相碰）。
///
/// 用法（通用格式：stretch: true 返回规格字典 → stretch-grid 排版）：
///   #stretch-grid(columns: 3, gutter: 1em,
///     boitebleue(stretch: true)[…],
///     boiteverte(stretch: true)[…],
///     boiteorange(stretch: true)[…])
///
///   #stretch-grid(columns: 2, gutter: 0.7em,
///     stat(amount-size: 30pt, stretch: true)[48k][规模],
///     stat(amount-size: 30pt, color: framaorange, stretch: true)[4][语言])
///
///   #stretch-grid(columns: 5, row-gutter: 0.5em, column-gutter: 0.6em,
///     boitefilled(color: framableu, stretch: true)[…],
///     boitefilled(color: framaorange, stretch: true)[…], …)
#let _spec-render(cell) = {
  if cell.cell == "boite" {
    _boite-box(cell.content, cell.color, fill-height: true)
  } else if cell.cell == "filled" {
    _filled-box(cell.content, cell.color, fill-height: true)
  } else if cell.cell == "stat" {
    // 数字锚定行垂直中心，标签流在数字下方（行高由 stretch-grid 保证收口）
    // ⚠ layout 必须处于 context 体内（block 内容位），block 在外层——反序会报 unknown variable
    block(width: 100%, height: 100%)[
      #context {
        let c = if cell.color == auto { accent-state.get() } else { cell.color }
        let d = _stat-box(cell.amount, cell.label, c, amount-size: cell.amount-size)
        let A = measure(d.amt).height
        layout(size => [
          #v((size.height - A) / 2)
          #d.stack
        ])
      }
    ]
  } else {
    cell
  }
}

#let stretch-grid(..cells, columns: 1, row-gutter: gutter-primary, column-gutter: gutter-primary, gutter: none) = layout(size => {
  let arr = cells.pos()
  assert(arr.len() > 0, message: "stretch-grid 需要至少一个格")
  let ncols = columns
  let nrows = int(calc.ceil(arr.len() / ncols))
  context {
    let rg = (if gutter == none { row-gutter } else { gutter}).to-absolute()
    let cg = (if gutter == none { column-gutter } else { gutter}).to-absolute()
    let cw = (size.width - (ncols - 1) * cg) / ncols
    let row-heights = ()
    for row in range(nrows) {
      let row-max = 0pt
      for col in range(ncols) {
        let cell = arr.at(row * ncols + col, default: none)
        if cell != none and type(cell) == dictionary {
          let h = if cell.cell == "boite" {
            measure(_boite-box(cell.content, cell.color, width: cw)).height
          } else if cell.cell == "filled" {
            measure(_filled-box(cell.content, cell.color, width: cw)).height
          } else if cell.cell == "stat" {
            let c = if cell.color == auto { accent-state.get() } else { cell.color }
            let d = _stat-box(cell.amount, cell.label, c, amount-size: cell.amount-size)
            let A = measure(d.amt).height
            let T = measure(block(width: cw, breakable: false)[#d.stack]).height
            T * 2 - A
          } else {
            0pt
          }
          row-max = calc.max(row-max, h)
        }
      }
      row-heights.push(row-max)
    }
    grid(
      columns: (cw,) * ncols,
      rows: row-heights,
      row-gutter: rg,
      column-gutter: cg,
      ..arr.map(cell => if type(cell) == dictionary { _spec-render(cell) } else { cell }),
    )
  }
})

// ==== 表格替代语言 ====
// 替代裸 #table（灰细线）为有设计在场的组件。分类映射：
//   对比型（维度×两侧） → cmp-grid（维度标签 + 双色对比单元格）
//   枚举型（名称→说明） → term-rows（术语行）或 stretch-grid 卡片
//   流程型（编号步骤）   → flow-steps（编号药丸 + 箭头流程条）
// 视觉红线（均在既有卡片语言内）：4pt 圆角 / 3pt 左竖条 / lighten(93%) 浅底；
// 对比单元格去掉卡片级 12×9 内边距、降为更紧凑的 (x:10pt, y:4pt)（单元格是
// 内容节奏，不是信息卡；避免 5 行对比页堆高）；内容对齐规则见 _cmp-cell（单行
// 居中 / 多行左对齐——修「左栏短值在宽格里右侧留白失衡」的模板级根治）。

// 编号药丸（内部件）：实色小圆角胶囊 + 白字编号；中明度色自动垫深。
// 用法: #_pill(1, framableu, size: 0.72em)
// 改这里: 第 1 个参数 = 编号文本，第 2 个 = 颜色，size = 字号。
// ⚠ 坑: 内部组件，不对画廊公开；仅由 _flow-step-box / flow-steps 调用。
#let _pill(n, c, size: 0.72em) = rect(
  radius: 0.9em,
  fill: _mid-tone-darken(c),
  stroke: none,
  inset: (x: 0.5em, y: 0.2em),
)[#text(size: size, weight: "bold", fill: rgb("#FFFFFF"))[#n]]

// 对比/术语单元格（内部件）：紧凑档浅底左竖条盒，供 cmp-grid / term-rows 使用。
// 对齐规则（审美裁量）：单行内容水平居中——左栏短值（如 `ls`、`指令措辞`）在
// 宽单元格里不再右侧留白过大，两列读起来平衡；多行内容保持左对齐（居中段落
// 阅读观感差）。检测：以可用宽与 999pt 超宽各 measure 一次，高度无变化即未换行
// → 居中；换行（多行）→ 左对齐。y inset 5pt→4pt 为配合溢出页减高。
// 用法: #_cmp-cell[文本], color: framableu, width: 100%
// 改这里: content = 单元格文本，color = 强调色，width = 可用宽（stretch 传 100%）。
// ⚠ 坑: 单元格只放无副作用纯行内文本；硬换行/多段/宽度依赖内容会使对齐启发式误判
//       （单行居中判据失效）。
#let _cmp-cell(content, color, width: none) = block(
  width: if width == none { auto } else { width },
  inset: (x: 10pt, y: 4pt),
  radius: 4pt,
  fill: color.lighten(93%),
  stroke: (left: (paint: color, thickness: 3pt)),
)[
  #context {
    layout(size => {
      let one = measure(block(width: 999pt, breakable: false)[#content]).height
      let wrap = measure(block(width: size.width, breakable: false)[#content]).height
      if wrap <= one * 1.3 {
        align(center)[#content]
      } else {
        content
      }
    })
  }
]

/// cmp-grid —— 对比网格：左侧灰色维度标签列 + 双色值单元格，替代「维度×两侧」对比表。
/// - lhs / rhs (dictionary): 左/右栏 (title: 栏标题, color: 强调色)；title 为 none 时省略表头行。
/// - rows (array of dictionary): 每行 (label: 维度名, left: 左值, right: 右值)。
/// - label-width (length): 维度标签列宽，默认 5.2em；标签长时按需加宽。
/// - gutter (length): 列间距，默认 gutter-tight。
/// - row-gap (length): 行间距，默认 0.25em。
/// - header-gap (length): 表头↔首行间距，默认 0.4em。
/// 用法：
///   #cmp-grid(
///     lhs: (title: [观察空间], color: framableu),
///     rhs: (title: [动作空间], color: framaorange),
///     rows: (
///       (label: [内容], left: [上下文窗口、知识库], right: [工具调用、代码生成]),
///     ),
///   )
#let cmp-grid(
  lhs: none,
  rhs: none,
  rows: (),
  label-width: 5.2em,
  gutter: gutter-tight,
  row-gap: 0.25em,
  header-gap: 0.4em,
) = context {
  assert(lhs != none and rhs != none, message: "cmp-grid 需要 lhs 与 rhs")
  let ltitle = lhs.at("title", default: none)
  let rtitle = rhs.at("title", default: none)
  let a = if lhs.at("color", default: auto) == auto { accent-state.get() } else { lhs.at("color", default: auto) }
  let b = if rhs.at("color", default: auto) == auto { accent-state.get() } else { rhs.at("color", default: auto) }
  let has-head = ltitle != none and rtitle != none
  let head = if has-head {
    grid(
      columns: (label-width, 1fr, 1fr),
      column-gutter: gutter,
      [],
      _filled-box(align(center)[#text(weight: "bold")[#ltitle]], a, width: 100%),
      _filled-box(align(center)[#text(weight: "bold")[#rtitle]], b, width: 100%),
    )
  } else { [] }
  let body = grid(
    columns: (label-width, 1fr, 1fr),
    column-gutter: gutter,
    row-gutter: row-gap,
    ..rows.map(row => (
      align(horizon + right)[#text(size: 0.78em, weight: "bold", fill: framagris)[#row.at("label")]],
      _cmp-cell(row.at("left"), a, width: 100%),
      _cmp-cell(row.at("right"), b, width: 100%),
    )).flatten(),
  )
  [
    #head
    #if has-head [#v(header-gap)]
    #body
  ]
}

/// term-rows —— 术语行：左侧名称列 + 右侧单色值单元格，替代「名称→说明」枚举表。
/// - rows (array of dictionary): 每行 (label: 名称, value: 说明, color: auto 可选逐行主色)。
/// - label-width (length): 名称列宽，默认 7em。
/// - gutter (length): 列间距，默认 gutter-tight。
/// - row-gap (length): 行间距，默认 0.25em。
/// 用法：
///   #term-rows(rows: (
///     (label: [保存经历], value: [日志记录（仅是数据）]),
///     (label: [持续进化], value: [跨任务积累，改变后续行为]),
///   ))
#let term-rows(
  rows: (),
  label-width: 7em,
  gutter: gutter-tight,
  row-gap: 0.25em,
) = context {
  assert(rows.len() > 0, message: "term-rows 需要至少一行")
  grid(
    columns: (label-width, 1fr),
    column-gutter: gutter,
    row-gutter: row-gap,
    ..rows.map(row => (
      align(horizon + right)[#text(size: 0.78em, weight: "bold", fill: framagrisdark)[#row.at("label")]],
      _cmp-cell(
        row.at("value"),
        if row.at("color", default: auto) == auto { accent-state.get() } else { row.at("color") },
        width: 100%,
      ),
    )).flatten(),
  )
}

// flow-steps 单步（内部件）。
// 横向（compact: true）＝步骤卡：编号药丸 + 标题 + 说明，浅底左竖条语言；
// 纵向（compact: false）＝时间线行：左轨药丸 + 下箭头，右列标题 + 说明（无卡片盒，
// 步骤长文场景靠低矮行高控制页高，与横向卡的视觉强度形成层级差）。
#let _flow-step-box(s, n, width, compact: true, last: true) = {
  let c = s.at("color", default: auto)
  let title = s.at("title", default: none)
  let desc = s.at("desc", default: none)
  context {
    let col = if c == auto { accent-state.get() } else { c }
    if compact {
      block(
        width: width,
        inset: (x: 8pt, y: 8pt),
        radius: 4pt,
        fill: col.lighten(93%),
        stroke: (left: (paint: col, thickness: 3pt)),
      )[
        #align(center)[#_pill(n, col)]
        #if title != none [
          #v(0.4em)
          #align(center)[#text(size: 0.9em, weight: "bold", fill: col.darken(10%))[#title]]
        ]
        #if desc != none [
          #v(0.25em)
          #text(size: 0.74em, fill: framagris)[#desc]
        ]
      ]
    } else {
      // 纵向时间线行：左轨药丸 + 下箭头；右列标题 + desc 水平同行。
      // 用户要求描述与关键词在同一水平线（如「拆解 · 原始数据清洗」），不走换行。
      grid(
        columns: (auto, 1fr),
        column-gutter: 0.9em,
        [
          #align(center)[#_pill(n, col)]
          #if not last [
            #v(0.25em)
            #align(center + horizon)[#text(size: 0.9em, fill: col.darken(15%))[⬇]]
          ]
        ],
        [
          #text(size: 0.92em, weight: "bold", fill: col.darken(10%))[#title]
          #if desc != none [
            #h(0.3em)
            #text(size: 0.76em, fill: framagris)[· #desc]
          ]
        ],
      )
    }
  }
}

/// flow-steps —— 编号流程条：药丸编号 + 标题/说明 + 箭头，替代「步骤」枚举表。
/// - ..steps (positional dictionaries): 每步 (title, desc: none, color: auto)。
/// - dir (string): "row" 横向（→ 连接）或 "col" 纵向（↓ 连接）。
/// - arrow-w (length): 横向模式箭头列宽，默认 1.5em。
/// - row-gap (length): 纵向模式行间距，默认 0.25em。
/// 用法：
///   #flow-steps(
///     (title: [工具声明], desc: [JSON Schema 参数格式], color: framableu),
///     (title: [模型决策], desc: [选工具并生成参数], color: framavert),
///     (title: [执行], desc: [校验 + 调用 + 捕获], color: framaorange),
///   )
/// 改这里: 每步 = (title, desc, color)；dir 控制横向/纵向。
/// ⚠ 坑: 纵向模式行高被药丸+↓字形度量锁死 ≈61.5pt/行；建议步骤 ≤5，≥5 步时
///       单步说明 ≤3 行，长文转横向模式或 desc: none，否则静默溢出。
#let flow-steps(..steps, dir: "row", arrow-w: 1.5em, row-gap: 0.25em) = {
  let arr = steps.pos()
  assert(arr.len() > 0, message: "flow-steps 需要至少一个步骤")
  let n = arr.len()
  if dir == "row" {
    layout(size => {
      let step-w = (size.width - (n - 1) * arrow-w) / n
      let widths = ()
      let cells = ()
      for i in range(n) {
        widths.push(step-w)
        if i < n - 1 { widths.push(arrow-w) }
        cells.push(_flow-step-box(arr.at(i), i + 1, step-w, compact: true))
        if i < n - 1 {
          cells.push(align(center + horizon)[#text(size: 0.85em, fill: framagris)[#sym.arrow.r]])
        }
      }
      grid(columns: widths, column-gutter: 0pt, ..cells)
    })
  } else {
    stack(
      dir: ttb,
      spacing: 0pt,
      ..range(n).map(i => [
        #_flow-step-box(arr.at(i), i + 1, 100%, compact: false, last: i == n - 1)
        #if i < n - 1 [#v(row-gap)]
      ]),
    )
  }
}

// ==== 主题配置 ====
#let slide-theme = university-theme.with(
  aspect-ratio: "16-9",
  // 纵向留白：页眉固定在页面顶端（它的高度不影响正文位置），因此正文上边距
  // 只能靠 page margin.top 调整。这里把 top 从主题默认的 2em 提到 2.7em，
  // 让每页 `==` 标题与正文首行之间多出约 0.7em（≈15pt）的呼吸空间，正文不再
  // 顶到标题下方的强调条。top 增加会压缩正文可用高度，故把 bottom 从 1.25em
  // 收到 0.75em 补偿（页脚色块固定占底部 12.8pt，0.75em≈15.9pt 仍留有余量），
  // 保证全册页数不变。x 保持不变。
  config-page(margin: (top: 2.7em, bottom: 0.75em, x: 2em)),
  // 关闭 `=` 自动生成的章节分隔页：改由内容里显式调用的 section-open(...) 接管，
  // 这样开场页样式、序号与面包屑都由我们控制（详见 section-open）。
  config-common(new-section-slide-fn: none),
  // 内页标题（Touying 把 `==` 标题移到页眉 header 渲染，正文里不出现）。
  // v2：由「1.5em 大横幅」收敛为紧凑的「主题标签」——1.1em 粗体 + 0.9pt 短基线，
  // 让每页主题读起来是安静的小标签，而不是重复的标题条。强调色跟随 accent-state。
  // v2.1 版式修正：删除标题下 0.9pt 短横线（曾落入右侧面包屑的文字带、彼此重叠）；
  // 改为占满左格宽的块 + 块底边停靠的整行下沿细线（0.8pt 浅章色），面包屑始终
  // 在这条线之上，二者不再重叠。顶部进度条（progress-bar）保持不变。
  // 注：主题页眉把左侧内容包在 text(size: 1.2em) 里，故此处 1.1em ≈ 28pt。
  header: utils.display-current-heading(
    level: 2,
    style: (setting: none, numbered: true, current-heading) => {
      context {
        let c = accent-state.get()
        let c-head = c.darken(4%) // 加深一档，保证白底对比
        // 左格块只承载标题文字；下方细线用「固定长度 + 锚定块左下」画出，
        // 使其独立于网格列宽（不再因右侧面包屑而缩短）。细线长度取顶部常量
        // _header-line-width（B10：值 816.9pt 由 841.89 − 2×12.5 推导，逐字节
        // 保留原渲染）。这样无论当页有无面包屑，线与线长一致，且始终整条落在
        // 「标题+面包屑」之下，二者不再重叠。
        block(breakable: false)[
          #text(size: 1.1em, weight: "bold", fill: c-head)[#current-heading.body]
          #place(bottom + left, dy: 0.4em, line(length: _header-line-width, stroke: (paint: c.lighten(65%), thickness: 0.8pt)))
        ]
      }
    },
  ),
  // 右上角面包屑：读取 section-open 写入的当前章/分段标签（小灰字）。
  // 为 none 时整段不渲染，不留空位、不画线。
  header-right: self => context {
    let crumb = breadcrumb-state.get()
    if crumb != none {
      h(0.4em)
      text(size: 0.7em, fill: framagris)[#crumb]
    }
  },
  config-colors(
    primary: framableu,
    primary-light: framableulight,
    secondary: framavert,
    secondary-light: framavertlight,
    tertiary: framaorange,
    tertiary-light: framaorangelight,
    neutral: framagris,
    neutral-light: framagrislight,
    neutral-lightest: rgb("#FFFFFF"),
    neutral-dark: framagrisdark,
    neutral-darkest: framagrisdarkest,
  ),
  config-methods(
    alert: (self: none, it) => text(fill: framaorange, weight: "bold", it),
  ),
  // 注：deck 专属元数据（书名/作者/日期）不属于设计系统，已移出 lib——
  // 由每份 deck 的 main.typ 通过 slide-theme.with(config-info(...)) 自行声明。
)

// ==== CeTZ 与 Touying 的动画绑定 ====
#let cetz-canvas = touying-reducer.with(
  reduce: cetz.canvas,
  cover: cetz.draw.hide.with(bounds: true),
)

// ==== 区域编排 grid-slide（v2.0）====

/// grid-slide —— 区域编排页骨架（v2.0）
///
/// 按行列网格划分页面，内容依次填入每个格子 —— 先定格局，后填内容。
/// 格子按行优先顺序从 positional args 读取，网格维度由 columns/rows 决定。
/// 支持 Typst 原生 grid.cell(colspan:, rowspan:) 在任意格子上声明跨步。
///
/// - columns (list of relative/lengths): 列宽定义，如 (1fr, 1fr) 均分两列、
///   (1.5fr, 1fr) 偏左、(3em, 1fr, 1fr) 固定宽首列。默认 (1fr)。
/// - rows (list of relative/lengths): 行高定义，默认 (auto, 1fr)。
///   末行 1fr 撑满剩余页面空间（底部锚定）；单行 (1fr) 填充整页。
/// - gutter (length): 区域间距，默认 gutter-primary；内部映射到 Typst grid
///   的 column-gutter 与 row-gutter（grid 不直接接受 gutter: 参数）。
/// - align (tuple): 格子内内容的默认对齐，默认 (center, top)；可传 (left, top) 等。
/// - center (bool): true 时整张网格在页面正文区内垂直居中（等价 body-slide center
///   的双 v(1fr) 方案；kicker 无——用 #keyline 放网格内区域即可）。默认 false。
/// - ..cells (positional, content): 按行优先顺序依次填入格子的内容。
///   格子数必须 ≤ columns×rows；不足时剩余格子留空；超过时报错。
///   需要跨步时在对应格子上用 grid.cell(colspan: 2, rowspan: 1)[...] 包裹。
///
/// 用法：
///   #grid-slide(
///     columns: (1fr, 1fr),
///     rows: (auto, 1fr),
///     gutter: gutter-primary,
///     align: (left, top),
///     // cell(1,1)
///     [
///       #image("assets/sample-scheme.svg", height: 3em)
///       #text(size: 0.76em, fill: framagris)[系统架构概览]
///     ],
///     // cell(1,2)
///     [
///       #keyline[核心特性]
///       * 弹性伸缩
///       * 自动容错
///       * 声明式 API
///     ],
///     // cell(2,1-2)：通栏底部（colspan: 2）
///     grid.cell(colspan: 2)[
///       #grid(columns: (1fr, 1fr, 1fr), gutter: gutter-tight,
///         [图一], [图二], [图三]
///       )
///     ],
///   )
#let grid-slide(
  columns: (1fr,),
  rows: (auto, 1fr),
  gutter: gutter-primary,
  align: (center, top),
  center: false,
  ..cells,
) = {
  let arr = cells.pos()
  let expect = columns.len() * rows.len()
  assert(arr.len() <= expect, message: "grid-slide: 内容格子数超过 grid 容量 (" + str(expect) + ")")
  let g = grid(
    columns: columns,
    rows: rows,
    column-gutter: gutter,
    row-gutter: gutter,
    ..arr,
  )
  if center {
    // 中心对齐：双 v(1fr) 方案复用 body-slide center 自验的排版方式，
    // 见 body-slide center 注释（优于 measure 测量法）。
    [#v(1fr) #align(align, g) #v(1fr)]
  } else {
    align(align, g)
  }
}

// ==== 封面（title slide）====
// 全宽白画布包装：封面与开场页共用（隐藏主题 header/footer、白底、同一边距）。
// 视觉区分在各自 body 内：封面 = 左侧渐变面板 + 大图形；开场页 = 左竖条 +
// 右下角大序号/色块 + 顶部细线。放在任何位置都会自成一张 slide。
#let _full-page(body) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(self, config-page(
    header: none,
    footer: none,
    fill: rgb("#FFFFFF"),
    margin: (x: 2.4em, y: 1.8em),
  ))
  touying-slide(self: self, body)
})

// ==== 章节 / 分段开场页（opener，v2）====

/// section-open —— 章节/分段开场页。
/// - title (content): 大标题（章名或分段名，如 [上下文工程] / [核心公式]）。
/// - subtitle (content, none): 灰色副标题一行。
/// - index (content, none): 大号序号；书章节传 [2]，内容分段省略（none）。
/// - color (color, auto): 强调色；默认 auto = 沿用当前 accent-state。
///
/// 副作用（关键）：开场页会把本段强调色写入 accent-state，并把面包屑
/// （章节=「第 N 章 · 标题」，分段=标题）写入 breadcrumb-state，
/// 供后续内页的紧凑标题与右上角面包屑自动沿用。
///
/// 用法：
///   书章节： #section-open(index: [2], title: [上下文工程], subtitle: [...], color: framavert)
///   内容段： #section-open(title: [核心公式], subtitle: [...], color: framableu)
/// ⚠ 开场页须紧跟在 `=` 标题之后、该段第一个 `==` 之前；它自成一张 slide。
// 注：Typst 中无默认值的参数只能按位置传；为支持 section-open(title: ...) 的
// 具名调用，title 给默认 none 并在缺失时报错。
#let section-open(title: none, subtitle: none, index: none, color: auto) = {
  assert(title != none, message: "section-open 需要一个 title")
  let use-accent = color == auto
  let crumb = if index != none { [第 #index 章 · #title] } else { title }
  // ⚠ touying-slide-wrapper 不能放在 context 内；故 context 只包在 body 内。
  _full-page(context {
    let c = if use-accent { accent-state.get() } else { color }
    accent-state.update(c)
    breadcrumb-state.update(crumb)
    [
      // 左侧强调竖条（贯穿内容区）
      #place(left, block(width: 5pt, height: 100%, fill: c))
      // 顶部细线
      #place(top + left, dx: 0pt, dy: 0pt, line(length: 100%, stroke: (paint: c.lighten(68%), thickness: 0.8pt)))
      // 右下角装饰：章节用超淡大号序号；分段用超淡圆角色块 + 小实色方块
      #if index != none {
        place(bottom + right, dx: 0.1em, dy: 0.2em,
          text(size: 170pt, weight: "bold", fill: c.lighten(80%))[#index])
      } else {
        place(bottom + right, dx: 0.2em, dy: 0.3em,
          rect(width: 4.6em, height: 4.6em, radius: 0.5em, fill: c.lighten(87%), stroke: none))
        place(bottom + right, dx: 1.5em, dy: 1.6em,
          rect(width: 0.7em, height: 0.7em, radius: 1pt, fill: c, stroke: none))
      }
      // 文本块：kicker 面包屑 / 大标题 / 副标题 / 短色条
      #place(left + horizon, dx: 1.8em, dy: 0pt, block(width: 70%)[
        #text(size: 10pt, weight: "medium", fill: c, tracking: 0.2em)[#crumb]
        #v(0.7em)
        #text(size: 32pt, weight: "bold", fill: c.darken(6%))[#title]
        #if subtitle != none [
          #v(0.7em)
          #text(size: 13.5pt, fill: framagris)[#subtitle]
        ]
        #v(0.9em)
        #line(length: 3.4em, stroke: (paint: c, thickness: 2pt))
      ])
    ]
  })
}

// 封面共享小工具：大标题 / meta 行 / meta 区块（含细分隔线）
#let _cover-title(title, subtitle, size: 32pt, color: framagrisdark) = [
  #text(size: size, weight: "bold", fill: color)[#title]
  #if subtitle != none [
    #v(0.8em)
    #text(size: 13.5pt, fill: framagris)[#subtitle]
  ]
]

// meta 行容忍 none：none 项不渲染「· 」连缀，全部 none 时整行输出为空。
#let _cover-meta(author, institution, date) = {
  let items = ()
  if author != none { items.push([#author]) }
  if institution != none { items.push([#institution]) }
  if date != none { items.push([#date]) }
  text(size: 9.5pt, fill: framagris)[#items.join([ · ])]
}

// meta 区块：author/institution/date 全为 none 时整块（含细分隔线）不输出。
#let _cover-meta-block(author, institution, date) = {
  if author == none and institution == none and date == none {
    []
  } else {
    [
      #line(length: 100%, stroke: (paint: framagris.lighten(60%), thickness: 0.5pt))
      #v(0.7em)
      #_cover-meta(author, institution, date)
    ]
  }
}

// ---- 区域编排 grid-slide（v2.0）----
// 先定格局后填内容：行列网格定义位置，内容按行优先顺序填入格子。
// 支持原生 grid.cell(colspan:, rowspan:) 声明跨步，末行默认 1fr 撑满底部。

/// grid-slide —— 区域编排页骨架（v2.0）。
///
/// 按行列网格划分页面，内容依次填入每个格子 —— 先定格局，后填内容。
/// 格子按行优先顺序从 positional args 读取，网格维度由 columns/rows 决定。
/// 需要跨步时在对应格子上用 `grid.cell(colspan: 2, rowspan: 1)[...]` 包裹。
///
/// - columns (list of relative/length): 列宽，如 `(1fr, 1fr)` 均分两列；
///   默认 `(1fr)`。
/// - rows (list of relative/length): 行高，默认 `(auto, 1fr)` 末行撑到底部。
/// - gutter (length): 区域间距，默认 `gutter-primary`。
/// - cell-align (tuple): 格内内容默认对齐，默认 `(center, top)`。
/// - center (bool): `true` 时整张网格在页面正文区内垂直居中（双 v(1fr)，
///   同 body-slide center 方案）。默认 `false`。
/// - ..cells (positional, content): 按行优先顺序填入格子的内容。
///   格子数不得超过 `columns × rows`，不足时剩余格子留空。
/// 用法：
/// ```typst
/// #grid-slide(
///   columns: (1fr, 1fr),
///   rows: (auto, 1fr),
///   gutter: gutter-primary,
///   align: (left, top),
///   [#image("assets/sample-scheme.svg", height: 3em)],
///   [#keyline[核心特性] * 弹性伸缩\n  * 自动容错],
///   grid.cell(colspan: 2)[
///     #grid(columns: (1fr, 1fr, 1fr), gutter: gutter-tight,
///       [图一], [图二], [图三]
///     )
///   ],
/// )
/// ```
#let grid-slide(
  columns: (1fr,),
  rows: (auto, 1fr),
  gutter: gutter-primary,
  center: false,
  ..cells,
) = {
  let arr = cells.pos()
  let expect = columns.len() * rows.len()
  assert(arr.len() <= expect,
    message: "grid-slide: 内容格子数超过 grid 容量 (" + str(expect) + ")")
  let g = grid(
    columns: columns,
    rows: rows,
    column-gutter: gutter,
    row-gutter: gutter,
    ..arr,
  )
  if center {
    [#v(1fr) #g #v(1fr)]
  } else {
    g
  }
}

// ---- cover：分栏色块（层叠大图形左面板）----
// 左面板：横向渐变底色；浅蓝大圆 / 圆弧 / 细圆环层叠出抽象编辑海报感；
// 超淡大号年份数字作背景字；唯一强调是一个 Framaorange 小方块。
#let cover(
  title: [Title],
  subtitle: none,
  author: none,
  institution: none,
  date: none,
) = _full-page([
  #place(left, block(
    width: 38%,
    height: 100%,
    fill: gradient.linear(angle: 0deg, framableu.lighten(4%), framableu.darken(14%)),
  )[
    #place(top + left, dx: 1.2em, dy: 1em, cetz.canvas({
      import cetz.draw: *

      let year = datetime.today().display("[year]")

      // 层叠大圆（浅蓝，高透明）
      circle((2.1, 5.2), radius: 2.2, fill: framableu.lighten(22%).transparentize(86%), stroke: none)
      circle((3.8, 4.3), radius: 1.8, fill: framableu.lighten(33%).transparentize(88%), stroke: none)
      circle((1.5, 3.4), radius: 1.6, fill: framableu.lighten(45%).transparentize(90%), stroke: none)
      // 大圆弧与细圆环
      circle((6.0, 6.0), radius: 2.3, stroke: white.transparentize(90%), fill: none)
      circle((3.3, 3.4), radius: 2.9, stroke: white.transparentize(93%), fill: none)
      // 超淡大号年份（背景字）
      content((2.6, 5.2), text(size: 84pt, weight: "bold", fill: framableu.lighten(50%).transparentize(78%))[#year])
      // 唯一橙色小方块
      rect((5.4, 0.7), (6.1, 1.4), fill: framaorange, stroke: none)
    }))
    #place(bottom + left, dx: 1.6em, dy: -0.55em, line(length: 3.2em, stroke: (paint: white.transparentize(82%), thickness: 1pt)))
    #place(bottom + left, dx: 1.6em, dy: -1.5em, text(size: 11pt, weight: "medium", fill: white, tracking: 0.24em)[#institution])
  ])
  // 标题块下移（2.6em→5.2em）：标题上方留白与标题↔meta 间留白等高，
  // 封面右侧不再「头顶着、脚空着」（@150ppi 实测：顶 302px ≈ 中缝 301px）。
  #place(top + right, dx: -1.8em, dy: 5.2em, block(width: 55%)[
    #_cover-title(title, subtitle, size: 30pt, color: framableu)
  ])
  #place(bottom + right, dx: -1.8em, dy: -2.4em, block(width: 55%)[
    #_cover-meta-block(author, institution, date)
  ])
])

