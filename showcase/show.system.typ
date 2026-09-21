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

      // 栏 1 · 调色板概览（mini 色卡矩阵：8 原色 + 8 浅色 + 2 深灰）
      block(inset: 0pt)[
        #text(size: 0.65em, weight: "bold", fill: framableu)[调色板 #text(size: 0.45em, fill: framagris)[18色]]
        #v(0.1em)
        #let _dot(name, c, fore: rgb("#FFFFFF")) = {
          block(fill: c, radius: 2pt, height: 0.9em, width: 100%, inset: (x: 0.2em, y: 0.05em))[
            #text(size: 0.4em, fill: fore, weight: "medium")[#name]
          ]
        }
        #grid(columns: 2, gutter: 0.15em,
          _dot("bleu", framableu),
          _dot("bleuL", framableulight, fore: framagrisdark),
          _dot("vert", framavert, fore: framagrisdark),
          _dot("vertL", framavertlight, fore: framagrisdark),
          _dot("rouge", framarouge),
          _dot("rougeL", framarougelight, fore: framagrisdark),
          _dot("violet", framaviolet),
          _dot("violetL", framavioletlight, fore: framagrisdark),
          _dot("orange", framaorange, fore: framagrisdark),
          _dot("orangeL", framaorangelight, fore: framagrisdark),
          _dot("jaune", framajaune, fore: framagrisdarkest),
          _dot("jauneL", framajaunelight, fore: framagrisdark),
          _dot("marron", framamarron, fore: framagrisdark),
          _dot("marronL", framamarronlight, fore: framagrisdark),
          _dot("gris", framagris),
          _dot("grisL", framagrislight, fore: framagrisdark),
          _dot("grisD", framagrisdark),
          _dot("grisDE", framagrisdarkest),
        )
        #v(0.08em)
        #note[#text(size: 0.48em)[中明度底（vert/orange/jaune/marron）配深字]]
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
          block(width: auto, inset: (x: 3pt, y: 1.5pt), radius: 2pt, fill: framagrisdark)[#text(size: 0.5em, fill: rgb("#FFFFFF"), weight: "medium")[stat]],      text(size: 0.5em)[30pt],
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
