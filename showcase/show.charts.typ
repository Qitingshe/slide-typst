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
// 图例字级独立降档：leg-label 只缩图例文字（0.7em×0.8em≈11.9pt），刻度/轴标原档不动。
// ⚠ chart / plot 由 lib.typ 顶层导出直接可用；不要再 #import cetz / cetz-plot。
#import "../lib.typ": *

// 图例标签降档：cetz-plot 无独立图例字号键，图例 label 是 Typst content，
// 用内嵌 set text 只缩图例（0.7em×0.8em≈11.9pt，低于刻度 14.9pt 一档）。
// ⚠ 坑：0.6em 会叠成 0.42×基准过小，0.8em 是调好的档位勿动；代码块末尾
//       必须裸写 label 值（写成 [label] 会输出字面量文本 "label"）。
#let leg-label(label) = { set text(size: 0.8em); label }

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
  (leg-label[复制], 52),
  (leg-label[换色], 40),
  (leg-label[复用], 36),
  (leg-label[重排], 30),
  (leg-label[自绘], 26),
  (leg-label[公式], 22),
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
        #align(left)[
          // 图表区字级 0.7em：cetz 文本继承上下文字号（原 21.2pt 正文级，用户目检
          // 反馈太大）；对齐 deck 助文/图注档 ≈14.8pt。set 须放画布体外（体内会被
          // cetz 当元素解析报错）；用 #align 收口作用域且零块间距，不翻页。
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
              fill: none,
              stroke: (paint: framagris.lighten(65%), thickness: 0.4pt),
              item: (spacing: 0.2, preview: (width: 0.32, height: 0.32)),
            ),
          )
        })] // #align 收口：0.7em 只作用于画布
        #v(0.06em)
        #align(center)[#text(size: 0.63em, fill: framagris)[图 1:借页六种用法占比（N=206）——numbly 模板]]
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
//        会让数值域从 0.4 起、刻度漂移（本页给 0..7）；③ plot 系（barchart/plot）的
//        legend 只收锚点字符串（"inner-north-east" 等预设），样式走 set-style(legend: …)
//        ——把饼图那种 (position: …, fill: …) 字典传进来会直接 panic；④ x-format 默认
//        float 保留两位小数（0.00/2.50 很丑），用 plot.formats.decimal.with(digits: 0)
//        显式取整才干净；⑤ 图例 fill 一律 none：实色盖住绘图区。
== 图表 · 柱状图

#let bar-data = (
  ([封面], 0.5, 1.0, 4.0, 2.0),
  ([开场], 0.5, 1.0, 3.0, 1.5),
  ([骨架], 0.5, 0.5, 2.0, 1.0),
  ([卡片], 1.0, 1.5, 3.5, 2.5),
  ([数据], 1.0, 1.5, 4.0, 3.0),
  ([示意], 2.0, 2.0, 6.0, 4.5),
)

#body-slide(
  kicker: [chart.barchart —— 行类别 × 列系列的分组柱状],
  inner: [
    #grid(
      columns: (1.25fr, 1fr),
      gutter: 1em,
      [
        #align(left)[
          // 图表区字级 0.7em（同饼图页）：cetz 文本继承上下文 → ≈14.8pt 助文档。
          #set text(size: 0.7em)
          #cetz-canvas({
          import cetz.draw: *

          set-style(legend: (fill: none, stroke: (paint: framagris.lighten(65%), thickness: 0.4pt)))

          let bar-colors = (framableu, framarouge, framavert, framaorange)
          chart.barchart(
            mode: "clustered",
            size: (9, auto),
            label-key: 0,
            value-key: (..range(1, 5)),
            x-tick-step: 2,
            x-min: 0,
            x-max: 7,
            x-format: plot.formats.decimal.with(digits: 0),
            bar-style: i => (fill: bar-colors.at(i), stroke: none),
            bar-data,
            labels: (leg-label[整页复制], leg-label[换色], leg-label[换组件], leg-label[改写]),
            legend: "inner-north-east",
          )
        })] // #align 收口：0.7em 只作用于画布
        #v(0.12em)
        #align(center)[#text(size: 0.63em, fill: framagris)[图 2:六类页面的四种改造路径（小时/页,clustered）]]
      ],
      [
        - 行 = 类别（`label-key`），列 = 系列（`value-key` 取 1..4 列）。
        - `labels` 传系列名；`bar-style` 是 `i => (fill: 色, …)`，与 labels 对应。
        - `x-tick-step` / `x-min` / `x-max` / `x-format` 经 `..plot-args` 透传。
        #v(gap-primary)
        #stat(color: framaorange)[#numbly("{1} 小时")(6)][单页最重改造 · numbly]
      ],
    )
  ],
  closing: note[值域 0..7 小时、刻度每 2 小时一格；横向条按行读——示意页三档改造工时明显高于前五类。],
)

