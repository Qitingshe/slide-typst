// main.typ - Typst Beamer 模板（对应 LaTeX 版 main.tex）
#import "lib.typ": *

#show: slide-theme

// 章节编号
#set heading(numbering: none)

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