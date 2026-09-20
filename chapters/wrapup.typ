// chapters/wrapup.typ - 小结与展望（全书的收束与行动建议）
// 强调色走位：framableu（继承 engineering 的收尾重置）→ framavert。
#import "../lib.typ": *

#section-open(
  title: [小结],
  subtitle: [一条主线，与下一步行动],
  color: framableu,
)

// ---------- 第 1 页 · framableu ----------

== 一条主线

#body-slide(
  kicker: [大脑思考 · 眼睛观察 · 手脚行动],
  inner: [
    - 一个公式：$"Agent" = "LLM" + "上下文" + "工具"$
    - 一个循环：ReAct「想 → 做 → 看」；一层工程：Harness = 上下文管理 + 工具接口 + 约束 + 验证 + 纠正
    #v(gap-primary)
    #term-rows(
      label-width: 6.8em,
      rows: (
        (label: [LLM（大脑）], value: [§8 模型后训练：SFT / RL 内化策略], color: framaorange),
        (label: [上下文（眼睛）], value: [§2 上下文工程 + §3 记忆知识库], color: framableu),
        (label: [工具（手脚）], value: [§4 工具设计 + §5 Coding Agent], color: framavert),
        (label: [交互（感官）], value: [§6 模态 × 时机双维扩展], color: framavert),
        (label: [评估（镜子）], value: [§7 评估 = 可比较的信号], color: framaviolet),
        (label: [进化（成长）], value: [§9 四层更新 + 双循环], color: framaviolet),
        (label: [协作（团队）], value: [§10 多 Agent 组织与涌现], color: framaviolet),
      ),
    )
  ],
  closing: note[三个时间尺度：上下文适应 / 外部产物更新 / 参数更新 —— 协同进化],
)

// 收尾声明：被吸收，不翻页
#slide-accent(framavert)

// ---------- 第 2 页 · framavert ----------

== 展望与行动

#body-slide(
  kicker: [下一站：亲自把 Agent 跑起来],
  inner: [
    #stretch-grid(
      columns: 2,
      gutter: gutter-primary,
      boiteverte(stretch: true)[
        *前沿方向*
        - 模型即 Agent：RL 内化工具调用
        - Agent Skills · Computer Use · 语音 Agent
        - Graph / Loop 工程编排
        - 多 Agent 社会的涌现行为
      ],
      boiteorange(stretch: true)[
        *动手建议*
        - 从实验 1-1 消融开始，亲手验证上下文五要素的权重
        - 用公式对照每个产品：它扩展了哪个观察 / 动作空间？
        - 跑通一章实验 → 沉淀轨迹 → 形成自己的进化闭环
      ],
    )
  ],
  closing: [
    #align(center)[#text(size: 15pt, weight: "bold", fill: framableu)[深入理解 AI Agent —— 设计原理与工程实践]]
    #align(center)[#text(size: 10.5pt, fill: framagris)[全开源 · 10 章 · 109 实验 · 15 语言 · github.com/bojieli/ai-agent-book]]
  ],
  closing-gap: 0.7em, // 签名块刻意留白：书尾落款，与上文拉开呼吸
)

// 收尾：把强调色还给默认 framableu
#slide-accent(framableu)