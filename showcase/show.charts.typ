// showcase/show.charts.typ
// 家族：数据图表 —— cetz-plot 0.1.4 的画布级图表（chart / plot 两个命名空间）。
//
// 演示四件事：
//   · chart.piechart(...)：饼图，切片即占比 + 画布内图例（page 1）。
//   · chart.barchart(...)：分组柱状（横向条），行 = 类别、列 = 系列（page 2）。
//   · plot.plot(...) + plot.add(...)：线性图，曲线 / 标记 / 坐标轴全可定制（page 3）。
//   · 变体速查：环形 / 堆积条形 / 区域填充三个参数变体一页看完（page 4）。
//
// 交叉引用：画布走 cetz-canvas（坐标即厘米）；图注手写 figure-block 同规格
// （0.63em framagris 居中，image 宽度接管对画布无效）；numbly 由 lib 导入。
// 版面纪律：整页一张画布 + 一手短注（长注进 closing）——grid 行高 = 左右最高列。
// 图例字级独立降档：leg-label 由 lib.typ 导出（0.7em×0.7em≈11.9pt），刻度/轴标原档不动。
// ⚠ chart / plot 由 lib.typ 顶层导出直接可用；不要再 #import cetz / cetz-plot。
#import "../lib.typ": *

// 用法: #chart.piechart(data, value-key: 1, label-key: 0, radius: N, slice-style: 色板数组,
//       outset: 下标, outer-label: (content: fn, radius: 比例), legend: (position, ..))
// 改这里: 数据行 = ([图例名], 数值)；value-key/label-key 取二元组里的下标；slice-style 与
//         data 等长、按 lib 调色板梯度排；outer-label.content 函数签名 (value, label)
//         ——本页用 numbly("{1}%") 模板输出整数占比（百分比须先 calc.round）。
// ⚠ 坑: ① label-key: none 时图例整个消失（官方画廊就这样：纯数字无图例），要图例就传
//       标签所在下标；② slice-style 短于 data 会取模循环复用首色，务必等长；③ outset
//       传整数下标弹出对应切片；④ 图例 fill 传 white/实色会画一块不透明底盖住同排
//       相邻内容（grid 右侧列会被整个抹白）——本页用 fill: none + 细描边透明底。
== 图表 · 饼图

#let pie-data = (
  (leg-label[研发], 30),
  (leg-label[市场], 25),
  (leg-label[运营], 20),
  (leg-label[销售], 12),
  (leg-label[行政], 8),
  (leg-label[人力], 5),
)
#let pie-total = pie-data.map(t => t.at(1)).sum()
#let pie-top-pct = calc.round(pie-data.at(0).at(1) / pie-total * 100)

