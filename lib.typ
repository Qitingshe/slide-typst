// lib.typ - 共享工具模块
// 供 main.typ 和 chapters/*.typ 共同使用

#import "@preview/touying:0.7.4": *
#import themes.university: *
#import "@preview/cetz:0.4.2"
#import "@preview/numbly:0.1.0": numbly

// ==== Framasoft 配色 ====
// 浅色现代基调：每种「原色」都配有同族浅色。
// 深色槽位：primary / secondary / tertiary / neutral / neutral-dark / neutral-darkest
// 浅色槽位：primary-light / secondary-light / tertiary-light / neutral-light / neutral-lightest
// 全部接入下方 config-colors(...)。

#let framableu = rgb("#0C5B7A")
#let framableulight = rgb("#1290B0")
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
#let framagrislight = rgb("#F5F5F5")
#let framagrisdark = rgb("#3E3E3E")
#let framagrisdarkest = rgb("#000000")

// ==== 强调文本（Framaorange 加粗；刻意保持「稀有、可选」）====
// frameEmph 与 alert 同源同色，alert 同时通过 config-methods 绑定。
#let frameEmph(body) = text(fill: framaorange, weight: "bold", body)
#let alert(body) = text(fill: framaorange, weight: "bold", body)

// ==== 浅色强调卡片（对应 \boiteXXX）====
// 左竖条(3pt) + 约 5%–8% 的极浅底色 + 无重边框 + 圆角 + 舒适内边距。
// 保留原有公共函数名与「单内容参数」签名。
#let _boite(content, color: framableu) = {
  block(
    inset: (x: 12pt, y: 9pt),
    radius: 4pt,
    fill: color.lighten(93%),
    stroke: (left: (paint: color, thickness: 3pt)),
  )[#content]
}

#let boitebleue(content) = _boite(content, color: framableu)
#let boiteverte(content) = _boite(content, color: framavert)
#let boiterouge(content) = _boite(content, color: framarouge)
#let boiteorange(content) = _boite(content, color: framaorange)
#let boiteviolette(content) = _boite(content, color: framaviolet)
#let boitejaune(content) = _boite(content, color: framajaune)
#let boitemarron(content) = _boite(content, color: framamarron)
#let boitegrise(content) = _boite(content, color: framagris)

// ==== 排版层级 ====
// 在 0.85em 正文（≈21pt）之上叠加可复用层级：
//   二级标题（heading level 2，show 规则见 main.typ）≈ 1.5em —— 每页大标题
//   keyline（金句行）      24pt   —— 每页主结论
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

/// stat —— 大数字：超大强调色数字 + 灰色小标签。
/// - amount (content): 大数字本体，可传字符串或数学内容。
/// - label (content): 数字下方的灰色解释。
/// - amount-size (length): 数字字号，默认 34pt。
/// - color (color, auto): 数字色；默认 auto = 跟随当前强调色。
/// 示例：#stat[10][正文章节]
/// 带定制：#stat(amount-size: 40pt, color: framaviolet, [10], [正文章节])
#let stat(amount, label, amount-size: 34pt, color: auto) = {
  let use-accent = color == auto
  context {
    let c = if use-accent { accent-state.get() } else { color }
    block(breakable: false)[
      #align(center)[
        #text(size: amount-size, weight: "bold", fill: c)[#amount]
        #v(0.14em)
        #text(size: 0.8em, fill: framagris)[#label]
      ]
    ]
  }
}

/// boitefilled —— 实色填充卡片（boite 系列的对偶变体）：
/// 底色为强调色、内容为白字，适合放「结论 / 高反差」信息。
/// 建议搭配深色原色（framableu / framavert / framaviolet / framaorange），
/// 以保证白字对比度。
/// - content (content): 卡片内容。
/// - color (color, auto): 填充色；默认 auto = 跟随当前强调色。
/// 示例：#boitefilled[*结论* 缺工具定义 → 行动归零]
#let boitefilled(content, color: auto) = {
  let use-accent = color == auto
  context {
    let c = if use-accent { accent-state.get() } else { color }
    block(
      inset: (x: 12pt, y: 9pt),
      radius: 4pt,
      fill: c,
    )[
      #text(fill: rgb("#FFFFFF"))[#content]
    ]
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
  // 页标题：Touying 把每页的 `==` 标题移到页眉（header）渲染，正文里不出现，
  // 因此标题样式要在这里定制。1.5em 放大 + 当前页强调色 + 短粗强调条，
  // 与 0.85em 正文拉开层级；强调色跟随 slide-accent（见上文）。
  header: utils.display-current-heading(
    level: 2,
    style: (setting: none, numbered: true, current-heading) => {
      context {
        let c = accent-state.get()
        let c-head = c.darken(4%) // 加深一档，保证白底对比
        block(breakable: false)[
          #text(size: 1.5em, weight: "bold", fill: c-head)[#current-heading.body]
          #v(0.14em)
          #line(length: 4.6em, stroke: (paint: c, thickness: 2.4pt))
        ]
      }
    },
  ),
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
  config-info(
    title: [深入理解 AI Agent],
    subtitle: none,
    author: [QITINGSHE],
    date: datetime.today(),
    institution: [bojieli/ai-agent-book],
    contact: none,
    logo: none,
  ),
)

// ==== CeTZ 与 Touying 的动画绑定 ====
#let cetz-canvas = touying-reducer.with(
  reduce: cetz.canvas,
  cover: cetz.draw.hide.with(bounds: true),
)

// ==== 封面（title slide）====
// 共享包装：封面页隐藏主题的 header/footer，并给出独立的白色画布。
#let _cover-page(body) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(self, config-page(
    header: none,
    footer: none,
    fill: rgb("#FFFFFF"),
    margin: (x: 2.4em, y: 1.8em),
  ))
  touying-slide(self: self, body)
})

// 封面共享小工具：大标题 / meta 行 / meta 区块（含细分隔线）
#let _cover-title(title, subtitle, size: 32pt, color: framagrisdark) = [
  #text(size: size, weight: "bold", fill: color)[#title]
  #if subtitle != none [
    #v(0.8em)
    #text(size: 13.5pt, fill: framagris)[#subtitle]
  ]
]

#let _cover-meta(author, institution, date) = text(size: 9.5pt, fill: framagris)[#author · #institution · #date]

#let _cover-meta-block(author, institution, date) = [
  #line(length: 100%, stroke: (paint: framagris.lighten(60%), thickness: 0.5pt))
  #v(0.7em)
  #_cover-meta(author, institution, date)
]

// ---- cover：分栏色块（层叠大图形左面板）----
// 左面板：横向渐变底色；浅蓝大圆 / 圆弧 / 细圆环层叠出抽象编辑海报感；
// 超淡大号年份数字作背景字；唯一强调是一个 Framaorange 小方块。
#let cover(
  title: [Title],
  subtitle: none,
  author: [QITINGSHE],
  institution: [USTC],
  date: datetime.today().display(),
) = _cover-page([
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
  #place(top + right, dx: -1.8em, dy: 2.6em, block(width: 55%)[
    #_cover-title(title, subtitle, size: 30pt, color: framableu)
  ])
  #place(bottom + right, dx: -1.8em, dy: -2.4em, block(width: 55%)[
    #_cover-meta-block(author, institution, date)
  ])
])

