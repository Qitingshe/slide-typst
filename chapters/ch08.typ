// chapters/ch08.typ - 第 8 章 模型后训练
// 强调色：framaorange（橙），后训练把决策策略内化为参数
#import "../lib.typ": *

#section-open(
  index: [8],
  title: [模型后训练],
  subtitle: [预训练 / SFT / RL，把决策策略内化为参数],
  color: framaorange,
)

// ---------- 第 1 页 · framaorange ----------

== 三阶段训练

#body-slide(
  kicker: [知识靠预训练，行为靠后训练],
  inner: [
    - 预训练：海量互联网文本，习得语言规律与世界知识
    - SFT：模仿示范行为——数据充分、成本较低、行为可控
    - RL：面向决策策略——何时调用工具、调哪个、传什么参数
  ],
  closing: note[三阶段把「决策策略」逐步内化为模型参数],
)

// ---------- 第 2 页 · framaorange ----------

== SFT vs RL

#body-slide(
  kicker: [模仿已知答案，还是探索最优策略],
  inner: [
    #stretch-grid(
      columns: 2,
      gutter: gutter-primary,
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
    #v(gap-primary)
    - 怎么选：行为可控优先 SFT；需要探索与决策优化时上 RL
    - 实践中常组合：先 SFT 打底，再 RL 打磨决策
    - 实验 8-beck：MiniMind 预训练 + SFT vs RL 对比
  ],
)

// ---------- 第 3 页 · framaorange ----------

== 工具调用内化

#body-slide(
  kicker: [当调用成为本能：模型即 Agent],
  inner: [
    - 工具调用内化 = 模型即 Agent（Kimi K3、GPT-5.6 为代表）
    - 从「外挂提示」到「原生能力」：参数里长出调用习惯
    - 实验栈：MiniMind 预训练、SFT vs RL、verl / ReTool、RLVP、SimpleVLA-RL（共 19 个实验）
  ],
)