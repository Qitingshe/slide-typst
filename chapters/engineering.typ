// chapters/engineering.typ - 工程要点（Harness 五要素 / 范式演进 / 全书数据与阅读路径）
// 每页强调色走位：framableu → framaorange → framaviolet，在各页末尾声明下一页颜色。
// （第一页省略声明——直接沿用默认强调色 framableu。）
#import "../lib.typ": *

// ---------- 开场页（独立干净页，无页眉/页脚）----------
#section-open(
  title: [工程要点],
  subtitle: [从公式到生产：Harness 五要素与范式演进],
  color: framableu,
)

// ---------- 第 1 页 · 强调色 framableu（默认，无需声明）----------

== Harness 五要素

#keyline[生产级 Agent 的工程骨架]

#align(center)[
  #text(size: 15.5pt, weight: "bold", fill: framagrisdark)[$"Agent" = "Model" + "Harness"$]
]
#align(center)[
  #text(size: 13pt, weight: "bold", fill: framableu)[$"Harness" = "上下文管理" + "工具接口" + "约束" + "验证" + "纠正"$]
]

#v(0.4em)

#grid(
  columns: (1fr, 1fr, 1fr),
  rows: (92.2pt, 92.2pt),
  row-gutter: 0.5em,
  column-gutter: 0.7em,
  boitebleue(stretch: true)[*Context 上下文* —— 信息要充分：提示词、知识库、Sidecar],
  boiteverte(stretch: true)[*Tools 工具接口* —— 命名直观、参数有例（MCP）],
  boiterouge(stretch: true)[*Constrain 约束* —— 故障安全默认值，显式开放],
  boiteorange(stretch: true)[*Verify 验证* —— 只看结构化数据，防提示注入],
  boitejaune(stretch: true)[*Correct 纠正* —— 静默重试、熔断、回退人工],
)

#v(0.3em)

#note[行业转向：生产系统从「能做事」转向「可靠地做事」——约束 + 验证 + 纠正]

// 下一页强调色：本页末尾收尾声明（被吸收，不翻页）
#slide-accent(framaorange)

// ---------- 第 2 页 · 强调色 framaorange ----------

== 范式演进

#keyline[层层包含，不是替代：提示 → 上下文 → Harness → Loop → Graph]

- *提示工程*：优化给模型的自然语言指令
- *上下文工程*：系统性管理模型看到的所有信息（← 包含提示工程）
- *Harness 工程*：上下文 + 工具 + 约束 + 验证 + 纠正（← 包含前两者）
- *Loop 工程*：跨轮次持续自主运转 —— 谁发现下一件事、何时才算完成
- *Graph 工程*：把循环、确定性程序与人工审批组织成显式执行图

#v(0.3em)

#boitebleue[
  *实证* LangChain 在 Terminal Bench 2.0 上从 52.8% 提到 66.5%（30 名开外 → 前 5）。模型没变，换的是 Harness。
]

// 下一页强调色：本页末尾收尾声明（被吸收，不翻页）
#slide-accent(framaviolet)

// ---------- 第 3 页 · 强调色 framaviolet ----------

== 全书数据与阅读路径

#keyline[10 章正文 · 109 实验 · 15 语言：把书用起来]

#v(0.3em)

#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  rows: (79.9pt,),
  gutter: 0.6em,
  stat(stretch: true)[10][正文章节],
  stat(stretch: true)[109][配套实验],
  stat(stretch: true)[15][语言版本],
  stat(amount-size: 26pt, stretch: true)[48.3k][GitHub ★],
)

#v(0.3em)

- 每章 4–19 个实验，从基础到生产
- PDF / EPUB 离线阅读；在线多语言切换、高亮笔记、实验直达
- 实验复现：`uv sync --locked --extra ch1`（ch1~ch10），按各实验 README 配置模型 API Key

#v(0.3em)

#note[姊妹篇：《深入理解 AI Infra》；学习路径见 docs/zh-CN/LEARNING.md]

// 收尾：把强调色还给默认 framableu，让下一节（小结）沿用它
#slide-accent(framableu)