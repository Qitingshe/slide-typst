// chapters/ch05.typ - 第 5 章 Coding Agent 与通用 Agent
//
// ==== v2 章节约定（其他章节照此改写）====
// 1. 章首用一张 section-open 开场页，并在这里声明本章的强调色与面包屑：
//      #section-open(index: [5], title: [Coding Agent 与通用 Agent], subtitle: [...], color: framableu)
//    - index 为书章节序号（内容分段省略 index）。
//    - color 会自动写入 accent-state，之后本页/本章的 keyline、stat、
//      boitefilled、页眉紧凑标题都自动沿用该色。
//    - 面包屑自动生成为「第 5 章 · Coding Agent 与通用 Agent」，显示在内页右上角。
// 2. `==` 标题只写「主题」，不再重复「第 5 章 ·」前缀（前缀已进开场页与面包屑）。
// 3. 章节之间不再需要 #slide-accent(...) 交接色：下一章的 section-open 会自行声明。
// 4. 切记：section-open 必须紧跟在 `=` 之后、本章第一个 `==` 之前，且放在
//    `==` 标题之前不要写 #slide-accent(...)（会凭空多出一页）。
#import "../lib.typ": *

// ---------- 第 5 章 开场页（独立干净页，无页眉/页脚）----------
#section-open(
  index: [5],
  title: [Coding Agent 与通用 Agent],
  subtitle: [代码是「能创造新工具的工具」],
  color: framableu,
)

// ---------- 第 1 页 · 强调色 framableu ----------

== 增量开发循环

#keyline[小步快跑：每次只改一点，立刻验证]

#v(0.3em)

- 增量开发循环：理解需求 → 搜索相关代码 → 编辑 → 测试 → 调试修复
- 代码解释器：受限 Python 沙盒，读表 / 清洗 / 统计 / 绘图一站式
- 沙盒安全：默认无网络、路径受限、时间 / CPU / 内存 / 输出上限

#v(0.4em)

#note[代码是「能创造新工具的工具」——编码能力是 Agent 的杠杆]

// ---------- 第 2 页 · 强调色 framableu ----------

== 通用 Agent 与基准

#keyline[专用 ∪ 通用：Agent 能力的并集]

#v(0.3em)

- 通用 Agent = Coding + Deep Research + Computer Use 观察 / 动作空间的并集
- 基准：SWE-bench、Terminal Bench 等，量化「会不会修代码」
- 权衡：通用性 vs 深度；工具越多决策空间越大（衔接 §7 评估）

// 下一章强调色由 ch06 的 section-open 自行声明，这里不再交接。