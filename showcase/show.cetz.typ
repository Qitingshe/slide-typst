// showcase/show.cetz.typ
// 家族：示意图与公式 —— 图解逻辑与最后的数学收束。
//
// 演示两件事：
//   · cetz-canvas({...})：touying-reducer 包装的 CeTZ 画布，画闭环/循环架构图。
//     本家族两张示意图：研发迭代闭环（五节点圆环）与 PDCA 质量改进环（四节点圆环）。
//   · 数学公式：标准 Typst 数学语法，行内 $x$ 与块级 $ ... $（示例用全书主公式）。
//
// 交叉引用：封面的层叠圆也是 CeTZ 画的（见 lib.typ 的 cover）。
// ⚠ cetz-canvas 直接当函数调用即可；不要再 #import cetz（lib.typ 已导出）。
#import "../lib.typ": *

// 用法: #cetz-canvas({ import cetz.draw: *; rect/circle/line/content(...) }) —— 坐标即厘米（1 单位 = 1cm）
// 改这里: 箭头函数体内用 cetz.draw 原语作画；框内黑文字统一字号（正文 0.62em / 标题 0.78em）、
//         行距统一 0.52，框内上下留白约 0.2~0.3；CJK 一字宽 ≈ 字号，框宽按最长行留够余量。
// ⚠ 坑: ① 坐标单位是厘米，不是像素也不是 em——偏移 1 = 1cm，别拿 CSS 思维猜；
//        ② text() 不随父坐标缩放，字号写多少就是多少——圆/框必须能装下文字，别靠"缩小坐标"压字；
//        ③ 中明度底色（vert/orange/jaune/marron）配深字，深底才配白字；
//        ④ 箭头标签落在箭头中点的空白侧，别压线别压文字；
//        ⑤ 换内容时按坐标比例手动调框与文字位置——CeTZ 不做自动排版；
//        ⑥ 画廊保持静态单帧：借页要逐帧动画时，在 slide 内容里用 Touying 的
//        #pause / #uncover 编排（cetz-canvas 已绑 touying-reducer，通道现成，
//        动画帧会拆成真实 PDF 页，画廊自身不演示）。
== CeTZ · 研发迭代闭环

#body-slide(
  kicker: [需求进，发布出 —— 闭环即迭代],
  inner: [
    #grid(
      columns: (1fr, 1fr),
      gutter: 1em,
      [
        - 研发团队的典型迭代闭环：*需求* → *设计* → *开发* → *测试* → *发布*，发布后产生新的需求，形成持续改进的飞轮。
        - 每个阶段有明确的输入与输出：需求文档驱动设计稿，设计稿驱动代码，代码经过测试后才可发布。
        - 闭环的价值在于反馈：线上数据、用户反馈回流为下一轮需求，推动产品持续演进。
        #v(gap-primary)
        #note[示意图色值手动写死（framavert / framableu），不随本页强调色自动变。]
      ],
      [
        #cetz-canvas({
          import cetz.draw: *

          // 五节点圆环布局：中心 (7.75, 5.5)，半径 2.8cm。
          // 顶部为"需求"，顺时针排列。坐标单位 = 厘米。
          // 保持与原始 Environment/Agent 矩形布局相近的垂直跨度。

          // ── 五个阶段圆（深底白字）
          // 需求（顶部）
          circle((7.75, 8.3), radius: 0.95, fill: framavert, stroke: none)
          content((7.75, 8.3), text(size: 0.65em, fill: white, weight: "bold")[需求])

          // 设计（右上）
          circle((10.15, 6.6), radius: 0.95, fill: framableu, stroke: none)
          content((10.15, 6.6), text(size: 0.65em, fill: white, weight: "bold")[设计])

          // 开发（右下）
          circle((9.25, 3.8), radius: 0.95, fill: framaviolet, stroke: none)
          content((9.25, 3.8), text(size: 0.65em, fill: white, weight: "bold")[开发])

          // 测试（左下）
          circle((6.25, 3.8), radius: 0.95, fill: framarouge, stroke: none)
          content((6.25, 3.8), text(size: 0.65em, fill: white, weight: "bold")[测试])

          // 发布（左上）
          circle((5.35, 6.6), radius: 0.95, fill: framaorange, stroke: none)
          content((5.35, 6.6), text(size: 0.65em, fill: white, weight: "bold")[发布])

          // ── 顺时针循环箭头（首尾让出半径，箭头贴圆边）
          // 需求 → 设计
          line((8.4, 7.85), (9.55, 7.0), mark: (end: "stealth"))
          // 设计 → 开发
          line((10.55, 5.75), (9.65, 4.55), mark: (end: "stealth"))
          // 开发 → 测试
          line((8.4, 3.5), (7.1, 3.5), mark: (end: "stealth"))
          // 测试 → 发布
          line((5.85, 4.55), (5.35, 5.65), mark: (end: "stealth"))
          // 发布 → 需求（回环）
          line((5.6, 7.4), (7.15, 7.85), mark: (end: "stealth"))

          // 中心标注
          content((7.75, 5.8), text(size: 0.55em, fill: framagrisdark, weight: "bold")[持续迭代])
          content((7.75, 5.25), text(size: 0.5em, fill: framagrisdark)[反馈驱动])
        })
      ],
    )
  ],
)