#body-slide(
  kicker: [chart.piechart —— 切片即占比，图例随画布缩放],
  inner: [
    #grid(
      columns: (1.25fr, 1fr),
      gutter: 1em,
      [
        #align(center)[
          // 图表区字级 0.7em：cetz 文本继承上下文字号（原 21.2pt 正文级，用户目检
          // 反馈太大）；对齐 deck 助文/图注档 ≈14.8pt。set 须放画布体外（体内会被
          // cetz 当元素解析报错）；用 #align 收口作用域且零块间距，不翻页。
          // 画布与底部图注共居中：同一竖直中线（最初 align(left) 画布偏左、与图注错位）。
          #set text(size: 0.7em)
          #cetz-canvas({
          chart.piechart(
            pie-data,
            value-key: 1,
            label-key: 0,
            radius: 2.9,
            stroke: none,
            slice-style: (framableu, framavert, framarouge, framaviolet, framaorange, framajaune),
            outset: 0,
            outer-label: (
              content: (value, label) => numbly("{1}%")(calc.round(value / pie-total * 100)),
              radius: 110%,
            ),
            legend: (
              position: "east",
              orientation: ttb,
              // offset 是唯一留缝手段（饼图不走 add-legend-anchors，顶层 spacing
              // 不生效）。坑：图例锚在 chart.east——chart 组 bbox 的东缘并不包住
              // 环的最凸点（实测 chart.east 在环凸点内侧约 0.65cm），且画布右扩后
              // #align(center) 居中会吃掉一半位移（offset +1cm 目视只多 ~0.5cm）。
              // 0.4 实测图例左缘仍压在环凸点里，取 1.8 才留出干净缝隙。
              offset: (1.8, 0),
              fill: none,
              stroke: (paint: framagris.lighten(65%), thickness: 0.4pt),
              item: (spacing: 0.2, preview: (width: 0.32, height: 0.32)),
            ),
          )
        })] // #align 收口：0.7em 只作用于画布
        #v(0.06em)
        #align(center)[#text(size: 0.63em, fill: framagris)[图 1:项目预算分布（N=100）——numbly 模板]]
      ],
      [
        - 数据行 = ([标签], 数值)：喂给 `value-key` / `label-key`。
        - `slice-style` 传等长色板；`outset` 弹出重点切片。
        - `outer-label.content` 传函数 + `numbly` 模板。
        #v(gap-primary)
        #stat(color: framarouge)[#numbly("{1}%")(pie-top-pct)][单切片峰值 · numbly]
      ],
    )
  ],
  closing: note[图例画在 cetz 画布内、随 canvas 整体缩放；更多样例见
  #link("https://github.com/cetz-package/cetz-plot")[cetz-plot 官方画廊]。],
)

// 用法: #chart.barchart(mode: "clustered", size: (9, auto), label-key: 0, value-key: (..range(1, N)),
//       x-tick-step, x-min/x-max, x-format, bar-style, labels, legend) —— 横向分组柱状图
// 改这里: 每行 = ([行标签], 系列值…)，value-key 用 range(1, N) 取第 1..N 列；labels 传系列
//         名（进图例）；bar-style 是 i => (fill: …) 函数，按系列下标取色、与 labels 一一对应；
//         legend / x-tick-step / x-min / x-max 之类轴参数全走 barchart 的 ..plot-args 透传。
// ⚠ 坑: ① barchart 是「横向条」：行类别在 y 轴、数值沿 x 轴长条——要纵向柱状走
//        columnchart；② x-min/x-max 建议显式给出：bar-position center × bar-width −0.8
//        会让数值域从 0.4 起、刻度漂移；③ plot 系（barchart/plot）的
//        legend 只收锚点字符串（"north-east" / "inner-north-east" 等预设），样式走
//        set-style(legend: …)——把饼图那种 (position: …, fill: …) 字典传进来会直接
//        panic；④ x-format 默认 float 保留两位小数（0.00/2.50 很丑），用
//        plot.formats.decimal.with(digits: 0) 显式取整才干净；⑤ 图例 fill 一律 none：
//        实色盖住绘图区；⑥ 外部锚点（无 inner- 前缀）把图例排在绘图区外，配套
//        spacing: 0.4 在两者间留缝——比 inner-* 内嵌预设更稳，抄页优先外部锚点。
== 图表 · 柱状图

#let bar-data = (
  ([华东], 1.2, 2.0, 3.5, 4.0),
  ([华南], 1.0, 1.5, 3.0, 3.5),
  ([华北], 0.8, 1.0, 2.0, 2.5),
  ([西部], 0.5, 0.8, 1.5, 2.0),
)

