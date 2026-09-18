// showcase/show.cards.typ
// 家族：卡片与网格 —— 信息分块的主力元件。
//
// 演示两组元件：
//   · 浅色卡片 boitebleue / verte / rouge / orange / violette / jaune / marron / grise
//     （3pt 左竖条 + 极浅底 + 圆角，一个内容参数）。
//   · 实色卡片 boitefilled（强调色底 + 白字，放结论 / 高反差）。
//   · stretch-grid(..cells, columns, row-gutter, column-gutter, gutter)：自动等高网格。
//
// 关键机制（stretch 协议）：卡片加 stretch: true 时不再返回排版好的块，而返回一个
// 「规格字典」，必须交给 stretch-grid 排版——它自动测量各格自然高度、按行取最大，
// 生成等高网格；stat 的大数字还会锚定行垂直中心。
//
// 交叉引用：末页「全要素样板页」是任何真实内容页的起手式。
// ⚠ 坑：stretch: true 的卡片只能交给 stretch-grid；单元格里卡片外面不要再包 []。
#import "../lib.typ": *

// 用法: boitebleue[...] / boiteverte[...] / ... 八色浅色卡片（每色一个函数）
// 改这里: 直接把内容写进方括号；颜色语义自定（蓝/绿/红/橙/紫/黄/棕/灰）。
// ⚠ 坑: 并排展示时用 stretch: true + stretch-grid —— 自动等高同宽，
//        不会被最长/最宽的文字拉扯；单元格里卡片外面不要再包 []。
== 八色卡片 · boite 系列

#stretch-grid(
  columns: 4,
  gutter: 0.6em,
  boitebleue(stretch: true)[#align(center)[*bleue* \ #text(size: 0.72em)[主色 · 默认]]],
  boiteverte(stretch: true)[#align(center)[*verte* \ #text(size: 0.72em)[辅助 · 成功]]],
  boiterouge(stretch: true)[#align(center)[*rouge* \ #text(size: 0.72em)[警示 · 错误]]],
  boiteorange(stretch: true)[#align(center)[*orange* \ #text(size: 0.72em)[强调 · 稀有]]],
  boiteviolette(stretch: true)[#align(center)[*violette* \ #text(size: 0.72em)[次要 · 深色组]]],
  boitejaune(stretch: true)[#align(center)[*jaune* \ #text(size: 0.72em)[提示 · 浅色]]],
  boitemarron(stretch: true)[#align(center)[*marron* \ #text(size: 0.72em)[中性 · 柔和]]],
  boitegrise(stretch: true)[#align(center)[*grise* \ #text(size: 0.72em)[弱化 · 置灰]]],
)

// 用法: #boitefilled(content, color: framableu) —— 实色卡片（色底 + 白字）
// 改这里: color 只传真正够深的底色：framableu / framarouge / framaviolet 直接可用，
//         framaorange 这类中明度色须 darken(25~30%) 垫深后再配白字。
// ⚠ 坑: 白字对比由底色的明度决定，与饱和度无关——framavert / framaorange /
//        framajaune / framamarron 裸用会发虚，务必 darken 或换深原色。
== 实色卡片 · boitefilled

#grid(
  columns: 3,
  gutter: 0.6em,
  boitefilled(color: framableu)[*蓝底结论* 高反差，一眼抓住],
  boitefilled(color: framarouge)[*红底结论* 放风险提醒],
  boitefilled(color: framaorange.darken(28%))[*橙底结论* 垫深后才配白字],
)

// 用法: #stretch-grid(columns: 3, gutter: 1em, boiteXXX(stretch: true)[...], ...)
// 改这里: 每张卡片加 stretch: true；columns 传整数（列数），行数自动推导。
// ⚠ 坑: 三格内容长短不一也会被拉成等高；stretch: true 的卡片不能再包 []。
== stretch-grid · 3 列等高

#stretch-grid(
  columns: 3,
  gutter: 1em,
  boitebleue(stretch: true)[*短* 不等高的内容也会被拉齐],
  boiteverte(stretch: true)[
    *中等长度* 自动测量自然高度，按行取最大值，
    让同一行的卡片底部对齐。
  ],
  boiteorange(stretch: true)[
    *最长* 无论几行文字，同行的邻居都会长到和它一样高，
    整行像一条齐整的卡片带。
  ],
)

// 用法: #stretch-grid(columns: 5, row-gutter: 0.5em, column-gutter: 0.6em, ...)
// 改这里: gutter 同时设定行列间距；也可分开用 row-gutter / column-gutter。
// ⚠ 坑: columns 是整数（列数），不要传数组；gutter 优先级高于另两个。
== stretch-grid · 5 列与 gutter

#stretch-grid(
  columns: 5,
  row-gutter: 0.5em,
  column-gutter: 0.6em,
  boitebleue(stretch: true)[*一*],
  boiteverte(stretch: true)[*二*],
  boiteorange(stretch: true)[*三*],
  boiteviolette(stretch: true)[*四*],
  boitegrise(stretch: true)[*五*],
)

// 用法: body-slide + stretch-grid(boite + stat) + boitefilled + note 的完整组合
// 改这里: 把这张页当作任何真实内容页的起手式，逐块替换文案即可。
// ⚠ 坑: stat(stretch: true) 与 boite(stretch: true) 可混在同一行等高。
== 全要素样板页

#body-slide(
  kicker: [一张真实内容页的全部零件],
  inner: [
    #stretch-grid(
      columns: 3,
      gutter: 0.8em,
      stat(stretch: true)[8][家族数],
      boitebleue(stretch: true)[*要点一* 结论性的一句话],
      boiteverte(stretch: true)[*要点二* 与左边等高的说明],
    )
    #v(gap-secondary)
    #stretch-grid(
      columns: 2,
      gutter: 0.8em,
      stat(stretch: true)[18][调色板色值],
      boitefilled(stretch: true)[*结论条* 用实色卡片收束本页],
    )
  ],
  closing: note[页尾 note 交代出处、口径或下一步；也可以换成 boitefilled。],
)
