// chapters/ch08.typ - 第 8 章 模型后训练
#import "../lib.typ": *

// ==== v2 章节约定（其他章节照此改写）====
// 1. 章首用一张 section-open 开场页，并在这里声明本章的强调色与面包屑：
//      #section-open(index: [8], title: [模型后训练], subtitle: [...], color: framaorange)
//    - index 为书章节序号（内容分段省略 index）。
//    - color 会自动写入 accent-state，之后本页/本章的 keyline、stat、
//      boitefilled、页眉紧凑标题都自动沿用该色。
//    - 面包屑自动生成为「第 8 章 · 模型后训练」，显示在内页右上角。
// 2. `==` 标题只写「主题」，不再重复「第 N 章 ·」前缀（前缀已进开场页与面包屑）。
// 3. 章节之间不再需要 #slide-accent(...) 交接色：下一章的 section-open 会自行声明。
// 4. 切记：section-open 必须紧跟在 `=` 之后、本章第一个 `==` 之前，且放在
//    `==` 标题之前不要写 #slide-accent(...)（会凭空多出一页）。

// ---------- 第 8 章 开场页（独立干净页，无页眉/页脚）----------
#section-open(
  index: [8],
  title: [模型后训练],
  subtitle: [预训练 / SFT / RL，把决策策略内化为参数],
  color: framaorange,
)

// ---------- 第 1 页 · 强调色 framaorange ----------

== 三阶段训练

#keyline[知识靠预训练，行为靠后训练]

#v(0.4em)

- 预训练：海量互联网文本，习得语言规律与世界知识
- SFT：模仿示范行为——数据充分、成本较低、行为可控
- RL：面向决策策略——何时调用工具、调哪个、传什么参数

#v(0.5em)

#note[三阶段把「决策策略」逐步内化为模型参数]

// ---------- 第 2 页 · 强调色 framaorange ----------

== SFT vs RL

#keyline[模仿已知答案，还是探索最优策略]

#v(0.4em)

#stretch-grid(
  columns: 2,
  gutter: 1em,
  boiteverte(stretch: true)[
    #align(center)[*SFT*]
    - 监督学习，模仿示范
    - 快而稳、成本低
    - 依赖高质量标注数据
  ],
  boiteorange(stretch: true)[
    #align(center)[*RL*]
    - 奖励信号驱动试错
    - 能发现未示范的策略
    - 训练不稳定、成本高
  ],
)

#v(0.3em)

- 怎么选：行为可控优先 SFT；需要探索与决策优化时上 RL
- 实践中常组合：先 SFT 打底，再 RL 打磨决策

// ---------- 第 3 页 · 强调色 framaorange ----------

== 工具调用内化

#keyline[当调用成为本能：模型即 Agent]

#v(0.4em)

- 工具调用内化 = 模型即 Agent（Kimi K3、GPT-5.6 为代表）
- 从「外挂提示」到「原生能力」：参数里长出调用习惯
- 实验栈：MiniMind 预训练、SFTvsRL、verl / ReTool、RLVP、SimpleVLA-RL（共 19 个实验）

// 下一章强调色由 ch09 的 section-open 自行声明，这里不再交接。