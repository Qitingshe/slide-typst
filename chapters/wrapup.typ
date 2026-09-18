// chapters/wrapup.typ - 小结与展望（全书的收束与行动建议）
// 每页强调色走位：framableu（继承 engineering 的收尾重置）→ framavert。
#import "../lib.typ": *

// ---------- 第 1 页 · 强调色 framableu（继承自工程要点的收尾重置）----------

== 小结 · 一条主线

#keyline[大脑思考 · 眼睛观察 · 手脚行动]

- 一个循环：ReAct「想 → 做 → 看」，上下文 = 静态前缀 + 轨迹
- 一层工程：Harness = 上下文管理 + 工具接口 + 约束 + 验证 + 纠正
- 三个时间尺度：上下文适应 / 外部产物更新 / 参数更新，协同进化
- 十个方向：眼睛（§2–3）、手脚（§4–5）、交互（§6）、评估（§7）、大脑（§8）、进化（§9）、群体（§10）

// 下一页强调色：本页末尾收尾声明（被吸收，不翻页）
#slide-accent(framavert)

// ---------- 第 2 页 · 强调色 framavert ----------

== 小结 · 展望与行动

#keyline[下一步：亲手把一个 Agent 跑起来]

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    #boiteverte[
      *前沿方向*
      - 模型即 Agent：RL 内化工具调用
      - Agent Skills · Computer Use · 语音 Agent
      - Graph / Loop 工程编排
      - 多 Agent 社会的涌现行为
    ],
  ],
  [
    #boiteorange[
      *动手建议*
      - 从实验 1-1 消融开始，亲手验证上下文五要素的权重
      - 用公式对照每个产品：它扩展了哪个观察 / 动作空间？
      - 跑通一章实验 → 沉淀轨迹 → 形成自己的进化闭环
    ],
  ],
)

#v(0.7em)

#align(center)[#text(size: 15pt, weight: "bold", fill: framableu)[深入理解 AI Agent —— 设计原理与工程实践]]
#align(center)[#text(size: 10.5pt, fill: framagris)[全开源 · 10 章 · 109 实验 · 15 语言 · github.com/bojieli/ai-agent-book]]

// 收尾：把强调色还给默认 framableu（最终重置）
#slide-accent(framableu)