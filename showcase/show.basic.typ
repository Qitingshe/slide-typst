// showcase/show.basic.typ
// 家族：常规元素 —— 不画新容器，用 Typst 原生能力补齐四类内容。
//
// 演示四个元件：
//   · #table(...)：原生表格，深底白字表头＋斑马纹＋末行强调；表头示范「多级分组」
//     写法——table.header(level: 1, …分组行…) + table.header(level: 2, …子列行…)，
//     覆盖「收入/成本/利润 → 子列」这类高频借页场景。
//   · #figure-block(...)：图像块（lib.typ 模版元件）——图与图注同宽、图注紧贴图下沿；
//     默认 caption 左对齐；本家族演示「居中路线」：caption 传 none，调用点自排一行
//     图宽容器内 #align(center)[#text(...)]（字号/颜色沿用默认 0.63em / framagris）。
//     多子图用 figure-block + grid 的「三图一线」排法。
//   · #link(...)：外链（完整 URL）与内链（#label + <标签>）双向跳转，页面级
//     #show link 规则统一上主题色＋下划线。
//   · raw 代码块：行内 #raw(...) 不加底色不换字号（与正文同行高才安静）；
//     块级走「framagrislight 浅底 + accent 顶线 1.5pt」容器（与 boite 卡片的
//     3pt 左竖条方向/粗细双差异，不撞视觉语言），不加行号。
//
// 交叉引用：表头/链接配色沿用「配色与强调」家族的明度对比原则——
//   表格走「深底白字」路线（framableu 实底表头 + 白字），斑马纹 lighten(93%)，
//   不牵涉中明度底色（vert / orange / jaune / marron）。
// ⚠ lib.typ 冻结，本家族只用现有元件组合，不发明新装饰。
#import "../lib.typ": *

// 用法: #table(columns: (...), stroke: (x: none, y: ...),
//       table.header(level: 1, …分组行…) + table.header(level: 2, …子列行…) + …数据行…
//       —— 原生表格（含多级分组表头，演示「收入/成本/利润 → 子列」式高频场景）
// 改这里: 分组表头按 level 分层堆叠，且必须 level 升序（先 1 后 2）：
//         level 1 = 分组行，跨列用 table.cell(colspan: 2)；level 2 = 子列行，
//         子列总数须与 columns 的列数对齐。分组行样式照抄下方（colspan 单元格 +
//         framableu 实底白字 + align: center 居中跨组）；子列行沿用原单层表头写法。
//         数据行不动：整行 cell 加 framableu.lighten(93%) 斑马纹，末行 lighten(85%) + 底边线。
//         要演示三组 × 三子列（如 收入/成本/利润 × 线上/线下/材料/人工），把 columns 扩成
//         多列、level 1 加对应 colspan 单元格即可，level 2 依样对齐。
// ⚠ 坑: ① 多级表头跨页语义（0.15.1 实测）：level 1 + 2 都默认 repeat: true，跨页时
//        **两行一起重复**；要「分页只重复子列行、分组行不随页」的经典观感，给 level 1
//        加 repeat: false（低层表头出现即替换高层）。② 多级表头会给每个单元格边界补
//        默认深色竖线，table 级 stroke 必须显式 (x: none, y: ...) 去掉，否则分组行/子列行
//        交界处凭空多出黑竖线（单层表头没有此坑）。③ table.cell 不支持 radius，圆角外包给
//        #block(radius: 4pt, clip: true) 裁切；中明度底色（marron / vert…）撑不起白字，
//        本页全程「深底白字」——分组行 framableu 实底、子列行 lighten(10%) 拉开层级，
//        仍深底可配白字，观感与原来单层时一致。
== 表格 · table <tbl-anchor>

