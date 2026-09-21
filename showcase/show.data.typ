// showcase/show.data.typ
// 家族：数据元件 —— 把数字与结论装进视觉锚点。
//
// 演示三个元件：
//   · keyline(body, color: auto, size: 24pt)：大号加粗居中结论行。
//   · stat(amount, label, amount-size, color, stretch)：大数字 + 灰色标签。
//   · note(body, color: framagris)：小号灰字附注，澄清 / 出处 / 澄清。
//   · frameEmph(body) / alert(body)：橙色加粗，刻意保持稀有、可选。
//
// 交叉引用：所有 keyline / stat / boitefilled 的默认色都跟随 slide-accent，
//   见「配色与强调」家族的页级走位演示。
// ⚠ stat(stretch: true) 返回规格字典，只能交给 stretch-grid；行高按 2·T − A 锚定
//   垂直中心，标签以行底收口，不会溢出到下方内容。
#import "../lib.typ": *

// 用法: #keyline(body) —— 默认 24pt，颜色跟随当前强调色
// 改这里: color 传色值可逐处覆盖；size 可缩放（注意页面高度）。
// ⚠ 坑: keyline 已自带居中与 block(breakable:false)；不要在正文里再套 align(center)。
== keyline · 金句行

#body-slide(
  kicker: [keyline：每页顶部的「结论锚点」],
  inner: [
    #grid(
      columns: 1,
      gutter: 0.55em,
      keyline[默认强调色 · 24pt],
      keyline(color: framarouge, size: 20pt)[自定义色与字号（20pt）],
      keyline(color: framagrisdark, size: 16pt)[小号深灰，作副结论或口径],
    )
  ],
  closing: note[kicker: 参数传给 body-slide，body-slide 内部调用 keyline 渲染。],
)

// 用法: #stat(amount, label) —— 默认 34pt，颜色跟随强调色
// 改这里: amount-size 可定制；传 stretch: true 给 stretch-grid 实现等高。
// ⚠ 坑: 每个 stat 里数字与标签之间自动留 0.14em；外面不要再加 #v。
== stat · 大数字

#body-slide(
  kicker: [stat：超大数字 + 灰色小标签],
  inner: [
    #stretch-grid(
      columns: 3,
      gutter: 1em,
      stat(stretch: true)[18][调色板色数],
      stat(stretch: true, amount-size: 30pt, color: framaviolet)[8][卡片配色],
      stat(stretch: true, amount-size: 30pt)[100%][覆盖率],
    )
    #v(gap-secondary)
    #text(size: 0.8em, weight: "bold")[单独摆放的 plain stat（未 stretch）：]
    #grid(
      columns: (1fr, 1.6fr),
      gutter: 1em,
      stat(color: framaorange)[12][演示页],
      boitebleue[
        plain stat 只占一行时不会错位；一旦与别的 stat 并排，
        各行高度随字号不同而参差——并排请一律走 stretch-grid。
      ],
    )
  ],
  closing: note[stretch 行高按 2·T − A 锚定：数字垂直居中、标签以行底收口。],
)

// 用法: #note(body) / #note(color: framarouge)[...] —— 灰字附注
// 改这里: 默认 0.75em + framagris；传 color 改色。
// ⚠ 坑: #alert[...] 与 #frameEmph[...] 同源（framaorange 加粗）；刻意稀有，慎用。
== note · 附注与强调

#body-slide(
  kicker: [note 是收尾标配；alert / frameEmph 点到为止],
  inner: [
    #note[默认附注：0.75em framagris 灰字，用于出处与澄清。]
    #v(0.5em)
    #note(color: framarouge)[自定义色附注：谨慎使用，避免抢镜。]
    #v(0.8em)
    #boitebleue[
      正文里的 #frameEmph[关键短语] 用橙色加粗点到为止；
      #alert[alert] 与 #frameEmph[frameEmph] 同源同色。
      不要把整段都加粗——稀有才有分量。
    ]
  ],
  closing: note[alert 已通过 config-methods 绑定主题；本地 #frameEmph 是同源复刻。],
)
