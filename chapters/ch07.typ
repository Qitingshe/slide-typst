// chapters/ch07.typ - 第 7 章 Agent 的评估
// 强调色：framaviolet（紫），评估是把表现变成可比较的信号
#import "../lib.typ": *

#section-open(
  index: [7],
  title: [Agent 的评估],
  subtitle: [把表现变成可比较的信号],
  color: framaviolet,
)

// ---------- 第 1 页 · framaviolet ----------

== 评估的重要性

#body-slide(
  kicker: [没有度量就没有改进 —— 建立可重复的评估体系是 Agent 迭代的基石],
  inner: [
    - 构建 Agent 时面对大量设计选择，往往没有显而易见的正确答案
    - 评估提供科学决策依据：*对比实验*（改一个变量）和*消融实验*（逐个关闭组件）
    #v(gap-primary)
    #term-rows(
      label-width: 6.5em,
      rows: (
        (label: [用什么模型更好？], value: [模型替换实验：固定 Harness，只换模型], color: framaviolet),
        (label: [要暴露哪些工具？], value: [消融实验：逐个关闭工具观察效果变化], color: framaviolet),
        (label: [知识库该怎么构建？], value: [对比不同分块/检索策略], color: framaviolet),
        (label: [Harness 需要哪些约束？], value: [逐一开关约束组件，观察性能变化], color: framaviolet),
      ),
    )
  ],
  closing: boitefilled[评估的对象应是模型与 Harness 的组合体 —— 同模型不同 Harness 表现可能悬殊],
)

// ---------- 第 2 页 · framaviolet ----------

== 评估环境与方法

#body-slide(
  kicker: [不同的环境覆盖不同的 Agent 能力维度],
  inner: [
    #cmp-grid(
      lhs: (title: [测试能力], color: framaviolet),
      rhs: (title: [场景], color: framagris),
      label-width: 6.2em,
      row-gap: 0.2em,
      rows: (
        (label: [SWE-bench], left: [代码修复能力], right: [Issue → 补丁]),
        (label: [OSWorld], left: [计算机操作], right: [GUI 操作]),
        (label: [GAIA], left: [综合推理], right: [多步搜索 + 工具调用]),
        (label: [Terminal Bench], left: [终端操作], right: [命令行任务]),
        (label: [Android World], left: [手机操作], right: [App 交互]),
      ),
    )
    #v(gap-primary)
    - 评估指标 · 实验 7-4 AutoEval
  ],
  closing: boitegrise[*核心* 把表现变成可比较的信号 —— 客服类场景 → τ²-bench],
)

// ---------- 第 3 页 · framaviolet ----------

== 评估驱动选型

#body-slide(
  kicker: [模型 / 工具 / 编排怎么选？在你自己任务上实测],
  inner: [
    #stretch-grid(
      columns: 2,
      gutter: gutter-primary,
      boiteverte(stretch: true)[
        *统计显著性*
        - 多次运行 + 置信区间
        - 区分真实差异与随机噪声
        - `Pass@k` vs `Pass^k`
      ],
      boiteorange(stretch: true)[
        *回归防护*
        - 每次改动都要回测
        - 防止能力退化
        - 评估数据透明、可审计
      ],
    )
    #v(gap-primary)
    - *技术奇观*（`Pass@k`）：看能力上限 —— 让模型多次尝试，取最好的 k 次
    - *业务可靠性*（`Pass^k`）：看稳定下限 —— 要求 k 次连续成功
  ],
  closing: boitefilled[别只看排行榜：自己的评估才作数],
)
