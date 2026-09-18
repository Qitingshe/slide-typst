// chapters/ch07.typ - 第 7 章 Agent 的评估
// 强调色：全章 framaviolet（承接 §6 交接），结尾交接 framaorange
#import "../lib.typ": *

// ---------- 第 1 页 · 强调色 framaviolet（承接 §6，无需声明）----------

== 第 7 章 · 评估环境与指标

#keyline[环境定边界，指标定优劣]

#v(0.4em)

- 评估环境：SWE-bench / OSWorld / GAIA / Terminal Bench / AndroidWorld——各覆盖一类 Agent 能力
- 指标：任务成功率、步骤效率、成本、可靠性
- 看「任务完成」而非「给出回答」

#v(0.5em)

#boitegrise[*核心* 把表现变成可比较的信号]

// ---------- 第 2 页 · 强调色 framaviolet ----------

== 第 7 章 · 评估驱动选型

#keyline[模型 / 工具 / 编排怎么选？在你自己任务上实测]

#v(0.4em)

- 统计显著性：多次运行 + 置信区间，区分真实差异与随机噪声
- 回归防护：每次改动都要回测，防止能力退化
- 评估数据与指标透明、可审计

#v(0.5em)

#boitefilled[别只看排行榜：自己的评估才作数]

// 下一页强调色：本页末尾收尾声明（交接 §8 framaorange）
#slide-accent(framaorange)