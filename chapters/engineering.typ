// chapters/engineering.typ - 工程要点（Harness 五要素 / 范式演进 / 全书数据）
#import "../lib.typ": *

== Harness 工程五要素

#align(center)[
  #text(size: 15.5pt, weight: "bold", fill: framagrisdark)[$"Agent" = "Model" + "Harness"$]
]
#v(0.2em)
#align(center)[
  #text(size: 13pt, weight: "bold", fill: framableu)[$"Harness" = "上下文管理" + "工具接口" + "约束" + "验证" + "纠正"$]
]
#v(0.5em)

#grid(
  columns: (1fr, 1fr, 1fr),
  row-gutter: 0.5em,
  column-gutter: 0.7em,
  boitebleue[*Context 上下文* —— 信息要充分：提示词、知识库、Sidecar],
  boiteverte[*Tools 工具接口* —— 命名直观、参数有例（MCP）],
  boiterouge[*Constrain 约束* —— 故障安全默认值，显式开放],
  boiteorange[*Verify 验证* —— 只看结构化数据，防提示注入],
  boitejaune[*Correct 纠正* —— 静默重试、熔断、回退人工],
)

#v(0.5em)

#boitegrise[
  *行业转向*：早期框架聚焦「能做事」（上下文 + 工具）；生产级系统转向「可靠地做事」（约束 + 验证 + 纠正）——Claude Code 的 Harness 中绝大部分代码正是这三者。
]

== 工程范式演进

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    - *提示工程*：优化给模型的自然语言指令
    - *上下文工程*：系统性管理模型看到的所有信息（← 包含提示工程）
    - *Harness 工程*：上下文 + 工具 + 约束 + 验证 + 纠正（← 包含前两者）
    - *Loop 工程*：跨轮次持续自主运转 —— 谁发现下一件事、何时才算完成
    - *Graph 工程*：把循环、确定性程序与人工审批组织成显式执行图
  ],
  [
    #boiterouge[
      *层层包含，不是替代*
      - 单 Agent 循环正是执行图中的一个节点。
      - 当模型能力趋同，竞争优势转移到模型之外的工程实践。
    ]
    #v(0.7em)
    #boitebleue[
      *实证*
      LangChain 在 Terminal Bench 2.0 上从 52.8% 提到 66.5%（30 名开外 → 前 5）。模型未变，换的是 Harness。
    ]
  ],
)

== 全书数据与阅读路径

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    #boitebleue[
      *内容规模*
      - 10 章正文 · 109 个配套实验 · 15 种语言
      - Apache-2.0 开源 · GitHub 48.3k 星
      - 每章 4–19 个实验，从基础到生产
    ],
  ],
  [
    #boiteverte[
      *阅读与运行*
      - PDF / EPUB 离线阅读（releases/latest，排版最佳）
      - 在线阅读：多语言切换、高亮与笔记、实验直达
      - 实验：`uv sync --locked --extra ch1`（ch1~ch10）；按各实验 README 配置模型 API Key
    ],
  ],
)

#v(0.7em)

#boiteorange[
  *配套延伸*：姊妹篇《深入理解 AI Infra：量化分析与系统设计》；学习路径与难度分级见 docs/zh-CN/LEARNING.md。
]