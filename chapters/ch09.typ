// chapters/ch09.typ - 第 9 章 持续进化
// 强调色：framaviolet（紫），Agent 越用越好靠持续进化
#import "../lib.typ": *

#section-open(
  index: [9],
  title: [持续进化],
  subtitle: [从运行轨迹获得学习信号，四层更新],
  color: framaviolet,
)

// ---------- 第 1 页 · framaviolet ----------

== 四层更新

#body-slide(
  kicker: [知识 · 指令 · 程序 · 参数 —— 分层进化],
  inner: [
    #stretch-grid(
      columns: 2,
      row-gutter: gutter-tight,
      column-gutter: gutter-primary,
      boitebleue(stretch: true)[*更新知识* 事实与经验沉淀进记忆 / 知识库],
      boiteverte(stretch: true)[*更新指令* 可语言化的策略写进 Prompt / Skill],
      boiteorange(stretch: true)[*更新程序* 确定性流程与约束写进工具与 Harness],
      boiteviolette(stretch: true)[*更新参数* 难以显式表达的高维能力交给后训练（§8）],
    )
  ],
  closing: note[学习信号来自运行轨迹],
)

// ---------- 第 2 页 · framaviolet ----------

== 三个时间尺度

#body-slide(
  kicker: [临场适应 → 产物积累 → 参数内化，三层速率协同],
  inner: [
    #stretch-grid(
      columns: 3,
      gutter: gutter-primary,
      stat(amount-size: 30pt, stretch: true)[短][对话内即时适应],
      stat(amount-size: 30pt, stretch: true)[中][会话间沉淀产物],
      stat(amount-size: 30pt, stretch: true)[长][重训练内化参数],
    )
    #v(gap-primary)
    - 短周期：上下文临场适应（每次调用）
    - 中周期：外部产物可控积累（会话间记忆与知识）
    - 长周期：参数内化（重训练 / 蒸馏）
  ],
  closing: boitefilled[持续进化，是 Agent 越用越好的原因],
)