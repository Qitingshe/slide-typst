// chapters/ch07.typ - 第 7 章 Agent 的评估
#import "../lib.typ": *

// ==== v2 章节约定（其他章节照此改写）====
// 1. 章首用一张 section-open 开场页，并在这里声明本章的强调色与面包屑：
//      #section-open(index: [7], title: [Agent 的评估], subtitle: [...], color: framaviolet)
//    - index 为书章节序号（内容分段省略 index）。
//    - color 会自动写入 accent-state，之后本页/本章的 keyline、stat、
//      boitefilled、页眉紧凑标题都自动沿用该色。
//    - 面包屑自动生成为「第 7 章 · Agent 的评估」，显示在内页右上角。
// 2. `==` 标题只写「主题」，不再重复「第 N 章 ·」前缀（前缀已进开场页与面包屑）。
// 3. 章节之间不再需要 #slide-accent(...) 交接色：下一章的 section-open 会自行声明。
// 4. 切记：section-open 必须紧跟在 `=` 之后、本章第一个 `==` 之前，且放在
//    `==` 标题之前不要写 #slide-accent(...)（会凭空多出一页）。

// ---------- 第 7 章 开场页（独立干净页，无页眉/页脚）----------
#section-open(
  index: [7],
  title: [Agent 的评估],
  subtitle: [把表现变成可比较的信号],
  color: framaviolet,
)

// ---------- 第 1 页 · 强调色 framaviolet ----------

== 评估环境与指标

#body-slide(
  kicker: [环境定边界，指标定优劣],
  inner: [
    - 评估环境：SWE-bench / OSWorld / GAIA / Terminal Bench / AndroidWorld——各覆盖一类 Agent 能力
    - 指标：任务成功率、步骤效率、成本、可靠性
    - 看「任务完成」而非「给出回答」
  ],
  closing: boitegrise[*核心* 把表现变成可比较的信号],
)

// ---------- 第 2 页 · 强调色 framaviolet ----------

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

// 下一章强调色由 ch08 的 section-open 自行声明，这里不再交接。