// chapters/ch09.typ - 第 9 章 持续进化
#import "../lib.typ": *

// ==== v2 章节约定（其他章节照此改写）====
// 1. 章首用一张 section-open 开场页，并在这里声明本章的强调色与面包屑：
//      #section-open(index: [9], title: [持续进化], subtitle: [...], color: framamarron)
//    - index 为书章节序号（内容分段省略 index）。
//    - color 会自动写入 accent-state，之后本页/本章的 keyline、stat、
//      boitefilled、页眉紧凑标题都自动沿用该色。
//    - 面包屑自动生成为「第 9 章 · 持续进化」，显示在内页右上角。
// 2. `==` 标题只写「主题」，不再重复「第 N 章 ·」前缀（前缀已进开场页与面包屑）。
// 3. 章节之间不再需要 #slide-accent(...) 交接色：下一章的 section-open 会自行声明。
// 4. 切记：section-open 必须紧跟在 `=` 之后、本章第一个 `==` 之前，且放在
//    `==` 标题之前不要写 #slide-accent(...)（会凭空多出一页）。

// ---------- 第 9 章 开场页（独立干净页，无页眉/页脚）----------
#section-open(
  index: [9],
  title: [持续进化],
  subtitle: [从运行轨迹获得学习信号，四层更新],
  color: framamarron,
)

// ---------- 第 1 页 · 强调色 framamarron ----------

== 四层更新

#body-slide(
  kicker: [知识 · 指令 · 程序 · 参数 —— 分层进化],
  inner: [
    - *更新知识*：事实与经验沉淀进记忆 / 知识库
    - *更新指令*：可语言化的策略写进 Prompt / Skill
    - *更新程序*：确定性流程与约束写进工具与 Harness
    - *更新参数*：难以显式表达的高维能力交给后训练（§8）
  ],
  closing: note[学习信号来自运行轨迹],
)

// ---------- 第 2 页 · 强调色 framamarron ----------

== 三个时间尺度

#body-slide(
  kicker: [临场适应 → 产物积累 → 参数内化，三层速率协同],
  inner: [
    #stretch-grid(
      columns: 3,
      gutter: 1em,
      stat(amount-size: 24pt, stretch: true)[短][对话内即时],
      stat(amount-size: 24pt, stretch: true)[中][会话间沉淀],
      stat(amount-size: 24pt, stretch: true)[长][重训练内化],
    )
    #v(gap-primary)
    - 短周期：上下文临场适应（每次调用）
    - 中周期：外部产物可控积累（会话间记忆与知识）
    - 长周期：参数内化（重训练 / 蒸馏）
  ],
  closing: boitefilled[持续进化，是 Agent 越用越好的原因],
)

// 下一章强调色由 ch10 的 section-open 自行声明，这里不再交接。