#body-slide(
  kicker: [chart.barchart —— 行类别 × 列系列的分组柱状],
  inner: [
    #grid(
      columns: (1.25fr, 1fr),
      gutter: 1em,
      [
        #align(center)[
          // 图表区字级 0.7em（同饼图页）：cetz 文本继承上下文 → ≈14.8pt 助文档。
          // 画布与底部图注共居中：同一竖直中线（画布总宽 = 绘图区 + 外部图例，
          // 两侧都被 #align 收进同一块，图注对齐整块画布而非裸绘图区）。
          #set text(size: 0.7em)
          #cetz-canvas({
          import cetz.draw: *

          set-style(legend: (fill: none, stroke: (paint: framagris.lighten(65%), thickness: 0.4pt), spacing: 0.4))

          let bar-colors = (framableu, framarouge, framavert, framaorange)
          chart.barchart(
            mode: "clustered",
            size: (9, auto),
            label-key: 0,
            value-key: (..range(1, 5)),
            x-tick-step: 1,
            x-min: 0,
            x-max: 5,
            x-format: plot.formats.decimal.with(digits: 0),
            bar-style: i => (fill: bar-colors.at(i), stroke: none),
            bar-data,
            labels: (leg-label[Q1], leg-label[Q2], leg-label[Q3], leg-label[Q4]),
            // 外部锚点 north-east：图例排在绘图区右上角外侧（spacing 0.4 留缝），
            // 不再压住绘图区内容（旧 inner-north-east 是绘图区内部预设）。
            legend: "north-east",
          )
        })] // #align 收口：0.7em 只作用于画布
          #v(0.12em)
          #align(center)[#text(size: 0.63em, fill: framagris)[图 2:区域季度营收对比（万,clustered）]]
      ],
      [
        - 行 = 类别（`label-key`），列 = 系列（`value-key` 取 1..4 列）。
        - `labels` 传系列名；`bar-style` 是 `i => (fill: 色, …)`，与 labels 对应。
        - `x-tick-step` / `x-min` / `x-max` / `x-format` 经 `..plot-args` 透传。
        #v(gap-primary)
        #stat(color: framaorange)[#numbly("{1} 万")(4)][单区域峰值 · numbly]
      ],
    )
  ],
  closing: note[值域 0..5 万、刻度每 1 万一格；横向条按行读——华东 Q4 营收领跑。],
)

// 用法: #plot.plot(size, x-tick-step, x-min/max, x-format, y-tick-step, y-min/max, y-format,
//       x-grid/y-grid, legend, { #plot.add(数据, label, style, mark, mark-size, mark-style) … })
// 改这里: plot.plot 管画布与坐标轴（axis 类参数直接挂具名参数）；每条曲线一个 plot.add：
//         label 进图例、style 定线色/粗细/虚实、mark 用预置符号（"o" / "square" / "triangle"）。
//         数据 = ((x, y), …) 元组序列；本页 3 条曲线共享 0..6 月份。
// ⚠ 坑: ① mark-style 必须与 style 同色声明——散点走独立样式链，不继承线色，漏写会
//        回落默认蓝红绿序列与线色失配；② legend 的外部锚点（"north-east" 等无
//        inner- 前缀）把图例排在绘图区外，本页用 spacing: 0.4 留缝隙——旧 inner-*
//        预设盖在绘图区内，抄页优先外部锚点；③ x/y-format 默认 float 保留两位小数，
//        用 plot.formats.decimal.with(digits: …) 显式取整；④ 图例锚点传字符串预设
//        （"north-east"），不能用画布坐标；⑤ 图例 fill 同饼图坑：用 none。
== 图表 · 线性图

#let traffic-home = ((0, 1.2), (1, 1.5), (2, 1.8), (3, 2.1), (4, 2.4), (5, 2.7), (6, 3.0))
#let traffic-growth = calc.round((3.0 / 1.2 - 1) * 100)