// 用法: #plot.plot(size, x-tick-step, x-min/max, x-format, y-tick-step, y-min/max, y-format,
//       x-grid/y-grid, legend, { #plot.add(数据, label, style, mark, mark-size, mark-style) … })
// 改这里: plot.plot 管画布与坐标轴（axis 类参数直接挂具名参数）；每条曲线一个 plot.add：
//         label 进图例、style 定线色/粗细/虚实、mark 用预置符号（"o" / "square" / "triangle"）。
//         数据 = ((x, y), …) 元组序列；本页 3 条曲线共享 0..5 轮次。
// ⚠ 坑: ① mark-style 必须与 style 同色声明——散点走独立样式链，不继承线色，漏写会
//        回落默认蓝红绿序列与线色失配；② legend 的 inner-* 是「内嵌」预设，会盖在
//        绘图区内，给右上角留白再挂；③ x/y-format 默认 float 保留两位小数，用
//        plot.formats.decimal.with(digits: …) 显式取整；④ 图例锚点传字符串预设
//        （"inner-north-east"），不能用画布坐标；⑤ 图例 fill 同饼图坑：用 none。
== 图表 · 线性图

#let loss-train = ((0, 2.40), (1, 1.55), (2, 1.05), (3, 0.75), (4, 0.58), (5, 0.46))
#let loss-drop = calc.round((1 - 0.46 / 2.40) * 100)

