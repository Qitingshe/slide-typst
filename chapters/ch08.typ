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

== 四阶段全景

#body-slide(
  kicker: [知识靠预训练，行为靠后训练],
  inner: [
    #cmp-grid(
      lhs: (title: [做什么], color: framaorange),
      rhs: (title: [类比], color: framagris),
      label-width: 5.2em,
      row-gap: 0.3em,
      rows: (
        (label: [预训练], left: [海量文本上预测下一个词], right: [读遍图书馆的书]),
        (label: [Mid-training], left: [目标领域继续学习], right: [精读专业教材]),
        (label: [SFT], left: [模仿示范行为], right: [师傅手把手教]),
        (label: [RL], left: [奖励信号驱动试错探索], right: [在实践中自己摸索]),
      ),
    )
    #v(gap-primary)
    - 预训练最贵（动辄数千万美元），是所有能力的地基
    - 后训练（SFT + RL）把决策策略逐步内化为模型参数
  ],
  closing: note[现代模型的能力开发通常可以拆成这四个环节],
)

// ---------- 第 2 页 · framaorange ----------

== SFT vs RL

#body-slide(
  kicker: [模仿已知答案，还是探索最优策略],
  inner: [
    - 实践中常组合：先 SFT 打底，再 RL 打磨决策
    #v(gap-primary)
    #cmp-grid(
      lhs: (title: [SFT], color: framavert),
      rhs: (title: [RL], color: framaorange),
      label-width: 5.2em,
      row-gap: 0.3em,
      rows: (
        (label: [学习方式], left: [监督学习], right: [试错学习]),
        (label: [数据需求], left: [高质量标注], right: [奖励信号 + 环境]),
        (label: [发现新策略], left: [不能], right: [能]),
        (label: [训练稳定性], left: [稳定], right: [不稳定]),
        (label: [成本], left: [低], right: [高]),
      ),
    )
  ],
  closing: note[组合不是替代 —— 决策优化阶段才需要 RL 的试错能力],
)

// ---------- 第 3 页 · framaorange ----------

== 工具调用内化

#body-slide(
  kicker: [当调用成为本能：模型即 Agent],
  inner: [
    - *工具调用内化* = 模型即 Agent（Kimi K3、GPT-5.6 为代表）
    - 从「外挂提示」到「原生能力」：参数里长出调用习惯
    #v(gap-primary)
    #cmp-grid(
      lhs: (title: [外挂式], color: framagris),
      rhs: (title: [内化式], color: framaorange),
      label-width: 4.6em,
      row-gap: 0.3em,
      rows: (
        (label: [调用方式], left: [提示词 + 少样本示例], right: [模型原生功能调用]),
        (label: [可靠性], left: [受提示词质量影响], right: [稳定、可预测]),
        (label: [灵活性], left: [易调整提示词], right: [需重新训练]),
        (label: [代表模型], left: [早期 GPT 系列], right: [Kimi K3、GPT-5.6]),
      ),
    )
  ],
  closing: note[实验栈：MiniMind 预训练 · SFT vs RL · verl/ReTool · RLVP · SimpleVLA-RL（共 19 个实验）],
)

// ---------- 第 4 页 · framaorange ----------

== 强化学习基础

#body-slide(
  kicker: [从经典 RL Agent 到现代 LLM Agent],
  inner: [
    - *经典 RL*：智能体（策略 π）+ 环境（状态 s、奖励 r）；*LLM Agent*：模型（LLM）+ 上下文（轨迹）+ 工具
    #v(gap-primary)
    #cmp-grid(
      lhs: (title: [经典 RL], color: framagris),
      rhs: (title: [LLM Agent], color: framaorange),
      label-width: 5.2em,
      row-gap: 0.25em,
      rows: (
        (label: [策略], left: [π(a|s)], right: [LLM 生成 token]),
        (label: [状态], left: [环境状态 s], right: [上下文 + 轨迹]),
        (label: [动作], left: [离散/连续动作 a], right: [文本 token + 工具调用]),
        (label: [奖励], left: [环境奖励 r], right: [任务完成 + 过程验证]),
        (label: [价值函数], left: [V(s) / Q(s,a)], right: [GRPO 相对奖励]),
      ),
    )
  ],
  closing: boitefilled[预训练提供知识，后训练塑造行为 —— LLM 复用世界知识，RL 只学策略层],
)
