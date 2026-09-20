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

== 从运行轨迹中学习

#body-slide(
  kicker: [保存经历不等于从经历中学习 —— 学习需要主动评价、对照、归纳、验证],
  inner: [
    - 模型上岗后，能否像新员工一样从日常工作中不断长进？
    - *持续学习*（Continual Learning）：从经验中自主学习
    #v(gap-primary)
    #term-rows(
      label-width: 6em,
      row-gap: 0.3em,
      rows: (
        (label: [保存经历], value: [日志记录（仅是数据）]),
        (label: [从经历中学习], value: [评价 → 对照 → 归纳 → 验证]),
        (label: [上下文学习], value: [当前任务内适应，不持久]),
        (label: [持续进化], value: [跨任务积累，改变后续行为]),
      ),
    )
    - 评价一条轨迹要依次回答三个问题：事情是否办成、是否以允许的方式办成、是否让用户舒服
  ],
  closing: note[从「会完成任务」走向「能够可靠工作」的关键能力],
)

// ---------- 第 2 页 · framaviolet ----------

== 四层更新

#body-slide(
  kicker: [知识 · 指令 · 程序 · 参数 —— 分层进化],
  inner: [
    #stretch-grid(
      columns: 2,
      row-gutter: gutter-tight,
      column-gutter: gutter-primary,
      boitebleue(stretch: true)[
        #align(center)[*更新知识*]
        #v(0.25em)  /* 卡内堆叠留白 */
        事实与经验沉淀进记忆 / 知识库
        #v(0.25em)  /* 灰色局限行前置留白 */
        #text(fill: framagrisdark)[局限：依赖检索与模型正确应用]
      ],
      boiteverte(stretch: true)[
        #align(center)[*更新指令*]
        #v(0.25em)  /* 卡内堆叠留白 */
        可语言化的策略写进 Prompt / Skill
        #v(0.25em)  /* 灰色局限行前置留白 */
        #text(fill: framagrisdark)[局限：易膨胀、冲突或被忽略]
      ],
      boiteorange(stretch: true)[
        #align(center)[*更新程序*]
        #v(0.25em)  /* 卡内堆叠留白 */
        确定性流程写进工具与 Harness
        #v(0.25em)  /* 灰色局限行前置留白 */
        #text(fill: framagrisdark)[局限：开发维护成本较高]
      ],
      boiteviolette(stretch: true)[
        #align(center)[*更新参数*]
        #v(0.25em)  /* 卡内堆叠留白 */
        难显式表达的高维能力交后训练（§8）
        #v(0.25em)  /* 灰色局限行前置留白 */
        #text(fill: framagrisdark)[局限：更新与回归成本高]
      ],
    )
  ],
  closing: note[学习信号来自运行轨迹 —— 验证器输出决定能否成为学习信号],
)

// ---------- 第 3 页 · framaviolet ----------

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
    - *短周期*：上下文临场适应（每次调用），KV Cache 管理
    - *中周期*：外部产物可控积累（会话间记忆与知识），跨任务沉淀
    - *长周期*：参数内化（重训练 / 蒸馏），需要数据 + 算力
  ],
  closing: boitefilled[持续进化，是 Agent 越用越好的原因],
)

// ---------- 第 4 页 · framaviolet ----------

== 进化循环与验证

#body-slide(
  kicker: [双循环结构：在线执行只记录，离线进化才更新],
  inner: [
    - *在线执行循环*：只完成任务并记录证据，不直接改写正式 Agent
    - *离线进化循环*：聚合轨迹、诊断根因、生成更新提案 → 验证门槛 → 发布
    #v(gap-primary)
    #term-rows(
      label-width: 5.6em,
      row-gap: 0.25em,
      rows: (
        (label: [回退检测], value: [新经验是否与已有经验冲突，原本通过的案例有无退化]),
        (label: [泛化能力], value: [新经验在未覆盖场景中是否有效]),
        (label: [Token 效率], value: [完成任务消耗的 Token 成本变化]),
        (label: [安全性], value: [规则、隐私和拒绝边界是否随进化漂移]),
        (label: [工程质量], value: [维护复杂度、架构一致性、向后兼容性]),
      ),
    )
  ],
  closing: note[实验 9-1 ~ 9-9：从轨迹验证器到 Hermes 自我更新],
)
