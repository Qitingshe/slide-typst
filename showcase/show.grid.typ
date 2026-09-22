// showcase/show.grid.typ
// 家族：区域编排 grid-slide —— v2.0 骨架升级。
//
// 演示 grid-slide 三种典型格局：
//   · 左右分栏首行 + 通栏底部（2×2 网格，colspan 跨步）
//   · 复合网格仪表盘（rowspan 跨行 + 不等宽列 + 末行 1fr 底部锚定）
//   · 纯弹性撑满页（1×1 单行整页居中，也可作结尾页）
//
// 交叉引用：lib.typ 的 grid-slide 定义；体例与 body-slide 平级可选。
// 借页：沿用法注释复制到你的 deck。
#import "../lib.typ": *

// 用法: grid-slide(columns:, rows:, gutter:, ..cells) 替代 body-slide 线性流。
// 改这里: columns/rows 定义网格维度；cells 按行优先顺序填内容；跨步用 grid.cell(colspan:)。
// ⚠ 坑: grid-slide 与 body-slide 平级可混用；网格撑满正文区（block height 100%），
//       fr 行按正文区高度真实分配——末行 1fr 真正锚定底部，auto 行取内容自然高。
//       本页 rows (auto, 1fr)：顶行贴内容（keyline 与左图顶对齐），剩余页高全落
//       1fr 行，多余空白沉底给页脚留净空；比例行 (3fr, 2fr) 经 lib 修复后行高被
//       页高真实撑满，horizon 对齐会让文字/图带在大行内悬浮过低——本页不再用。
//       格级对齐参数名是 cell-align——写成 align: 会被 ..cells 尾参静默吞掉
//       （不报错、不生效，照默认 (center, top) 渲染，本页曾踩此坑）；单格覆盖用
//       grid.cell(align: top)（+ 组合双轴如 left + bottom；数组仅 grid 级 align 专用）。
//       center:true 时网格改为内容自然高度 + 双 v(1fr) 页内居中，fr 行失效——
//       「锚底布局」与「居中布局」二选一，不要同时开。
//       figure-block 图宽随列宽放大（set image(width:100%)），横图高宽比约 1.5:1；
//       内容超高溢出静默（Typst 不报错），须逐页目视。
== 左右分栏 · grid-slide

#grid-slide(
  columns: (1fr, 1fr),
  rows: (auto, 1fr),
  gutter: gutter-primary,
  // cell(1,1)：左上 —— 主视觉图走 figure-block（图注同宽同左缘，与底行图注同一规格）。
  // 图宽 65%：auto 顶行随图高收缩，行高即内容高——图大行高、图小行矮，不悬浮
  [
    #figure-block(
      image("../assets/sample-scheme.svg"),
      caption: [系统架构概览 —— 弹性伸缩微服务拓扑],
      width: 65%,
    )
  ],
  // cell(1,2)：右上 —— keyline + 几何 marker 列表；align: top 与左图顶对齐
  grid.cell(align: top)[
    #keyline[核心特性]
    #v(gap-secondary)
    #list(
      marker: text(fill: framagrisdark, size: 0.6em)[■],
      spacing: 0.55em,
      [弹性伸缩],
      [自动容错],
      [声明式 API],
    )
  ],
  // cell(2,1-2)：底部通栏图带——align: top 上抬贴顶行下沿，剩余空白沉底（页脚净空）；
  // 图宽 80% 收窄防溢出（超高溢出静默不报错）
  grid.cell(colspan: 2, align: top)[
    #grid(columns: (1fr, 1fr, 1fr), gutter: gutter-tight,
      figure-block(image("../assets/sample-chart.svg"), caption: [吞吐量监控], width: 80%),
      figure-block(image("../assets/sample-chart.svg"), caption: [错误率跟踪], width: 80%),
      figure-block(image("../assets/sample-chart.svg"), caption: [延迟分布], width: 80%),
    )
  ],
)

// 用法: grid-slide 复合网格——rowspan 跨行 + 不等宽列 + 末行 1fr 底部锚定
// 改这里: 调整 columns / rows 定义布局骨架；替换各面板内文案或元件。
// ⚠ 坑: rowspan 单元格占用后续行的同一列位置，后续格子按行优先顺序填入剩余位置；
//       底栏贴底需单格覆盖 grid.cell(align: left + bottom)——cell-align 默认 (left, top)，
//       不覆盖则底栏悬在 1fr 行顶部（+ 组合双轴；数组写法会报错）；
//       末行 1fr 自动撑到底部，无需 center: true（锚底与居中二选一，同开冲突）；
//       grid-slide 的行列 gutter 使用同一个值（column-gutter == row-gutter），
//       如需不同 gutter，可降级使用原生 #grid(column-gutter:, row-gutter:) + body-slide；
//       内容格子数 ≤ 列数×行数（含 rowspan 占位后的剩余格子），否则 assert 报错。
//       本页总格子 = 2 列 × 3 行 = 6 格容量，实际填入 4 格（因 rowspan:2 占位），剩余 2 格留空。
== 复合网格 · 仪表盘

