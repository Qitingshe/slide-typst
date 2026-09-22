// showcase/show.color.typ
// 家族：配色与强调 —— 颜色的主从关系与页级走位。
//
// 演示两件事：
//   · frama 调色板：18 个色值变量（8 原色 + 8 同族浅色 + 2 深灰），用法就是
//     直接引用变量名（fill: framableu / text(fill: ...)）。
//   · slide-accent(color)：页级换色。它是一枚「状态写入」，写在上一页末尾，
//     让下一页的标题、keyline、stat、boitefilled 全部自动跟随新色。
//
// 交叉引用：keyline / stat / boitefilled 的 color: auto 都由 accent-state 决定。
// ⚠ 唯一的页级走位演示页在本家族；lib.typ 只允许节级（section-open color）换色。
#import "../lib.typ": *

// 文件级局部 helper：单块色卡（名字 + 底色 + 文字色）。
// 用 rect + 固定高度确保网格内所有色块等高对齐，不受名称换行影响。
#let _swatch(name, c, fore: rgb("#FFFFFF")) = rect(
  width: 100%,
  height: 2.4em,
  inset: (x: 0.5em, y: 0.3em),
  radius: 3pt,
  fill: c,
  stroke: 0.4pt + rgb("#E0E0E0"),
)[
  #set align(center + horizon)
  #text(size: 0.6em, fill: fore, weight: "medium")[#name]
]

// 用法: 直接引用色值变量（framableu / framableulight / ... / framagrisdarkest）
// 改这里: 在 lib.typ 顶部定义全域 18 色；本页只列名预览，不改值。
// ⚠ 坑: 文字色看底色的明度，与饱和度无关——深色（bleu/rouge/violet/gris 系）
//        配白字；浅色与中明度（vert/orange/jaune/marron）一律配深字 fore。
== frama 调色板 · 18 色

#grid(
  columns: 6,
  gutter: 0.45em,
  _swatch("framableu", framableu),
  _swatch("framableulight", framableulight, fore: framagrisdark),
  _swatch("framavert", framavert, fore: framagrisdark),
  _swatch("framavertlight", framavertlight, fore: framagrisdark),
  _swatch("framarouge", framarouge),
  _swatch("framarougelight", framarougelight, fore: framagrisdark),
  _swatch("framaviolet", framaviolet),
  _swatch("framavioletlight", framavioletlight, fore: framagrisdark),
  _swatch("framaorange", framaorange, fore: framagrisdark),
  _swatch("framaorangelight", framaorangelight, fore: framagrisdark),
  _swatch("framajaune", framajaune, fore: framagrisdarkest),
  _swatch("framajaunelight", framajaunelight, fore: framagrisdark),
  _swatch("framamarron", framamarron, fore: framagrisdark),
  _swatch("framamarronlight", framamarronlight, fore: framagrisdark),
  _swatch("framagris", framagris),
  _swatch("framagrislight", framagrislight, fore: framagrisdark),
  _swatch("framagrisdark", framagrisdark),
  _swatch("framagrisdarkest", framagrisdarkest),
)

#v(1.2em)

#note[深色原色配白字，浅色与中明度色（vert / orange / jaune / marron）配深字；颜色关系优先靠明度，不靠饱和度。]

// ⚠ 走位声明：写在本页「末尾」，下一页整体接管 framaviolet。
// （多插页的真机制：section-open 自成 slide，其后到该段首个 `==` 之间挂任何
//   内容都会凭空多插一页——这里写页末、紧邻下一页 `==`，是安全姿势。）
#slide-accent(framaviolet)

// 用法: #slide-accent(色值) 写在「上一页末尾」，本页标题/keyline/stat/boitefilled 全部跟随
// 改这里: 换 framaXXX 色值；每章第一页可省略声明（沿用上一章遗留色，全书默认 framableu）。
// ⚠ 坑: accent 须写上一页末尾；section-open 之后、段内首个 == 之前不挂内容。本页收尾再 #slide-accent(framableu) 复位。
== slide-accent · 页级换色

#body-slide(
  kicker: [上一页末尾的声明，让本页整体转紫],
  inner: [
    #stretch-grid(
      columns: 2,
      gutter: 0.8em,
      stat(amount-size: 36pt, stretch: true)[1][次页级走位],
      boitefilled(stretch: true)[*自动跟随* color: auto 的元件全部收编新色],
    )
  ],
  closing: note[复位声明在下方源码末尾：本页收尾 #slide-accent(framableu)。],
)

// 收尾：把强调色还给默认 framableu，避免「紫」泄漏到下一个家族。
#slide-accent(framableu)