#body-slide(
  kicker: [plot.plot + plot.add —— 曲线、标记、图例皆可定制],
  inner: [
    #grid(
      columns: (1.25fr, 1fr),
      gutter: 1em,
      [
        #align(left)[
          // 图表区字级 0.7em（同饼图页）：cetz 文本继承上下文 → ≈14.8pt 助文档。
          #set text(size: 0.7em)
          #cetz-canvas({
          import cetz.draw: *

          set-style(
            axes: (
              stroke: (paint: framagris, thickness: 0.4pt),
              tick: (stroke: (paint: framagris, thickness: 0.4pt)),
              grid: (stroke: (paint: framagris.lighten(50%), thickness: 0.25pt, dash: "dotted")),
            ),
            legend: (fill: none, stroke: (paint: framagris.lighten(65%), thickness: 0.4pt)),
          )
          plot.plot(
            size: (9, 4.2),
            x-tick-step: 1, x-min: 0, x-max: 5,
            x-format: plot.formats.decimal.with(digits: 0),
            y-tick-step: 0.5, y-min: 0, y-max: 2.6,
            y-format: plot.formats.decimal.with(digits: 1),
            x-grid: true, y-grid: true,
            legend: "inner-north-east",
            {
              plot.add(loss-train,
                label: leg-label[训练], mark: "o", mark-size: 0.17,
                style: (stroke: (paint: framableu, thickness: 1.4pt), fill: none),
                mark-style: (fill: framableu, stroke: none))
              plot.add(((0, 2.42), (1, 1.75), (2, 1.35), (3, 1.12), (4, 1.01), (5, 0.96)),
                label: leg-label[验证], mark: "square", mark-size: 0.16,
                style: (stroke: (paint: framarouge, thickness: 1.4pt), fill: none),
                mark-style: (fill: framarouge, stroke: none))
              plot.add(((0, 2.45), (1, 1.80), (2, 1.38), (3, 1.10), (4, 0.94), (5, 0.86)),
                label: leg-label[验证·正则], mark: "triangle", mark-size: 0.17,
                style: (stroke: (paint: framaviolet, thickness: 1.4pt, dash: "dashed"), fill: none),
                mark-style: (fill: framaviolet, stroke: none))
            },
          )
        })] // #align 收口：0.7em 只作用于画布
        #v(0.12em)
        #align(center)[#text(size: 0.63em, fill: framagris)[图 3:训练 / 验证损失曲线（raw 折线 + 预置标记）]]
      ],
      [
        - 每条线独立 #plot.add：label / style / mark 按线声明。
        - 轴参数直接挂 #plot.plot：`x-tick-step` / `y-format` 等。
        - 图例锚点 `"inner-north-east"`，绘图区右上角本页刻意留白。
        #v(gap-primary)
        #stat(color: framableu)[#numbly("{1}%")(loss-drop)][训练损失降幅（5 轮）· numbly]
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
//       不透明色带，第一眼只信曲线不置信封——颜色仍用 frama 主色半透即可。
== 图表 · 变体速查

#body-slide(
  kicker: [一个家族三个变体 —— 环形 / 堆积 / 区域],
  inner: [
    #grid(
      columns: (1fr, 1fr, 1fr),
      gutter: 0.8em,
      [
        #align(left)[
          // 图表区字级 0.7em（同饼图页）：cetz 文本继承上下文 → ≈14.8pt 助文档。
          #set text(size: 0.7em)
          #cetz-canvas({
          import cetz.draw: *

          chart.piechart(
            (([直接], 55), ([换皮], 30), ([自绘], 15)),
            value-key: 1,
            label-key: none,
            radius: 1.6,
            inner-radius: 0.8,
            outset: 0,
            stroke: none,
            slice-style: (framableu, framavert, framarouge),
            outer-label: (
              content: (value, label) => numbly("{1}%")(calc.round(value / 100 * 100)),
              radius: 115%,
            ),
          )
        })] // #align 收口：0.7em 只作用于画布
        #v(0.1em)
        #align(center)[#text(size: 0.63em, fill: framagris)[环形 · inner-radius + outset]]
      ],
      [
        #align(left)[
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
            x-max: 15,
            x-tick-step: 5,
            x-format: plot.formats.decimal.with(digits: 0),
            bar-style: i => (fill: (framableu, framarouge, framavert).at(i), stroke: none),
            (([新版], 4, 3, 2), ([旧版], 3, 2, 1), ([对照], 1, 1, 1)),
            legend: none,
          )
        })] // #align 收口：0.7em 只作用于画布
        #v(0.1em)
        #align(center)[#text(size: 0.63em, fill: framagris)[堆积 · mode: "stacked"]]
      ],
      [
        #align(left)[
          // 图表区字级 0.7em（同饼图页）：cetz 文本继承上下文 → ≈14.8pt 助文档。
          #set text(size: 0.7em)
          #cetz-canvas({
          import cetz.draw: *

          set-style(axes: (grid: (stroke: (paint: framagris.lighten(55%), thickness: 0.25pt, dash: "dotted"))))
          plot.plot(
            size: (7, 3),
            x-tick-step: 1, x-min: 0, x-max: 4,
            x-format: plot.formats.decimal.with(digits: 0),
            y-tick-step: 1, y-min: 0, y-max: 4.5,
            y-format: plot.formats.decimal.with(digits: 0),
            {
              plot.add(((0, 4.0), (1, 2.4), (2, 1.6), (3, 1.1), (4, 0.8)),
                fill: true, fill-type: "axis",
                style: (stroke: (paint: framableu, thickness: 1.2pt), fill: framableu.lighten(55%)))
              plot.add(((0, 3.6), (1, 2.8), (2, 2.2), (3, 1.9), (4, 1.7)),
                style: (stroke: (paint: framarouge, thickness: 1.2pt), fill: none))
            },
          )
        })] // #align 收口：0.7em 只作用于画布
        #v(0.1em)
        #align(center)[#text(size: 0.63em, fill: framagris)[区域 · fill + fill-type]]
      ],
    )
  ],
  closing: note[变体即参数：环形 = inner-radius + outset，堆积 = mode: "stacked"（数值域 = 各列
  之和），区域 = 曲线 fill: true 沿轴基线铺色带。抄页时对照本页与前三页的 ⚠ 坑即可。],
)