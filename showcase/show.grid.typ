// showcase/show.grid.typ
// 家族：区域编排 grid-slide —— v2.0 骨架升级。
//
// 演示 grid-slide 两种典型格局：
//   · 左右分栏首行 + 通栏底部（2×2 网格，colspan 跨步）
//   · 纯弹性撑满页（1×1 单行整页居中）
//
// 交叉引用：lib.typ 的 grid-slide 定义；体例与 body-slide 平级可选。
// 借页：沿用法注释复制到你的 deck。
#import "../lib.typ": *

// 用法: grid-slide(columns:, rows:, gutter:, ..cells) 替代 body-slide 线性流。
// 改这里: columns/rows 定义网格维度；cells 按行优先顺序填内容；跨步用 grid.cell(colspan:)。
// ⚠ 坑: grid-slide 与 body-slide 平级可混用；末行 1fr 自动撑满底部，不需要 center:true；
//       center:true 只在你需要整页垂直居中（如签名收尾页）时使用。
== 左右分栏 · grid-slide

#grid-slide(
  columns: (1fr, 1fr),
  rows: (auto, 1fr),
  gutter: gutter-primary,
  align: (left, top),
  // cell(1,1)：左上
  [
    #image("../assets/sample-scheme.svg", height: 3em)
    #v(0.2em)
    #text(size: 0.74em, fill: framagris)[
    系统架构概览 —— 弹性伸缩微服务拓扑。
    ]
  ],
  // cell(1,2)：右上
  [
    #keyline[核心特性]
    #list(
      [弹性伸缩],
      [自动容错],
      [声明式 API],
    )
  ],
  // cell(2,1-2)：下通栏，colspan: 2 跨整行
  grid.cell(colspan: 2)[
    #grid(columns: (1fr, 1fr, 1fr), gutter: gutter-tight,
      figure-block(image("../assets/sample-chart.svg"), caption: [吞吐量监控]),
      figure-block(image("../assets/sample-chart.svg"), caption: [错误率跟踪]),
      figure-block(image("../assets/sample-chart.svg"), caption: [延迟分布]),
    )
  ],
)

// 用法: grid-slide(columns:, rows:, gutter:, center: true, ..cells) 整页居中方案
// 改这里: 用 center: true 让整块在正文区上下等距居中；columns/rows 取短轴路径。
// ⚠ 坑: 居中模式优于手工 v(1fr)/v(1fr) 布局；同 body-slide center 的双 fr 论证。
== 居中整页 · grid-slide center

#grid-slide(
  columns: (1fr,),
  rows: (auto, auto),
  gutter: gutter-primary,
  align: (center, center),
  center: true,
  [
    #text(size: 22pt, weight: "bold", fill: framableu)[感谢聆听]
  ],
  [
    #text(size: 0.8em, fill: framagris)[问题与交流]\
    #text(size: 0.74em, fill: framagris)[作者 · institution (at) example (dot) com]
  ],
)
