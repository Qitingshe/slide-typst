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

#boitebleue[
  *演示目标*
  - 基于《深入理解 AI Agent —— 设计原理与工程实践》中文内容，用本模板构建一份「全书概览」讲解。
  - 展示模板能力：封面、彩色要点卡片、CeTZ 示意图、数学公式、自动大纲与章节分隔页。
  - 内容主线：核心公式 → 十章速览 → 工程要点 → 小结。
]

= 目录

#outline(title: none, indent: 1em, depth: 1)

= 核心公式
#include "chapters/core.typ"

= 十章速览
#include "chapters/tour.typ"

= 工程要点
#include "chapters/engineering.typ"

= 小结
#include "chapters/wrapup.typ"