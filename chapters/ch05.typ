// chapters/ch05.typ - 第 5 章 Coding Agent 与通用 Agent
// 强调色：framableu（蓝），代码是能创造新工具的工具
#import "../lib.typ": *

#section-open(
  index: [5],
  title: [Coding Agent 与通用 Agent],
  subtitle: [代码是「能创造新工具的工具」],
  color: framableu,
)

// ---------- 第 1 页 · framableu ----------

== 增量开发循环

#body-slide(
  kicker: [小步快跑：每次只改一点，立刻验证],
  inner: [
    - 增量开发循环：理解需求 → 搜索相关代码 → 编辑 → 测试 → 调试修复
    - 代码解释器：受限 Python 沙盒，读表 / 清洗 / 统计 / 绘图一站式
    - 沙盒安全：默认无网络、路径受限、时间 / CPU / 内存 / 输出上限
    - 实验 5-1：Coding Agent 实战——Claude Code / OpenCode 实践
  ],
  closing: note[代码是「能创造新工具的工具」——编码能力是 Agent 的杠杆],
)

// ---------- 第 2 页 · framableu ----------

== 通用 Agent 与基准

#body-slide(
  kicker: [专用 ∪ 通用：Agent 能力的并集],
  inner: [
    - 通用 Agent = Coding + Deep Research + Computer Use 观察 / 动作空间的并集
    - 基准：SWE-bench、Terminal Bench 等，量化「会不会修代码」
    - 权衡：通用性 vs 深度；工具越多决策空间越大（衔接 §7 评估）
  ],
)