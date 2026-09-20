// main.typ - Slide 模板画廊：用样例演示 lib.typ 设计系统的每个元件
//
// 结构：封面 → 快速开始 → 目录 → 十个家族。每个家族 = 一张 section-open 开场页
// + 若干演示页（`==`）。文档流顺序即目录顺序；include 列表显式列举，禁止 glob。
//
// 借页：每个 showcase/*.typ 的每一页顶部都有「用法 / 改这里 / ⚠ 坑」三段注释，
// 连同页面一起复制即可搬到自己的 deck。lib.typ 只提供通用元件，本 deck 的
// 身份元数据（config-info）在此声明。
#import "lib.typ": *

// 设计系统（lib.typ）只含通用配置；本 deck 的身份元数据（config-info）在此声明，
// 由 touying 默认页脚渲染成三格：作者 / deck 标题 / 日期+页码（N/M）。
// 借阅者改这几行即可换成自己的 deck。
#show: slide-theme.with(config-info(
  title: [Slide 模板画廊],
  subtitle: none,
  author: [QITINGSHE],
  date: datetime.today(),
  institution: [slide-typst],
  contact: none,
  logo: none,
))

// 中文字体回退：西文使用模板默认衬线，中文回退到系统字体 Heiti SC。
// 全局字号 0.85em：单帧高度内容纳更充分的内容（约 15-16 行容量）。
#show: set text(font: ("New Computer Modern", "Heiti SC"), size: 0.85em)

// 全局字符级两端对齐（Typst 0.15 justify/justification-limits）：
// justify: true 开两端对齐；justification-limits 是关键——`spacing` 控制词距自适应
// （默认 66.67%–150%，通常不用动），`tracking` 是字符级字距的自适应范围，默认
// (0pt, 0pt) 即「禁用」——只有放开 tracking 才真正启用中文字符级对齐
// （中文无空格，完全靠字距；Web 端 equivalent typography 的 character-based
// justification）。min: -0.01em 允许轻微收缩、max: 0.02em 允许轻微拉伸，
// 都是亚像素级且是官方推荐的字符级路线的取值范围，避免一两行长尾被硬拽。
#set par(
  justify: true,
  justification-limits: (
    spacing: (min: 66.67%, max: 150%),
    tracking: (min: -0.01em, max: 0.02em),
  ),
)

// 章节编号
#set heading(numbering: none)

// 页标题（每页 slide 的标题）样式在 lib.typ 的 slide-theme → header 中定义。
// 注意：Touying 会把 `==` 标题从正文移到页眉（header）渲染，在正文里对
// `#show heading.where(level: 2)` 写 show 规则不会生效。

// ============ 封面 ============
#cover(
  title: [Slide 模板画廊],
  subtitle: [lib.typ 设计系统 · 元件样例与借页指南],
  author: [QITINGSHE],
  institution: [slide-typst],
  date: datetime.today().display(),
)

// ============ 快速开始 ============
// 裸 level 2：目录以 depth 1 收录，天然不收二级标题，故它不进目录。
== 快速开始

#body-slide(
  kicker: [每页都是一个可整页抄走的样例],
  inner: [
    #boitebleue[
      *这是什么*：`lib.typ` 是设计系统（版式元件 + Framasoft 配色），本 deck 用样例把每个
      元件演示一遍。看到想要的页，连同它的 `// 用法` 注释一起复制即可。
    ]
    #v(gap-secondary)
    #grid(
      columns: 2,
      column-gutter: 1em,
      boiteverte[
        *怎么读* —— 每页顶部三段注释：`// 用法:` 讲这是哪个模板与关键参数；`// 改这里:`
        指出改哪儿；`// ⚠ 坑:` 列出一定会抄错的点。
      ],
      boiteorange[
        *结构* —— 封面 → 快速开始 → 目录 → 十个家族。每个家族一张 `section-open`
        开场页，后接若干 `==` 演示页。
      ],
    )
  ],
  closing: note[十族：封面与开场 · 页面骨架 · 卡片与网格 · 数据元件 · 导航与目录 · 配色与强调 · 常规元素 · 示意图与公式 · 数据图表 · 表格与流程。],
)

// ============ 目录 ============
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
  ) + v(0pt) // 条目行距：在 outline 自带间距上已足以换行，不额外补间距；10 行目录收紧（原 0.35em→0.2em→0.13em→0.08em→0pt，逐档试到收尾行回本页）
}

#body-slide(
  kicker: none,
  inner: [
    #v(0.25em) // 页顶留白：收紧让 10 行清单 + 收尾回本页
    #outline(title: none, depth: 1)
  ],
  closing: [#align(center)[#text(size: 0.72em, fill: framagris)[十个家族 · 从封面门面到表格流程]]],
  closing-gap: 0pt, // 10 行清单 + 收尾：0.6em→0.28em→0.2em→0.1em→0pt 逐档收紧，配合条目行距回本页
)

// ============ 家族 ============
// 每个 `=` 家族紧跟一张 section-open 开场页（换一次强调色），再 include 演示文件。

= 封面与开场
#section-open(title: [封面与开场], subtitle: [整份 deck 的头尾门面], color: framableu)
#include "showcase/show.cover.typ"

= 页面骨架
#section-open(title: [页面骨架], subtitle: [body-slide 与节奏间距], color: framableu)
#include "showcase/show.skeleton.typ"

= 卡片与网格
#section-open(title: [卡片与网格], subtitle: [boite 家族与 stretch-grid], color: framaviolet)
#include "showcase/show.cards.typ"

= 数据元件
#section-open(title: [数据元件], subtitle: [keyline · stat · note · 强调], color: framaorange)
#include "showcase/show.data.typ"

= 导航与目录
#section-open(title: [导航与目录], subtitle: [自动目录与页面 chrome], color: framableu)
#include "showcase/show.nav.typ"

= 配色与强调
#section-open(title: [配色与强调], subtitle: [frama 调色板与页级走位], color: framavert)
#include "showcase/show.color.typ"

= 常规元素
#section-open(title: [常规元素], subtitle: [表格 · 图片 · 链接], color: framagris)
#include "showcase/show.basic.typ"

= 示意图与公式
#section-open(title: [示意图与公式], subtitle: [CeTZ 画布与数学块], color: framarouge)
#include "showcase/show.cetz.typ"

= 数据图表
#section-open(title: [数据图表], subtitle: [饼图 · 柱状图 · 线性图], color: framaviolet)
#include "showcase/show.charts.typ"

= 表格与流程
#section-open(title: [表格与流程], subtitle: [cmp-grid · term-rows · flow-steps · center 变体], color: framableu)
#include "showcase/show.tables.typ"
