// main.typ - 基于《深入理解 AI Agent》中文内容的幻灯片演示
// 结构：封面 + 目标 + 目录 + 四个分段（核心公式 / 十章速览 / 工程要点 / 小结）
#import "lib.typ": *

#show: slide-theme

// 中文字体回退：西文使用模板默认衬线，中文回退到系统字体 Heiti SC
// 全局字号 0.85em：在单帧高度内容纳更充分的内容（约 15-16 行容量）
#show: set text(font: ("New Computer Modern", "Heiti SC"), size: 0.85em)

// 章节编号
#set heading(numbering: none)

// 图注与脚注：更小、更柔和的灰，让正文呼吸（正文字号不变）
#show figure.caption: set text(size: 0.85em, fill: rgb("#767676"))
#show footnote: set text(size: 0.78em, fill: rgb("#767676"))

// 页标题（每页 slide 的标题）的样式在 lib.typ 的 slide-theme → header 中定义。
// 注意：Touying 会把 `==` 标题从正文移到页眉（header）渲染，在正文里对
// `#show heading.where(level: 2)` 写 show 规则不会生效。

// 封面
#cover(
  title: [深入理解 AI Agent],
  subtitle: [设计原理与工程实践 —— 全书概览],
  author: [QITINGSHE],
  institution: [bojieli/ai-agent-book],
)

// == 内容结构 ==
// 顶层 "=" 为 section，生成章节分隔页
// 二级 "==" 为 single slide（对应 \frame{}）

= 目标

// v2：分段开场页（无自动分隔页，需显式 section-open 接管）+ 显式主题标题
#section-open(title: [目标], subtitle: [演示目标与内容主线])

== 演示目标

#boitebleue[
  *演示目标*
  - 基于《深入理解 AI Agent —— 设计原理与工程实践》中文内容，用本模板构建一份「全书概览」讲解。
  - 展示模板能力：封面、彩色要点卡片、CeTZ 示意图、数学公式、自动大纲与章节分隔页。
  - 内容主线：核心公式 → 十章速览 → 工程要点 → 小结。
]

// 「目录」自身也是 level-1 标题，但不应出现在目录里（避免「目录 → 目录」怪行）；
// 用 outlined: false 把它从 outline 中排除，其余结构/开场页行为不变。
// 注：`=` 速记生成的标题字段名为 depth（Touying 0.7.4 按 it.depth 识别），
// 故这里显式写 depth: 1 以保持与 `=` 完全一致的元素形态。
#heading(depth: 1, outlined: false)[目录]

#section-open(title: [目录], subtitle: [内容地图])

== 内容地图

// 目录页 · 自动目录：条目由各 `=` 分段标题自动生成（outline, depth 1），删改
// 正文章节时目录自动跟随；每条天然链接到对应页（it.element.location()），
// 点击即跳转。「= 目录」自身已以 outlined: false 排除。
// 样式沿用安静语言：2.5pt framableu 细竖条 + 加粗条目名 + 灰字页码靠右。
#show outline.entry: it => {
  link(
    it.element.location(),
    grid(
      columns: (0.55em, auto, 1fr, auto),
      column-gutter: (0.85em, 1.4em, 1em),
      align(horizon + left)[#rect(width: 2.5pt, height: 1.05em, radius: 1.25pt, fill: framableu, stroke: none)],
      text(size: 1.08em, weight: "bold", fill: framagrisdark)[#it.body()],
      [],
      text(size: 0.75em, fill: framagris)[#it.page()],
    ),
  ) + v(0.85em) // 条目行距：在 outline 自带间距上再补一口气，清单更透气
}

#body-slide(
  kicker: none,
  inner: [
    #v(1.8em) // 页顶留白：让清单在页眉细线下方安静落下
    #outline(title: none, depth: 1)
  ],
  // 页尾收束：一行安静的小字，十章只留一条路径，细节交给「十章地图」页
  closing: [#align(center)[#text(size: 0.72em, fill: framagris)[正文十章 · 入门 → 协作]]],
  closing-gap: 1.2em,
)

= 核心公式
#include "chapters/core.typ"

= 十章速览
#include "chapters/tour-map.typ"
#include "chapters/ch01.typ"
#include "chapters/ch02.typ"
#include "chapters/ch03.typ"
#include "chapters/ch04.typ"
#include "chapters/ch05.typ"
#include "chapters/ch06.typ"
#include "chapters/ch07.typ"
#include "chapters/ch08.typ"
#include "chapters/ch09.typ"
#include "chapters/ch10.typ"

= 工程要点
#include "chapters/engineering.typ"

= 小结
#include "chapters/wrapup.typ"