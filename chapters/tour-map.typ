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

#keyline[十个章节，一条从「会对话」到「能做事」的 Agent 成长路径]

#v(0.3em)

#grid(
  columns: (1fr, 1fr, 1fr, 1fr, 1fr),
  rows: (33.8pt, 33.8pt),
  row-gutter: 0.5em,
  column-gutter: 0.6em,
  boitefilled(color: framableu, stretch: true)[1 · 入门],
  boitefilled(color: framavert, stretch: true)[2 · 上下文],
  boitefilled(color: framaviolet, stretch: true)[3 · 记忆],
  boitefilled(color: framaorange, stretch: true)[4 · 工具],
  boitefilled(color: framableu, stretch: true)[5 · Coding],
  boitefilled(color: framavert, stretch: true)[6 · 交互],
  boitefilled(color: framaviolet, stretch: true)[7 · 评估],
  boitefilled(color: framaorange, stretch: true)[8 · 后训练],
  boitefilled(color: framamarron, stretch: true)[9 · 进化],
  boitefilled(color: framaviolet, stretch: true)[10 · 协作],
)

#v(0.4em)

#boitegrise[*全书主线* 公式 → 上下文 → 工具 → 评估 → 后训练 → 持续进化 → 多 Agent 协作]