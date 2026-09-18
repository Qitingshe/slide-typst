// chapters/ch01.typ - 第 1 章 AI Agent 入门
//
// ==== v2 章节约定（其他章节照此改写）====
// 1. 章首用一张 section-open 开场页，并在这里声明本章的强调色与面包屑：
//      #section-open(index: [1], title: [AI Agent 入门], subtitle: [...], color: framableu)
//    - index 为书章节序号（内容分段省略 index）。
//    - color 会自动写入 accent-state，之后本页/本章的 keyline、stat、
//      boitefilled、页眉紧凑标题都自动沿用该色。
//    - 面包屑自动生成为「第 1 章 · AI Agent 入门」，显示在内页右上角。
// 2. `==` 标题只写「主题」，不再重复「第 1 章 ·」前缀（前缀已进开场页与面包屑）。
// 3. 章节之间不再需要 #slide-accent(...) 交接色：下一章的 section-open 会自行声明。
// 4. 切记：section-open 必须紧跟在 `=` 之后、本章第一个 `==` 之前，且放在
//    `==` 标题之前不要写 #slide-accent(...)（会凭空多出一页）。
#import "../lib.typ": *

// ---------- 第 1 章 开场页（独立干净页，无页眉/页脚）----------
#section-open(
  index: [1],
  title: [AI Agent 入门],
  subtitle: [Agent = LLM + 上下文 + 工具，Harness 是竞争力],
  color: framableu,
)

// ---------- 第 1 页 · 强调色 framableu ----------

== 产品实证

#body-slide(
  kicker: [五个代表产品，共享同一副 Agent 骨架],
  inner: [
    #stretch-grid(
      columns: 3,
      row-gutter: 0.6em,
      column-gutter: 0.8em,
      boitebleue(stretch: true)[*Cursor* 编程助手：开放式工作流与代码操作],
      boiteverte(stretch: true)[*Deep Research* 长程研究：检索、综合、成文],
      boiteorange(stretch: true)[*Manus* 全能执行：拆解任务、调用工具],
      boiteviolette(stretch: true)[*豆包* 大规模智能客服],
      boitemarron(stretch: true)[*游戏 NPC* 嵌入式交互角色],
      boitejaune(stretch: true)[*Pine AI* Agent 协作：共同完成任务],
    )
  ],
  closing: note[共同特征：开放式动作空间 · 内部思考 · 持续交互],
)

// ---------- 第 2 页 · 强调色 framableu ----------

== 观察与动作空间

#body-slide(
  kicker: [模型与世界之间，隔着观察与动作两个接口],
  inner: [
    - 观察空间 = 模型每个决策点能看到的信息；动作空间 = 允许执行的操作集合
    - 很多「模型不够聪明」的问题，其实是接口设计问题
    - Model–Harness 结构：Model 做决策；Harness 构造上下文、暴露工具并实施治理
  ],
  closing: boitefilled[*结论* Agent 的能力 = 模型能力 × 接口设计],
)

// ---------- 第 3 页 · 强调色 framableu ----------

== 构建原则与全书路线

#body-slide(
  kicker: [保持简单 · 保持透明 · 防呆式 ACI],
  inner: [
    - 防呆式 ACI：用设计消除错误，而非事后补救
    - 模型即 Agent：RL 把工具调用内化为原生能力（§8 展开）
    - 最小闭环先行：先跑通一个任务，再扩展观察与动作空间
  ],
  closing: note[全书路线：上下文（§2–3）→ 工具（§4–5）→ 交互（§6）→ 评估（§7）→ 后训练（§8）→ 进化（§9）→ 协作（§10）],
)

// 下一章强调色由 ch02 的 section-open 自行声明，这里不再交接。