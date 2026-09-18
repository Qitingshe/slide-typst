// chapters/ch08.typ - 第 8 章 模型后训练
// 强调色：全章 framaorange（承接 §7 交接），结尾交接 framamarron
#import "../lib.typ": *

// ---------- 第 1 页 · 强调色 framaorange（承接 §7，无需声明）----------

== 第 8 章 · 三阶段训练

#keyline[知识靠预训练，行为靠后训练]

#v(0.4em)

- 预训练：海量互联网文本，习得语言规律与世界知识
- SFT：模仿示范行为——数据充分、成本较低、行为可控
- RL：面向决策策略——何时调用工具、调哪个、传什么参数

#v(0.5em)

#note[三阶段把「决策策略」逐步内化为模型参数]

// ---------- 第 2 页 · 强调色 framaorange ----------

== 第 8 章 · SFT vs RL

#keyline[模仿已知答案，还是探索最优策略]

#v(0.4em)

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    #boiteverte[
      #align(center)[*SFT*]
      - 监督学习，模仿示范
      - 快而稳、成本低
      - 依赖高质量标注数据
    ],
  ],
  [
    #boiteorange[
      #align(center)[*RL*]
      - 奖励信号驱动试错
      - 能发现未示范的策略
      - 训练不稳定、成本高
    ],
  ],
)

#v(0.3em)

- 怎么选：行为可控优先 SFT；需要探索与决策优化时上 RL
- 实践中常组合：先 SFT 打底，再 RL 打磨决策

// ---------- 第 3 页 · 强调色 framaorange ----------

== 第 8 章 · 工具调用内化

#keyline[当调用成为本能：模型即 Agent]

#v(0.4em)

- 工具调用内化 = 模型即 Agent（Kimi K3、GPT-5.6 为代表）
- 从「外挂提示」到「原生能力」：参数里长出调用习惯
- 实验栈：MiniMind 预训练、SFTvsRL、verl / ReTool、RLVP、SimpleVLA-RL（共 19 个实验）

// 下一页强调色：本页末尾收尾声明（交接 §9 framamarron）
#slide-accent(framamarron)