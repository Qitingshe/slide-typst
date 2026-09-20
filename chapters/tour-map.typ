// chapters/tour-map.typ - 十章地图（全书内容路线总览）
// 强调色：framableu（默认，无需声明）；结尾交还 framableu 给 ch01。
// 章节色以各章 section-open 实际声明为权威：
//   1 蓝 / 2 蓝 / 3 紫 / 4 绿 / 5 蓝 / 6 绿 / 7 紫 / 8 橙 / 9 紫 / 10 紫
#import "../lib.typ": *

#section-open(
  title: [十章速览],
  subtitle: [十个章节，一条从「会对话」到「能做事」的成长路径],
  color: framableu,
)

// ---------- 第 1 页 · framableu ----------

== 十章地图

#body-slide(
  kicker: [十个章节，一条从「会对话」到「能做事」的 Agent 成长路径],
  inner: [
    #stretch-grid(
      columns: 5,
      row-gutter: gutter-tight,
      column-gutter: gutter-tight,
      boitefilled(color: framableu, stretch: true)[1 · 入门],
      boitebleue(stretch: true)[2 · 上下文],
      boiteviolette(stretch: true)[3 · 记忆],
      boiteverte(stretch: true)[4 · 工具],
      boitebleue(stretch: true)[5 · Coding 编码],
      boiteverte(stretch: true)[6 · 交互],
      boiteviolette(stretch: true)[7 · 评估],
      boiteorange(stretch: true)[8 · 后训练],
      boiteviolette(stretch: true)[9 · 进化],
      boiteviolette(stretch: true)[10 · 协作],
    )
  ],
  closing: boitegrise[*全书主线* 公式 → 上下文 → 工具 → 评估 → 后训练 → 持续进化 → 多 Agent 协作],
)