// chapters/ch09.typ - 第 9 章 Agent 的持续进化
// 强调色：全章 framamarron（承接 §8 交接），结尾交接 framaviolet
#import "../lib.typ": *

// ---------- 第 1 页 · 强调色 framamarron（承接 §8，无需声明）----------

== 第 9 章 · 四层更新

#keyline[知识 · 指令 · 程序 · 参数 —— 分层进化]

#v(0.4em)

- *更新知识*：事实与经验沉淀进记忆 / 知识库
- *更新指令*：可语言化的策略写进 Prompt / Skill
- *更新程序*：确定性流程与约束写进工具与 Harness
- *更新参数*：难以显式表达的高维能力交给后训练（§8）

#v(0.5em)

#note[学习信号来自运行轨迹]

// ---------- 第 2 页 · 强调色 framamarron ----------

== 第 9 章 · 三个时间尺度

#keyline[临场适应 → 产物积累 → 参数内化，三层速率协同]

#v(0.4em)

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 1em,
  [#stat(amount-size: 24pt)[短][对话内即时]],
  [#stat(amount-size: 24pt)[中][会话间沉淀]],
  [#stat(amount-size: 24pt)[长][重训练内化]],
)

#v(0.3em)

- 短周期：上下文临场适应（每次调用）
- 中周期：外部产物可控积累（会话间记忆与知识）
- 长周期：参数内化（重训练 / 蒸馏）

#v(0.5em)

#boitefilled[持续进化，是 Agent 越用越好的原因]

// 下一页强调色：本页末尾收尾声明（交接 §10 framaviolet）
#slide-accent(framaviolet)