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

== 评估环境与指标

#body-slide(
  kicker: [环境定边界，指标定优劣],
  inner: [
    - 评估环境：SWE-bench / OSWorld / GAIA / Terminal Bench / AndroidWorld —— 各覆盖一类 Agent 能力
    - 指标：任务成功率、步骤效率、成本、可靠性
    - 看「任务完成」而非「给出回答」
    - 实验 7-4：设计自己的评估环境——AutoEval 框架
  ],
  closing: boitegrise[*核心* 把表现变成可比较的信号],
)

// ---------- 第 2 页 · framaviolet ----------

== 评估驱动选型

#body-slide(
  kicker: [模型 / 工具 / 编排怎么选？在你自己任务上实测],
  inner: [
    - 统计显著性：多次运行 + 置信区间，区分真实差异与随机噪声
    - 回归防护：每次改动都要回测，防止能力退化
    - 评估数据与指标透明、可审计
  ],
  closing: boitefilled[别只看排行榜：自己的评估才作数],
)