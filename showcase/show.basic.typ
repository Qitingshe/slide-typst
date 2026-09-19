// showcase/show.basic.typ
// 家族：常规元素 —— 不画新容器，用 Typst 原生能力补齐三类内容。
//
// 演示三个元件：
//   · #table(...)：原生表格，frama 主色系浅底表头（3pt 圆角）＋横向细线分隔。
//   · #figure-block(...)：图像＋图注的组合块（lib.typ 模版元件）——图与图注同宽、
//     同左缘、图注紧贴图下沿。
//   · #link(...)：外链（完整 URL）与内链（#label + <标签>）双向跳转，页面级
//     #show link 规则统一上主题色＋下划线。
//
// 交叉引用：表头/链接配色沿用「配色与强调」家族的明度对比原则——
//   本页统一走「浅底深字」路线（framableu 深字 + lighten 浅蓝底），不牵涉 darken 垫底。
// ⚠ lib.typ 冻结，本家族只用现有元件组合，不发明新装饰。
#import "../lib.typ": *

// 用法: #table(columns: (...), align: (...), stroke: ..., table.header(...)) —— 原生表格
// 改这里: columns 传列宽（1fr 比例 / auto 按内容 / 绝对长度）；表头样式写在 header 内部
//         各 table.cell 的 fill/stroke 上；横向分隔线由 table 级 stroke: (y: ...) 控制。
// ⚠ 坑: 0.13 起 table.header 只负责分组与跨页重复，样式写在它内部的 table.cell 上
//        （fill / stroke）；table.cell 不支持 radius，3pt 圆角外包给 #block(radius: 3pt, …)
//        的浅底面板，表内 cell 全部透明让面板底色透过；本页走「浅底深字」——framableu
//        深字 + framableu 底线，不再需要深底白字的 darken 垫色；同族选色按明度二选一
//        （浅底深字 / 深底白字），中明度底色（marron / vert…）做表头既撑不起白字、
//        深字又发闷，绕开它。
== 表格 · table <tbl-anchor>

#body-slide(
  kicker: [原生 table 也够撑起一张数据表],
  inner: [
    #block(
      radius: 3pt,
      fill: framableu.lighten(97%),
      inset: 0.6em,
    )[
      #table(
        columns: (1.3fr, 2fr, 1fr, auto),
        inset: (x: 0.5em, y: 0.45em),
        align: (left, left, center, right),
        stroke: (y: 0.4pt + framableu.lighten(72%)),
        table.header(
          table.cell(stroke: (top: none, bottom: 1.2pt + framableu))[#text(fill: framableu, weight: "bold")[元件]],
          table.cell(stroke: (top: none, bottom: 1.2pt + framableu))[#text(fill: framableu, weight: "bold")[关键参数]],
          table.cell(stroke: (top: none, bottom: 1.2pt + framableu))[#text(fill: framableu, weight: "bold")[默认]],
          table.cell(stroke: (top: none, bottom: 1.2pt + framableu))[#text(fill: framableu, weight: "bold")[家族]],
        ),
        // 主体行：无底色（透出面板浅底），横向细线分隔；末行用 framableu 浅色线收底
        table.cell()[keyline],
        table.cell()[color · size],
        table.cell()[auto],
        table.cell()[数据元件],
        table.cell()[stat],
        table.cell()[amount-size · color],
        table.cell()[34pt],
        table.cell()[数据元件],
        table.cell()[body-slide],
        table.cell()[kicker · inner · closing],
        table.cell()[none],
        table.cell()[页面骨架],
        table.cell(stroke: (bottom: 0.8pt + framableu.lighten(45%)))[boitefilled],
        table.cell(stroke: (bottom: 0.8pt + framableu.lighten(45%)))[color · stretch],
        table.cell(stroke: (bottom: 0.8pt + framableu.lighten(45%)))[auto],
        table.cell(stroke: (bottom: 0.8pt + framableu.lighten(45%)))[卡片与网格],
      )
    ]
    #v(gap-primary)
    #note[列宽单位：1fr 按比例分剩余宽度、auto 按内容、也可传绝对长度（如 4cm）。]
  ],
  closing: note[表头行写进 table.header：跨页时自动重复（本页只有一表，作为惯例保留）。],
)

// 用法: #figure-block(image("../assets/sample-scheme.svg"), caption: [图 1：…], width: 88%)
// 改这里: img 传 `image(...)` 调用（路径相对本文件，showcase/ 下写 ../assets/）；caption 自由
//         content 保留手写"图 1："风格；width 为图与图注共享宽度；gap / caption-size /
//         caption-color 分别调间距、字号、颜色（默认 0.12em / 0.63em / framagris）。
// ⚠ 坑: ① `image(...)` 调用处**不要写 width**——块内 #set image(width: 100%) 接管，
//        显式 width 会覆盖它导致溢出；② 原生 `figure`（自动编号、进目录，走 main.typ 的
//        figure.caption 规则）与 `figure-block`（手写"图 1："、不编号）是两条 caption 路径，
//        借页时按需选一条，勿混用。
== 图片 · image

#body-slide(
  kicker: [一张图占一半版面，另一半留给解说],
  inner: [
    #grid(
      columns: (1fr, 1fr),
      gutter: 1em,
      [
        #figure-block(image("../assets/sample-scheme.svg"), caption: [图 1：样例示意图（assets/sample-scheme.svg）], width: 88%)
      ],
      [
        #boitebleue[
          *放图要点*
          - 先给 image() 一个 width，别让图以原始尺寸顶破页面。
          - 图注交给 #raw("#figure-block") 模版元件：图与图注同宽同左缘，间距/字号由 gap、caption-size 参数接管。
          - 一套 deck 的示意图统一放 assets/，路径从仓库根写起。
        ]
      ],
    )
  ],
  closing: note[原生 figure 能自动编号进目录（figure.caption 规则在 main.typ）；figure-block 是手写"图 1："的路，借页选一条。],
)

// 用法: #show link: it => ... 给「本页起的全部链接」统一上主题色＋下划线；
//       #link("https://..."[文字]) 外链；#link(<标签>)[文字] 内链
// 改这里: 样式规则写在 #show link 里，用 underline(text(fill: 主题色, it)) 包住整个
//         link 元素——最外层是 underline 不是 link，不递归、链接可点性保留；
//         换色改两处：text 的 fill 与 underline 的 stroke（0.5pt 细线即可）。
// ⚠ 坑: show 规则自声明点起对文档后续链接全局生效——本 deck 之后只有「示意图与
//        公式」家族（无链接），安全；若后续某页要恢复默认样式，写
//        #show link: it => it 重置。内链目标 <tbl-anchor> 挂在表格页的 `==` 标题上，
//        body-slide 的 inner 里放 #label(...) 会被 Touying 丢弃，别放那儿。
#show link: it => underline(stroke: 0.5pt + framableu, text(fill: framableu, it))
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
  closing: note[#raw("#show link") 规则自声明点起接管文档后续全部链接；借页时连同规则一起复制。],
)