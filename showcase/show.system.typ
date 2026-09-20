// showcase/show.system.typ
// 家族：设计系统速查 —— 一套图胜过千行注释。
//
// 把所有 token 用可视化方式呈现在一页里：字号标尺、间距对比、卡片构造、溢出边界。
// 借页者不用读 lib.typ 就能快速理解设计系统骨架。
//
// 交叉引用：show.color.typ（调色板展示）、show.skeleton.typ（body-slide 骨架细节）、
// show.cards.typ（卡片用法）。

#import "../lib.typ": *

// 用法: body-slide + 紧凑网格 → 四栏展示设计 token
// 改这里: 调整各栏文字示范内容，不改结构
// ⚠ 坑: 纯参考页，卡片构造用普通 block 示意，不引 _boite-box 以免破坏封装。

== 设计系统速查

#body-slide(
  kicker: [配色 · 间距 · 字体层级 · 卡片构造 · 溢出边界，一页速查],
  inner: [

    #grid(
      columns: (1fr, 1.2fr, 1.3fr, 1.5fr),
      gutter: 0.6em,
      rows: (auto,),

      // 栏 1 · 调色板概览
      block(inset: 0pt)[
        #text(size: 0.65em, weight: "bold", fill: framableu)[调色板]
        #v(0.1em)
        #grid(columns: 2, gutter: 0.2em,
          block(fill: framableu, radius: 2pt, height: 0.6em, width: 100%)[],
          text(size: 0.45em, fill: framagris)[8 原色],
          block(fill: framableulight, radius: 2pt, height: 0.6em, width: 100%)[],
          text(size: 0.45em, fill: framagris)[8 浅色],
          block(fill: framagrisdark, radius: 2pt, height: 0.6em, width: 100%)[],
          text(size: 0.45em, fill: framagris)[2 深灰],
        )
        #v(0.1em)
        #note[#text(size: 0.5em)[深底 → 白字 | 中明度底 → 深字]]
      ],

      // 栏 2 · 间距
      block(inset: 0pt)[
        #text(size: 0.65em, weight: "bold", fill: framavert)[间距]
        #grid(columns: (auto, 1fr), gutter: 0.2em,
          text(size: 0.45em, weight: "bold", fill: framagrisdark)[gap-primary],    text(size: 0.5em)[0.3em],
          text(size: 0.45em, weight: "bold", fill: framagrisdark)[gap-secondary],  text(size: 0.5em)[0.4em],
          text(size: 0.45em, weight: "bold", fill: framagrisdark)[gutter-tight],   text(size: 0.5em)[0.6em],
          text(size: 0.45em, weight: "bold", fill: framagrisdark)[gutter-primary], text(size: 0.5em)[0.8em],
          text(size: 0.45em, weight: "bold", fill: framagrisdark)[gutter-loose],   text(size: 0.5em)[1em],
        )
      ],

      // 栏 3 · 字体
      block(inset: 0pt)[
        #text(size: 0.65em, weight: "bold", fill: framaviolet)[字体层级]
        #grid(columns: (auto, 1fr), gutter: 0.2em,
          block(width: auto, inset: (x: 3pt, y: 1.5pt), radius: 2pt, fill: framagrisdark)[#text(size: 0.5em, fill: rgb("#FFFFFF"), weight: "medium")[keyline]],   text(size: 0.5em)[24pt],
          block(width: auto, inset: (x: 3pt, y: 1.5pt), radius: 2pt, fill: framagrisdark)[#text(size: 0.5em, fill: rgb("#FFFFFF"), weight: "medium")[stat]],      text(size: 0.5em)[34pt],
          block(width: auto, inset: (x: 3pt, y: 1.5pt), radius: 2pt, fill: framagrisdark)[#text(size: 0.5em, fill: rgb("#FFFFFF"), weight: "medium")[body]],      text(size: 0.5em)[0.85em],
          block(width: auto, inset: (x: 3pt, y: 1.5pt), radius: 2pt, fill: framagrisdark)[#text(size: 0.5em, fill: rgb("#FFFFFF"), weight: "medium")[note]],      text(size: 0.45em)[0.75em],
          block(width: auto, inset: (x: 3pt, y: 1.5pt), radius: 2pt, fill: framagrisdark)[#text(size: 0.5em, fill: rgb("#FFFFFF"), weight: "medium")[caption]],   text(size: 0.4em)[0.63em],
        )
      ],

      // 栏 4 · 卡片 & 溢出
      block(inset: 0pt)[
        #text(size: 0.65em, weight: "bold", fill: framarouge)[卡片 | 溢出]
        #block(fill: framableu.lighten(93%), radius: 4pt, inset: 0pt, height: 2.2em)[
          #block(width: 3pt, height: 100%, fill: framableu)
          #box(inset: (x: 0.35em, y: 0.2em))[
            #text(size: 0.5em, fill: framagrisdark)[3pt 竖条 | 4pt 圆角]
            #text(size: 0.45em, fill: framagris)[inset 12pt×9pt]
          ]
        ]
        #v(0.1em)
        #text(size: 0.5em, fill: framagrisdark)[• body-slide inner ≤ 12 行]
        #text(size: 0.5em, fill: framagrisdark)[• stretch-grid 每格 ≤ 3 行]
      ],
    )
  ],
)
