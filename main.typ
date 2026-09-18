// main.typ - Typst Beamer 模板（对应 LaTeX 版 main.tex）
#import "lib.typ": *

#show: slide-theme

// 章节编号
#set heading(numbering: none)

// 图注与脚注：更小、更柔和的灰，让正文呼吸（正文字号不变）
#show figure.caption: set text(size: 0.85em, fill: rgb("#767676"))
#show footnote: set text(size: 0.78em, fill: rgb("#767676"))

// 封面
#cover()

// == 内容结构 ==
// 顶层 "=" 为 section，生成章节分隔页
// 二级 "==" 为 single slide（对应 \frame{}）

= Goal

#boitebleue[
  *Goal*
  - 1.
  - 2.
]

= Outline

#outline(title: none, indent: 1em, depth: 1)

= Introduction
#include "chapters/introduction.typ"

= Algorithms
#include "chapters/algorithms.typ"

= Results
#include "chapters/results.typ"

= Discussion
#include "chapters/discussion.typ"