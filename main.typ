// main.typ - 基于《深入理解 AI Agent》中文内容的幻灯片演示
// 结构：封面 + 目标 + 目录 + 四个分段（核心公式 / 十章速览 / 工程要点 / 小结）
//
// 设计系统 lib.typ 提供通用版式元件；本文件只声明 deck 专属元数据与内容结构。
#import "lib.typ": *

// 本 deck 的身份元数据在此声明，由 touying 默认页脚渲染为：作者 / deck 标题 / 日期 + 页码。
#show: slide-theme.with(config-info(
  title: [深入理解 AI Agent],
  subtitle: [设计原理与工程实践 —— 全书概览],
  author: [QITINGSHE],
  date: datetime.today(),
  institution: [bojieli/ai-agent-book],
  contact: none,
  logo: none,
))

// 中文字体回退：西文使用模板默认衬线，中文回退到系统字体 Heiti SC
// 全局字号 0.85em：在单帧高度内容纳更充分的内容（约 15–16 行容量）
#show: set text(font: ("New Computer Modern", "Heiti SC"), size: 0.85em)

// 全局字符级两端对齐——放开 tracking 才真正启用中文字符级对齐。
// min: -0.01em 允许轻微收缩，max: 0.02em 允许轻微拉伸。
#set par(
  justify: true,
  justification-limits: (
    spacing: (min: 66.67%, max: 150%),
    tracking: (min: -0.01em, max: 0.02em),
  ),
)

// 章节编号
#set heading(numbering: none)

// 页标题样式在 lib.typ 的 slide-theme → header 中定义。
// Touying 把 `==` 标题移入 header 渲染，正文的 show heading 规则无效。

// ============ 封面 ============
#cover(
  title: [深入理解 AI Agent],
  subtitle: [设计原理与工程实践 —— 全书概览],
  author: [QITINGSHE],
  institution: [bojieli/ai-agent-book],
  date: datetime.today().display(),
)

// ============ 目标 ============
= 目标

#section-open(title: [目标], subtitle: [演示目标与内容主线])

== 演示目标

#boitebleue[
  *演示目标*
  - 基于《深入理解 AI Agent —— 设计原理与工程实践》中文内容，用本模板构建一份「全书概览」讲解。
  - 展示模板能力：封面、彩色要点卡片、CeTZ 示意图、数学公式、自动大纲与章节分隔页。
  - 内容主线：核心公式 → 十章速览 → 工程要点 → 小结。
]

// ============ 目录 ============
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
  ) + v(0.13em) // 条目行距：在 outline 自带间距上再补一口气；5 行目录收紧
}

#body-slide(
  kicker: none,
  center: true, // 用户点名：目录 5 行 + 收尾在页面正文区垂直居中（上下等距）
  inner: [
    #v(0.5em) // 页顶留白：让清单在页眉细线下方安静落下
    #outline(title: none, depth: 1)
  ],
  closing: [#align(center)[#text(size: 0.72em, fill: framagris)[四个分段 · 从核心公式到小结]]],
  closing-gap: 0.2em, // 5 行清单 + 收尾收紧
)

// ============ 四个分段 ============

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
