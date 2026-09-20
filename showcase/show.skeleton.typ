// showcase/show.skeleton.typ
// 家族：页面骨架 —— 所有正文页的公用结构。
//
// 演示 body-slide(kicker, inner, closing, gap, closing-gap) 的组合与节奏间距：
//   · kicker  → keyline 结论行（页面主结论，居中大字）
//   · inner   → 主体（stretch-grid / 列表 / 双栏网格 / 公式块）
//   · closing → 收尾块（note / boitefilled / boiteXXX）
//   · gap           = keyline 与主体之间留白，默认 gap-primary = 0.3em
//   · closing-gap   = 收尾块之前留白，默认同 gap-primary
//   · 主体内部段间留白用 gap-secondary = 0.4em（配合 #v(gap-secondary)）
//
// 交叉引用：「卡片与网格」「数据元件」两家族的每一页都建立在 body-slide 之上。
// ⚠ 坑：body / content / main 是 Typst 保留名，不能当具名参数，只能传
//    kicker / inner / closing / gap / closing-gap。
// ⚠ 溢出: body-slide inner 内容建议 ≤ 12 行正文（约 0.85em 基准），超出会在页脚处挤压截断。
#import "../lib.typ": *

// 用法: #body-slide(kicker: [...], inner: [...], closing: [...]) —— 三段齐全
// 改这里: inner 里放主体；closing 里放 note 或 boitefilled。
// ⚠ 坑: closing 前会自动插入 closing-gap（默认 0.3em），别在 closing 里再手加 #v。
== 三段齐全

#body-slide(
  kicker: [骨架把一页拆成「结论 → 主体 → 收尾」],
  inner: [
    #boitebleue[
      *主体* 承载真正的信息：网格、列表、公式都放这里。
      - 段与段之间用 #raw("#v(gap-secondary)") 拉开次级节奏（0.4em）。
      - 同段内的换行照常写，不用额外留白。
    ]
    #v(gap-secondary)
    #note[上面这行留白就是 gap-secondary —— 主体内部的段间节奏。]
  ],
  closing: boitefilled[*收尾* 放结论或行动项，默认与主体间隔 gap-primary。],
)

// 用法: #body-slide(kicker: none, inner: [...]) —— 省略结论行与收尾块
// 改这里: kicker: none → 整页没有 keyline，主体直接从页眉下方开始。
// ⚠ 坑: 无 kicker 时 gap 不产生任何顶部留白（gap 只在 kicker 与主体之间生效）。
== 省略结论与收尾

#body-slide(
  kicker: none,
  inner: [
    #boiteverte[
      *没有 kicker 的页* 适合承接性内容：继续上一页的讨论、或放一张大图。
      收尾也可省略——closing: none 时页面在主体末尾自然结束。
    ]
  ],
)

// 用法: #body-slide(kicker: [...], inner: [...], gap: 0pt) —— 紧凑页
// 改这里: gap 收成 0pt，让结论紧贴主体，适合信息密度高的页。
// ⚠ 坑: 0pt 只压掉结论与主体的间距；要整页更紧，还得收 inner 内部的 #v。
== 紧凑页 · gap: 0pt

#body-slide(
  kicker: [结论紧贴主体，信息更密],
  inner: [
    #grid(
      columns: 2,
      column-gutter: 1em,
      boitejaune[*左格* 与结论之间没有多余留白。],
      boitemarron[*右格* 靠 gap: 0pt 压掉空隙。],
    )
  ],
  gap: 0pt,
)

// 用法: #body-slide(..., closing-gap: 1.2em) —— 自定义收尾留白
// 改这里: closing-gap 单独放大或缩小，只影响收尾块与主体之间的距离。
// ⚠ 坑: closing-gap 只收尾生效；想调结论与主体之间请用 gap。
== 收尾留白 · closing-gap

#body-slide(
  kicker: [收尾前留一口气],
  inner: [
    #boitegrise[
      *主体* 与收尾之间默认 0.3em；这里把 closing-gap 提到 1.2em，
      让页尾的 note 更明确地「落单」。
    ]
  ],
  closing: note[被放大的收尾留白：closing-gap: 1.2em。],
  closing-gap: 1.2em,
)