#grid-slide(
  columns: (220pt, 1fr),
  rows: (auto, auto, 1fr),
  gutter: gutter-primary,
  cell-align: (left, top),
  // cell(1-2,1)：左侧主面板，跨 2 行（rowspan: 2）
  grid.cell(
    rowspan: 2,
  )[
    #block(
      fill: framableu.lighten(93%),
      inset: 12pt,
      radius: 4pt,
    )[
      #keyline(color: framableu, size: 18pt)[概览仪表盘]
      #v(0.3em)
      #table(
        columns: (1fr, 1fr),
        stroke: 0pt,
        align: (left, right),
        [响应时间], text(fill: framableu, weight: "bold")[42ms],
        [吞吐量],   text(fill: framableu, weight: "bold")[1.2k req/s],
        [错误率],   text(fill: framableu, weight: "bold")[0.03%],
        [可用性],   text(fill: framableu, weight: "bold")[99.97%],
      )
    ]
  ],
  // cell(1,2)：右上附属面板
  [
    #block(
      fill: framavert.lighten(93%),
      inset: 12pt,
      radius: 4pt,
    )[
      #text(size: 11pt, weight: "bold", fill: framavert)[最近警报]
      #v(0.1em)
      #text(size: 9pt)[
        · 22:14 CPU 超限 → 已自动扩缩容\
        · 21:53 内存预警 → 已恢复\
      ]
    ]
  ],
  // cell(2,2)：右下附属面板
  [
    #block(
      fill: framaorange.lighten(93%),
      inset: 12pt,
      radius: 4pt,
    )[
      #text(size: 11pt, weight: "bold", fill: framaorange)[资源水位]
      #v(0.2em)
      #grid(columns: (1fr, 1fr), gutter: 0.4em,
        stat(amount-size: 18pt)[72%][CPU],
        stat(amount-size: 18pt)[3.2][内存 / GB],
      )
    ]
  ],
  // cell(3,1-2)：底通栏，colspan: 2 跨整行 + 1fr 行锚底；
  // align 覆盖 left + bottom 让色条贴 1fr 行底（即正文区底缘）——
  // grid.cell 的 align 只收单一 alignment（+ 组合双轴），不收数组
  grid.cell(colspan: 2, align: left + bottom)[
    #block(
      fill: framableu,
      inset: (x: 14pt, y: 10pt),
      radius: 4pt,
    )[
      #text(fill: white, size: 0.78em)[
        状态: 运行正常
        #h(1fr)
        最后更新: 2026-09-21 22:30 UTC
      ]
    ]
  ],
)

// 用法: grid-slide(columns:, rows:, gutter:, center: true, ..cells) 结尾页 / Q&A 页
// 改这里: 替换感谢语、联系方式、资源链接为你的内容；也可换成 body-slide(center: true) 实现同等效果
//         （body-slide 更简单，适合纯文本结尾页；grid-slide 适合需要网格布局的复杂结尾页）。
// ⚠ 坑: 居中模式优于手工 v(1fr)/v(1fr) 布局；同 body-slide center 的双 fr 论证。
//       结尾页放在 deck 最后，前面加 #v(closing-gap)（如适用）或直接跟在末页正文后。
//       曾误写 align: (center, center) 死参数（被 ..cells 静默吞掉，不生效）——
//       格级对齐参数名是 cell-align；默认 (center, top) 已满足本页，无需覆盖。
//       本页不设 closing，故最后一个 section 后面不需要 closing-gap——结尾页本身就是收束。
//       如要更简单的无网格结尾，用 body-slide(inner: [...], center: true) 替代。
== 感谢聆听 · 结尾页

#grid-slide(
  columns: (1fr,),
  gutter: gutter-primary,
  center: true,
  [
    #text(size: 22pt, weight: "bold", fill: framableu)[感谢聆听]
  ],
  [
    #text(size: 0.8em, fill: framagris)[Q&A · 问题与交流]\
    #text(size: 0.72em, fill: framagris)[hello (at) example (dot) com]\
    #text(size: 0.72em, fill: framagris)[github.com/your-org/deck-repo]\
  ],
)