#body-slide(
  kicker: [plot.plot + plot.add —— 曲线、标记、图例皆可定制],
  inner: [
    #grid(
      columns: (1.25fr, 1fr),
      gutter: 1em,
      [
        #align(center)[
          // 图表区字级 0.7em（同饼图页）：cetz 文本继承上下文 → ≈14.8pt 助文档。
          // 画布与底部图注共居中：同一竖直中线（画布总宽 = 绘图区 + 外部图例，
          // 两侧都被 #align 收进同一块，图注对齐整块画布而非裸绘图区）。
          #set text(size: 0.7em)
          #cetz-canvas({
          import cetz.draw: *

          set-style(
            axes: (
              stroke: (paint: framagris, thickness: 0.4pt),
              tick: (stroke: (paint: framagris, thickness: 0.4pt)),
              grid: (stroke: (paint: framagris.lighten(50%), thickness: 0.25pt, dash: "dotted")),
            ),
            legend: (fill: none, stroke: (paint: framagris.lighten(65%), thickness: 0.4pt), spacing: 0.4),
          )
          plot.plot(
            size: (9, 4.2),
            x-tick-step: 1, x-min: 0, x-max: 6,
            x-format: plot.formats.decimal.with(digits: 0),
            y-tick-step: 0.5, y-min: 0, y-max: 3.5,
            y-format: plot.formats.decimal.with(digits: 1),
            x-grid: true, y-grid: true,
            // 外部锚点 north-east：图例排在绘图区右上角外侧（spacing 0.4 留缝），
            // 不再压住绘图区内容（旧 inner-north-east 是绘图区内部预设）。
            legend: "north-east",
            {
              plot.add(traffic-home,
                label: leg-label[首页], mark: "o", mark-size: 0.17,
                style: (stroke: (paint: framableu, thickness: 1.4pt), fill: none),
                mark-style: (fill: framableu, stroke: none))
              plot.add(((0, 0.8), (1, 1.0), (2, 1.1), (3, 1.3), (4, 1.5), (5, 1.7), (6, 1.9)),
                label: leg-label[博客], mark: "square", mark-size: 0.16,
                style: (stroke: (paint: framarouge, thickness: 1.4pt), fill: none),
                mark-style: (fill: framarouge, stroke: none))
              plot.add(((0, 0.5), (1, 0.7), (2, 1.0), (3, 1.2), (4, 1.4), (5, 1.6), (6, 1.8)),
                label: leg-label[产品], mark: "triangle", mark-size: 0.17,
                style: (stroke: (paint: framaviolet, thickness: 1.4pt, dash: "dashed"), fill: none),
                mark-style: (fill: framaviolet, stroke: none))
            },
          )
        })] // #align 收口：0.7em 只作用于画布
        #v(0.12em)
        #align(center)[#text(size: 0.63em, fill: framagris)[图 3:月度访问量趋势（万,raw 折线 + 预置标记）]]
      ],
      [
        - 每条线独立 #plot.add：label / style / mark 按线声明。
        - 轴参数直接挂 #plot.plot：`x-tick-step` / `y-format` 等。
        - 图例锚点 `"north-east"` + `spacing: 0.4`，绘图区右外侧排图例。
        #v(gap-primary)
        #stat(color: framableu)[#numbly("{1}%")(traffic-growth)][半年增幅 · numbly]
      ],
    )
  ],
  closing: note[mark-style 与线色同步声明是散点不失配的关键——漏写会回落默认蓝红绿序列；
  更多能力见 #link("https://github.com/cetz-package/cetz-plot")[官方画廊]。],
)

// 用法: 三个参数变体：piechart(radius + inner-radius + outset) 环形弹出 /
//       barchart(mode: "stacked") 堆积条 / plot.add(fill: true, fill-type: "axis") 区域填充
// 改这里: 每个小画布一个 cetz-canvas，参数即「变体」本身：内环改 inner-radius、
//         弹出切片刻 outset、堆积改 mode、填色改 fill/fill-type——抄页时对比主章三页即可。
// ⚠ 坑: ① 环形图的 inner-label 若开启会往环心写字——本页关闭（label-key: none 连带
//       图例消失），要图例就把 label-key 改回下标；② stacked 模式数值域 = 各列之和，
//       本页给 x-max 显式上限，否则柱顶贴边；③ fill: true 会沿 y 轴基线铺一条
//       不透明色带，第一眼只信曲线不置信封——颜色仍用 frama 主色半透即可；
//       ④ 三列底部图注须对齐：图表/画布分两行 grid（chart row + caption row），
//       避免画布高度不等导致图注参差。
== 图表 · 变体速查

