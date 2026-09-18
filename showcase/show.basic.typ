// showcase/show.basic.typ
// 家族：常规元素 —— 不画新容器，用 Typst 原生能力补齐三类内容。
//
// 演示三个元件：
//   · #table(...)：原生表格，配 frama 风格表头（深底白字）与斑马纹。
//   · #image(...)：位图 / SVG 插图，width 百分比缩放，图注小灰字。
//   · #link(...)：外链（完整 URL）与内链（#label + <标签> 双向跳转）。
//
// 交叉引用：表头配色的选色规则与「配色与强调」家族一致——
//   深色配白字，中明度（如 framamarron / framavert）须 darken 垫深。
// ⚠ lib.typ 冻结，本家族只用现有元件组合，不发明新装饰。
#import "../lib.typ": *

// 用法: #table(columns: (...), align: (...), stroke: ..., table.header(...)) —— 原生表格
// 改这里: columns 传列宽（1fr 比例 / auto 按内容 / 绝对长度）；斑马纹靠逐行 cell(fill:)。
// ⚠ 坑: 0.13 起 table.header 只负责分组与跨页重复，样式写在它内部的 table.cell 上
//        （fill / stroke）；表头白字需够深的底色——framamarron 属中明度，须 darken(30%)。
== 表格 · table <tbl-anchor>

#body-slide(
  kicker: [原生 table 也够撑起一张数据表],
  inner: [
    #table(
      columns: (1.3fr, 2fr, 1fr, auto),
      inset: 0.5em,
      align: (left, left, center, right),
      stroke: (y: 0.4pt + framagris.lighten(72%)),
      table.header(
        table.cell(stroke: (bottom: 1.2pt + framagrisdark), fill: framamarron.darken(30%))[#text(fill: white, weight: "bold")[元件]],
        table.cell(fill: framamarron.darken(30%))[#text(fill: white, weight: "bold")[关键参数]],
        table.cell(fill: framamarron.darken(30%))[#text(fill: white, weight: "bold")[默认]],
        table.cell(fill: framamarron.darken(30%))[#text(fill: white, weight: "bold")[家族]],
      ),
      table.cell(fill: none)[keyline],
      table.cell(fill: none)[color · size],
      table.cell(fill: none)[auto],
      table.cell(fill: none)[数据元件],
      table.cell(fill: framagrislight)[stat],
      table.cell(fill: framagrislight)[amount-size · color],
      table.cell(fill: framagrislight)[34pt],
      table.cell(fill: framagrislight)[数据元件],
      table.cell(fill: none)[body-slide],
      table.cell(fill: none)[kicker · inner · closing],
      table.cell(fill: none)[none],
      table.cell(fill: none)[页面骨架],
      table.cell(fill: framagrislight)[boitefilled],
      table.cell(fill: framagrislight)[color · stretch],
      table.cell(fill: framagrislight)[auto],
      table.cell(fill: framagrislight)[卡片与网格],
    )
    #v(gap-primary)
    #note[列宽单位：1fr 按比例分剩余宽度、auto 按内容、也可传绝对长度（如 4cm）。]
  ],
  closing: note[表头行写进 table.header：跨页时自动重复（本页只有一表，作为惯例保留）。],
)

// 用法: #image("../assets/sample-scheme.svg", width: 88%) + 下方图注
// 改这里: 路径相对「调用它的 .typ 文件所在目录」——本文件在 showcase/ 下，
//         资产在仓库根，故写 ../assets/；width 传百分比（height 自动等比例）。
// ⚠ 坑: SVG 放大不糊、PNG 会糊——宽幅示意优先存 SVG；#figure 能自动编号进目录，
//        本例只演示最朴素的 image() + 图注。
== 图片 · image

#body-slide(
  kicker: [一张图占一半版面，另一半留给解说],
  inner: [
    #grid(
      columns: (1fr, 1fr),
      gutter: 1em,
      [
        #image("../assets/sample-scheme.svg", width: 88%)
        #v(0.3em)
        #text(size: 0.72em, fill: framagris)[图 1：样例示意图（assets/sample-scheme.svg）]
      ],
      [
        #boitebleue[
          *放图要点*
          - 先给 image() 一个 width，别让图以原始尺寸顶破页面。
          - 图片与图注之间用 #raw("#v(0.5em)") 收一下，图注小灰字。
          - 一套 deck 的示意图统一放 assets/，路径从仓库根写起。
        ]
      ],
    )
  ],
  closing: note[#figure 能自动编号并进目录，画廊里只演示最朴素的 image() + 图注。],
)

// 用法: #link("https://..."[文字]) 外链；#link(<标签>)[文字] 内链
// 改这里: 外链给完整 URL（缺协议会打不开）；内链标签挂在「目标页标题」上
//         （如上一页标题行尾的 <tbl-anchor>）。
// ⚠ 坑: 内链目标是元素位置——本页 <tbl-anchor> 由表格页标题提供；
//        body-slide 的 inner 里放 #label(...) 会被 Touying 重排丢弃，别放那儿；
//        链接样式是主题默认，全局换色需另配。
== 链接 · 超链接

#body-slide(
  kicker: [外链跳出去，内链跳回来],
  inner: [
    #grid(
      columns: 2,
      column-gutter: 1em,
      boitebleue[
        *外部链接*
        #link("https://typst.app/docs/")[Typst 官方文档]
        \\
        #link("https://lib.typst.app")[typst.app 模板库]
        \\
        外链必须带完整协议（https://），否则链接无效。
      ],
      boiteverte[
        *内部链接*
        #link(<tbl-anchor>)[回到表格页]
        \\
        自动目录里的每条也是内部跳转（it.element.location()）。
        \\
        目标页放一个 #raw("#label(...)")，`#link(<名字>)` 就能跳过去。
      ],
    )
  ],
  closing: note[外链跳转依赖 PDF 阅读器的支持；typst watch 预览里同样可点。],
)