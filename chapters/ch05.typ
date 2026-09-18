// chapters/ch05.typ - 第 5 章 Coding Agent 与通用 Agent
// 强调色：framableu（继承自 ch04）；结尾交给 §6 为 framavert。
#import "../lib.typ": *

// ---------- 第 1 页 · 强调色 framableu（继承）----------

== 第 5 章 · 增量开发循环

#keyline[小步快跑：每次只改一点，立刻验证]

#v(0.3em)

- 增量开发循环：理解需求 → 搜索相关代码 → 编辑 → 测试 → 调试修复
- 代码解释器：受限 Python 沙盒，读表 / 清洗 / 统计 / 绘图一站式
- 沙盒安全：默认无网络、路径受限、时间 / CPU / 内存 / 输出上限

#v(0.4em)

#note[代码是「能创造新工具的工具」——编码能力是 Agent 的杠杆]

// ---------- 第 2 页 · 强调色 framableu ----------

== 第 5 章 · 通用 Agent 与基准

#keyline[专用 ∪ 通用：Agent 能力的并集]

#v(0.3em)

- 通用 Agent = Coding + Deep Research + Computer Use 观察 / 动作空间的并集
- 基准：SWE-bench、Terminal Bench 等，量化「会不会修代码」
- 权衡：通用性 vs 深度；工具越多决策空间越大（衔接 §7 评估）

// 下一页强调色：本页末尾收尾声明（衔接 §6）
#slide-accent(framavert)