#body-slide(
  kicker: [一个家族三个变体 —— 环形 / 堆积 / 区域],
  inner: [
    // 两行 grid：第一行放三个画布，第二行放三个图注。图注独占一行保证水平对齐，
    // 不受画布高度差异（环形 radius vs 柱状/折线 size）影响。
    #grid(
      columns: (1fr, 1fr, 1fr),
      gutter: 0.8em,
      row-gutter: 0.15em,
      // ── Row 1: 画布 ──
      [
        #align(center)[
          // 图表区字级 0.7em（同饼图页）：cetz 文本继承上下文 → ≈14.8pt 助文档。
          #set text(size: 0.7em)
          #cetz-canvas({
          import cetz.draw: *

          chart.piechart(
            (([办公], 55), ([差旅], 30), ([培训], 15)),
            value-key: 1,
            label-key: none,
            radius: 1.6,
            inner-radius: 0.8,
            outset: 0,
            stroke: none,
            slice-style: (framableu, framavert, framarouge),
            outer-label: (
              content: (value, label) => numbly("{1}%")(value),
              radius: 115%,
            ),
          )
        })] // #align 收口：0.7em 只作用于画布
      ],
      [
        #align(center)[
          // 图表区字级 0.7em（同饼图页）：cetz 文本继承上下文 → ≈14.8pt 助文档。
          #set text(size: 0.7em)
          #cetz-canvas({
          import cetz.draw: *

          chart.barchart(
            mode: "stacked",
            size: (7, 3),
            label-key: 0,
            value-key: (..range(1, 4)),
            x-min: 0,
            x-max: 20,
            x-tick-step: 5,
            x-format: plot.formats.decimal.with(digits: 0),
            bar-style: i => (fill: (framableu, framarouge, framavert).at(i), stroke: none),
            (([Q1], 8, 5, 3), ([Q2], 10, 4, 2), ([Q3], 7, 6, 4)),
            legend: none,
          )
        })] // #align 收口：0.7em 只作用于画布
      ],
      [
        #align(center)[
          // 图表区字级 0.7em（同饼图页）：cetz 文本继承上下文 → ≈14.8pt 助文档。
          #set text(size: 0.7em)
          #cetz-canvas({
          import cetz.draw: *

          set-style(axes: (grid: (stroke: (paint: framagris.lighten(55%), thickness: 0.25pt, dash: "dotted"))))
          plot.plot(
            size: (7, 3),
            x-tick-step: 1, x-min: 0, x-max: 6,
            x-format: plot.formats.decimal.with(digits: 0),
            y-tick-step: 1, y-min: 0, y-max: 4,
            y-format: plot.formats.decimal.with(digits: 0),
            {
              plot.add(((0, 1.0), (1, 1.8), (2, 2.5), (3, 3.0), (4, 3.3), (5, 3.5), (6, 3.7)),
                fill: true, fill-type: "axis",
                style: (stroke: (paint: framableu, thickness: 1.2pt), fill: framableu.lighten(55%)))
              plot.add(((0, 0.8), (1, 1.3), (2, 1.8), (3, 2.1), (4, 2.3), (5, 2.5), (6, 2.6)),
                style: (stroke: (paint: framarouge, thickness: 1.2pt), fill: none))
            },
          )
        })] // #align 收口：0.7em 只作用于画布
      ],
      // ── Row 2: 图注（独占一行，三列水平对齐）──
      [#align(center)[#text(size: 0.63em, fill: framagris)[环形 · inner-radius + outset]]],
      [#align(center)[#text(size: 0.63em, fill: framagris)[堆积 · mode: "stacked"]]],
      [#align(center)[#text(size: 0.63em, fill: framagris)[区域 · fill + fill-type]]],
    )
  ],
  closing: note[变体即参数：环形 = inner-radius，堆积 = stacked，区域 = fill+fill-type。],
)