#body-slide(
  kicker: [原生 table 也够撑起一张数据表],
  inner: [
    #block(
      radius: 4pt,
      clip: true,
      stroke: 0.4pt + framableu.lighten(72%),
    )[
      #table(
        columns: (1.3fr, 2fr, 1fr, auto),
        inset: (x: 0.5em, y: 0.45em),
        align: (left, left, center, right),
        stroke: (x: none, y: 0.4pt + framableu.lighten(72%)), // x: none 去掉多级表头单元格边界的深色竖线（单层表头无此坑）
        // 多级分组表头：level 1 分组行（colspan 跨组、repeat: false 让跨页只重复子列行）
        table.header(
          level: 1,
          repeat: false,
          table.cell(colspan: 2, fill: framableu, align: center)[#text(fill: rgb("#FFFFFF"), weight: "bold")[元件与参数]],
          table.cell(colspan: 2, fill: framableu, align: center)[#text(fill: rgb("#FFFFFF"), weight: "bold")[默认与家族]],
        ),
        // level 2 子列行：总数与 columns 对齐，样式沿用单层表头写法，浅一档拉开层级
        table.header(
          level: 2,
          table.cell(fill: framableu.lighten(10%))[#text(fill: rgb("#FFFFFF"), weight: "bold")[元件]],
          table.cell(fill: framableu.lighten(10%))[#text(fill: rgb("#FFFFFF"), weight: "bold")[关键参数]],
          table.cell(fill: framableu.lighten(10%))[#text(fill: rgb("#FFFFFF"), weight: "bold")[默认]],
          table.cell(fill: framableu.lighten(10%))[#text(fill: rgb("#FFFFFF"), weight: "bold")[家族]],
        ),
        // 主体行：偶数数据行手动斑马纹（lighten(93%)），末行（boitefilled）升格强调
        table.cell()[keyline],
        table.cell()[color · size],
        table.cell()[auto],
        table.cell()[数据元件],
        table.cell(fill: framableu.lighten(93%))[stat],
        table.cell(fill: framableu.lighten(93%))[amount-size · color],
        table.cell(fill: framableu.lighten(93%))[34pt],
        table.cell(fill: framableu.lighten(93%))[数据元件],
        table.cell()[body-slide],
        table.cell()[kicker · inner · closing],
        table.cell()[none],
        table.cell()[页面骨架],
        table.cell(fill: framableu.lighten(85%), stroke: (bottom: 1.2pt + framableu))[#text(weight: "bold")[boitefilled]],
        table.cell(fill: framableu.lighten(85%), stroke: (bottom: 1.2pt + framableu))[#text(weight: "bold")[color · stretch]],
        table.cell(fill: framableu.lighten(85%), stroke: (bottom: 1.2pt + framableu))[#text(weight: "bold")[auto]],
        table.cell(fill: framableu.lighten(85%), stroke: (bottom: 1.2pt + framableu))[#text(weight: "bold")[卡片与网格]],
      )
    ]
    #v(gap-primary)
    #note[列宽单位：1fr 按比例分剩余宽度、auto 按内容、也可传绝对长度（如 4cm）。]
  ],
  closing: note[多级表头跨页：默认两行重复；分组行加 repeat: false 只续子列行。],
)

// 用法: #figure-block(image("../assets/sample-scheme.svg"), caption: none, width: 88%)
//        + 图文叠加（外层 block + #place 半透明白文字条）+ 调用点自排居中图注
//        —— #block(width: 88%)[#align(center)[#text(size, fill)[图 1：…]]]
// 改这里: img 传 `image(...)` 调用（路径相对本文件，showcase/ 下写 ../assets/）；width 为图
//         与图注共享宽度；要居中图注时 caption 传 none，自排那行的 size / fill 沿
//         lib 默认（0.63em / framagris）；想保留左对齐就直接用 caption 参数（默认路线）。
//         叠加条文案改 #place 里那行 text；底色浓度改 8 位十六进制的透明度两位。
// ⚠ 坑: ① `image(...)` 调用处**不要写 width**——块内 #set image(width: 100%) 接管，
//        显式 width 会覆盖它导致溢出；② caption 内嵌 #align(center) 不可行（text 内
//        不能放 block 级元素），居中必须走 caption: none + 容器内 align；③ 原生 `figure`
//        （自动编号、进目录，走 main.typ 的 figure.caption 规则）与 `figure-block`
//        （手写"图 1："、不编号）是两条 caption 路径，借页时按需选一条，勿混用；
//        ④ 图文叠加层必须与图**同住一个外层 block**（#place 锚定该块的左上角），
//        不能塞进 figure-block——它体内的 set image(width: 100%) 只管图，叠加物
//        进去会被当正文排在图下方；半透明白底用 8 位十六进制（rgb("#FFFFFFD9")，
//        末两位是 alpha）。
== 图片 · image

#body-slide(
  kicker: [一张图占一半版面，另一半留给解说],
  inner: [
    #grid(
      columns: (1fr, 1fr),
      gutter: 1em,
      [
        // 图文叠加：叠加条与 figure-block 同住一个 88% 外层 block，
        // #place(top + left) 锚定块左上角压在图上（place 不占文档流，
        // 不改变整页高度）；figure-block 的 width 相应改为 100% 占满外层。
        #block(width: 88%)[
          #place(top + left, dx: 0.6em, dy: 0.6em)[
            #block(radius: 3pt, fill: rgb("#FFFFFFD9"), inset: (x: 0.55em, y: 0.35em))[
              #text(size: 0.72em, fill: framagrisdark)[*图文叠加* · 半透明白底压图]
            ]
          ]
          #figure-block(image("../assets/sample-scheme.svg"), caption: none, width: 100%)
        ]
        #v(0.1em)
        #block(width: 88%)[#align(center)[#text(size: 0.63em, fill: framagris)[图 1：样例示意图（assets/sample-scheme.svg）]]]
      ],
      [
        #boitebleue[
          *放图要点*
          - 图用 #raw("#image(width, path)") 约束宽度，#raw("#figure-block") 接管图注（同宽同左缘、间距/字号参数化）。
          - 示意图统一放 assets/，路径从仓库根写起。
          - 图文叠加走「外层 block + #place」，别把叠加物塞进 figure-block。
        ]
      ],
    )
  ],
  closing: note[原生 figure 能自动编号进目录（figure.caption 规则在 main.typ）；figure-block 是手写"图 1："的路，借页选一条。],
)

// 用法: #figure-block ×3 + #grid(columns: (1fr, 1fr, 1fr)) —— 三图一线多子图
// 改这里: 每格一个 figure-block，width: 100% 占满格宽（image 里**别**写 width）；
//         gutter 用 gutter-tight 收紧子图间距；caption 传 none，格内自排一行
//         #v(0.1em) + #align(center)[#text(0.63em, framagris)[(a) …]]——窄格里
//         左对齐观感偏，居中与正文 (a)/(b)/(c) 引用呼应。
// ⚠ 坑: 多子图仍走 figure-block 之手写 caption 路径（不进目录、不计数），勿与原生
//        figure 混排；同格宽时挑纵横比一致的 SVG（本页三图 viewBox 同为 800×520），
//        否则行高被最矮的图撑住、高的会溢出格底。
== 多子图 · 三图一线

#body-slide(
  kicker: [三张子图一页排，(a)(b)(c) 手写标注],
  inner: [
    #grid(
      columns: (1fr, 1fr, 1fr),
      gutter: gutter-tight,
      [#figure-block(image("../assets/sample-scheme.svg"), caption: none, width: 100%)
       #v(0.1em)
       #align(center)[#text(size: 0.63em, fill: framagris)[(a) 示意图]]],
      [#figure-block(image("../assets/sample-chart.svg"), caption: none, width: 100%)
       #v(0.1em)
       #align(center)[#text(size: 0.63em, fill: framagris)[(b) 柱状图]]],
      [#figure-block(image("../assets/sample-data.svg"), caption: none, width: 100%)
       #v(0.1em)
       #align(center)[#text(size: 0.63em, fill: framagris)[(c) 时段图]]],
    )
  ],
  closing: note[多子图仍走 figure-block 的手写 caption 路（不进目录、不计数），勿混原生 figure；同格宽时挑纵横比一致的 SVG（本页三图 viewBox 同为 800×520），否则行高被最矮的图撑住。],
)

// 用法: #show link: it => ... 给「本页起的全部链接」统一上主题色＋下划线；
//       #link("https://..."[文字]) 外链；#link(<标签>)[文字] 内链
// 改这里: 样式规则写在 #show link 里，用 underline(text(fill: 主题色, it)) 包住整个
//         link 元素——最外层是 underline 不是 link，不递归、链接可点性保留；
//         换色改两处：text 的 fill 与 underline 的 stroke（0.5pt 细线即可）。
// ⚠ 坑: show 规则自声明点起对文档后续链接全局生效——本 deck 之后只有同族代码块页
//        （无链接）与「示意图与公式」家族（无链接），安全；若后续某页要恢复默认样式，写
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

// 用法: #show raw: set text(font: (…)) + 浅底顶线 block 包 ```typst 围栏 —— 代码块页
//        （行内 #raw() 不加底色不换字号；块级 raw 走 0.78em）
// 改这里: 代码写在 ```typst 围栏里（样例即最小可用样例，可直接替换）；容器参数——
//         fill: framagrislight / 顶线 1.5pt 取当页 accent（context 里读
//         accent-state）/ radius 4pt / inset (x: 0.9em, y: 0.65em)；等宽回退链
//         改 show raw 的 font 元组（Typst 内嵌 DejaVu Sans Mono 零新增依赖，
//         CJK 注释落 deck 主字体）。
// ⚠ 坑: ① 顶线是 1.5pt 横线，与 boite 卡片的 3pt 左竖条「方向/粗细」双差异，
//        别改成左竖线——会和卡片视觉语言撞车；② 演示代码里别出现本画廊入口
//        注释的字样（门禁按行子串计数会把样例代码误计入用法基线）；③ 代码页
//        零链接：围栏里的 URL 只是文本，但也别写 #link；④ 行内 raw 不加底色
//        不换字号——与正文同行高才安静；要行号借页时给围栏自行加参数。
== 代码块 · raw

#body-slide(
  kicker: [行内不抢戏，块级浅底顶线],
  inner: [
    #show raw: set text(font: ("DejaVu Sans Mono", "Noto Sans CJK SC"))
    #show raw.where(block: true): set text(size: 0.78em)
    行内代码 #raw("#boitebleue") 与正文同基线、不加底色——读起来不割裂。
    #v(gap-secondary)
    #context {
      let c = accent-state.get()
      block(
        radius: 4pt,
        fill: framagrislight,
        stroke: (top: (paint: c, thickness: 1.5pt)),
        inset: (x: 0.9em, y: 0.65em),
      )[
        ```typst
        // 代码示例：三卡等高网格（show.cards 的最简调用）
        #stretch-grid(
          columns: 3,
          gutter: gutter-tight,
          boitebleue(stretch: true)[短卡],
          boiteverte(stretch: true)[中等长度的卡],
          boiteorange(stretch: true)[内容不齐也会拉成等高],
        )
        ```
      ]
    }
    #v(gap-primary)
    #note[不加行号：幻灯片里的代码是「证据」不是「讲稿」，短段落更安静；要行号借页时给围栏自行加参数。]
  ],
  closing: note[等宽回退链：DejaVu Sans Mono（Typst 内嵌，零新增依赖）→ Noto Sans CJK SC（deck 主字体兜住 CJK 注释）；换品牌字体改 show raw 的 font 元组第一位。],
)