// 用法: #cetz-canvas({...}) 画四节点循环 —— 计划 → 执行 → 检查 → 改进
// 改这里: 四个圆分别定义为「计划 / 执行 / 检查 / 改进」；箭头首尾让出半径，贴住圆边起止。
// ⚠ 坑: ① 四节点圆环的箭头角度须用三角函数算出圆边交点，手调容易压线；
//        ② 底色 framavert 属中明度——配 framagrisdark 深字，不配白字；
//        ③ 全图说明标签统一 0.6em，落在箭头中点的空白侧。
== CeTZ · PDCA 改进环

#grid(
  columns: (1fr, 1.1fr),
  gutter: 1em,
  [
    #cetz-canvas({
      import cetz.draw: *

      // 四节点圆环：中心 (5.5, 5.5)，半径 3.6cm。
      // 顶部"计划"，顺时针：执行 → 检查 → 改进。
      // 坐标单位 = 厘米。

      // ── 四个阶段圆（深底白字）
      // 计划（顶部）
      circle((5.5, 9.1), radius: 1.2, fill: framableu, stroke: none)
      content((5.5, 9.1), text(size: 0.72em, fill: white, weight: "bold")[计划])

      // 执行（右侧）
      circle((9.1, 5.5), radius: 1.2, fill: framavert, stroke: none)
      content((9.1, 5.5), text(size: 0.72em, fill: framagrisdark, weight: "bold")[执行])

      // 检查（底部）
      circle((5.5, 1.9), radius: 1.2, fill: framarouge, stroke: none)
      content((5.5, 1.9), text(size: 0.72em, fill: white, weight: "bold")[检查])

      // 改进（左侧）
      circle((1.9, 5.5), radius: 1.2, fill: framaorange, stroke: none)
      content((1.9, 5.5), text(size: 0.72em, fill: white, weight: "bold")[改进])

      // ── 顺时针循环箭头（首尾让出半径 1.2cm）
      // 计划 → 执行
      line((6.25, 8.35), (8.35, 6.25), mark: (end: "stealth"))
      // 执行 → 检查
      line((8.35, 4.75), (6.25, 2.65), mark: (end: "stealth"))
      // 检查 → 改进
      line((4.75, 2.65), (2.65, 4.75), mark: (end: "stealth"))
      // 改进 → 计划
      line((2.65, 6.25), (4.75, 8.35), mark: (end: "stealth"))

      // 箭头中点标签（空白侧）
      content((8.0, 8.2), text(size: 0.6em, fill: framagrisdark)[识别问题])
      content((9.3, 3.5), text(size: 0.6em, fill: framagrisdark)[验证结果])
      content((2.5, 3.2), text(size: 0.6em, fill: framagrisdark)[总结经验])
      content((2.8, 8.1), text(size: 0.6em, fill: framagrisdark)[标准化])

      // 中心标注
      content((5.5, 5.5), text(size: 0.58em, fill: framagrisdark, weight: "bold")[PDCA])
      content((5.5, 4.85), text(size: 0.52em, fill: framagrisdark)[质量改进])
    })
  ],
  [
    #keyline(size: 21pt)[$"计划" ⟶ "执行" ⟶ "检查" ⟶ "改进"$]
    #v(gap-primary)
    - *计划*：定义目标与改进方案
    - *执行*：小范围实施，收集数据
    - *检查*：对比结果与目标，识别偏差
    - *改进*：将有效方案标准化，纳入管理体系
  ],
)

// 用法: 行内 $x$ 与块级 $ ... $（块级公式前后须留空行，才不被并入正文段落）
// 改这里: 公式内容用标准 Typst 数学语法；"文本" 双引号内是直体字。
// ⚠ 坑: 块级公式默认左对齐；要居中需外包 #align(center)；`a/b` 自动排成分式。
== 数学 · 公式块

#body-slide(
  kicker: [公式用标准 Typst 数学语法，无需插件],
  inner: [
    #align(center)[$ "Agent" = "LLM" + "上下文" + "工具" $]
    #v(gap-primary)
    #align(center)[$ "上下文" = "静态前缀" + "轨迹" $]
    #v(0.2em)
    #align(center)[$ "损失"(D) = 1/n sum_(i=1)^n (hat(y)_i - y_i)^2 $]
    #v(0.2em)
    #align(center)[
      $ "上下文" &= "前缀" + "轨迹" \
                &= s + ("u", m_1, o_1, ..., m_T, o_T) $
    ]
    #v(0.2em)
    #boitebleue[
      行内公式直接写 $x$ / $alpha$；`1/n` 排分式，`sum` 排求和，
      多行推导用 `&=` 锚定等号、`\` 换行。
      // 块级公式默认左对齐——想居中外包 #raw("#align(center)")，仅此一种改法。
    ]
  ],
  // 收尾省略：页面已满，note 移入 boite 末行（作行内附注），避免 closing 泄漏进页脚区。
)
