// chapters/tour-map.typ - 十章地图（全书内容路线总览）
// 强调色：framableu（默认，无需声明）；结尾交还 framableu 给 ch01。
#import "../lib.typ": *

// ---------- 开场页（独立干净页，无页眉/页脚）----------
#section-open(
  title: [十章速览],
  subtitle: [十个章节，一条从「会对话」到「能做事」的成长路径],
  color: framableu,
)

// ---------- 第 1 页 · 强调色 framableu（默认）----------

== 十章地图

#body-slide(
  kicker: [十个章节，一条从「会对话」到「能做事」的 Agent 成长路径],
  inner: [
    #stretch-grid(
      columns: 5,
      row-gutter: 0.5em,
      column-gutter: 0.6em,
      boitefilled(color: framableu, stretch: true)[1 · 入门],
      boitebleue(stretch: true)[2 · 上下文],
      boitebleue(stretch: true)[3 · 记忆],
      boiteverte(stretch: true)[4 · 工具],
      boiteverte(stretch: true)[5 · 工具链],
      boiteorange(stretch: true)[6 · 交互],
      boiteorange(stretch: true)[7 · 评估],
      boiteviolette(stretch: true)[8 · 后训练],
      boiteviolette(stretch: true)[9 · 进化],
      boitegrise(stretch: true)[10 · 协作],
    )
  ],
  closing: boitegrise[*全书主线* 公式 → 上下文 → 工具 → 评估 → 后训练 → 持续进化 → 多 Agent 协作],
)