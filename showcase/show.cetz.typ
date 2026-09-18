// showcase/show.cetz.typ
// 家族：示意图与公式 —— 图解逻辑与最后的数学收束。
//
// 演示两件事：
//   · cetz-canvas({...})：touying-reducer 包装的 CeTZ 画布，画动态架构/闭环图。
//     本家族两张示意图改编自 chapters/core.typ 的闭环图与 ReAct 循环。
//   · 数学公式：标准 Typst 数学语法，行内 $x$ 与块级 $ ... $（示例用全书主公式）。
//
// 交叉引用：封面的层叠圆也是 CeTZ 画的（见 lib.typ 的 cover）。
// ⚠ cetz-canvas 直接当函数调用即可；不要再 #import cetz（lib.typ 已导出）。
#import "../lib.typ": *

// 用法: #cetz-canvas({ import cetz.draw: *; rect/circle/line/content(...) }) —— 坐标即厘米（1 单位 = 1cm）
// 改这里: 箭头函数体内用 cetz.draw 原语作画；框内黑文字统一字号（正文 0.62em / 标题 0.78em）、
//         行距统一 0.52、框内上下留白约 0.2~0.3；CJK 一字宽 ≈ 字号，框宽按最长行留够余量。
// ⚠ 坑: 中明度底（vert/orange/jaune/marron）配深字，深底才配白字；文字按自然尺寸渲染不随
//        坐标缩放，圆/框必须装得下文字（"Model"≈1.2cm 宽，圆半径给 0.8）；箭头标签放
//        走廊空闲侧，别压线别压文字。
== CeTZ · 闭环示意图

#body-slide(
  kicker: [观察进，行动出 —— 通道即边界],
  inner: [
    #grid(
      columns: (1fr, 1fr),
      gutter: 1em,
      [
        - Agent 与环境闭环交互：环境返回*观察*，Agent 选择*行动*，行动改变环境，产生下一次观察。
        - 内层 Model–Harness：Model 做策略决策，Harness 构造上下文、暴露工具接口、维护循环与状态。
        - 未进入上下文的观察对模型「不存在」——通道即边界。
        #v(gap-primary)
        #note[示意图色值手动写死（framarouge / framableu），不随本页强调色自动变。]
      ],
      [
        #cetz-canvas({
          import cetz.draw: *

          // 统一规格：框内黑字 0.62em / 标题 0.78em，行距 0.52，坐标单位 = 厘米
          // Agent 边界（左）—— 浅红底 + 深红标题
          rect((0.25, 0.5), (4.2, 5.9), fill: framarouge.lighten(80%), stroke: framarouge)
          content((2.22, 5.45), text(size: 0.78em, weight: "bold", fill: framarouge)[*Agent*])

          // Model 实底深蓝圆 + 白字；半径 0.8 装得下 "Model"（≈1.2cm 宽）
          circle((2.22, 4.3), radius: 0.8, fill: framableu, stroke: none)
          content((2.22, 4.3), text(size: 0.78em, weight: "bold", fill: white)[*Model*])

          // Harness 白底灰框 —— 标题 + 三行统一黑字（0.62em / 行距 0.52 / 上下留白对称）
          rect((0.52, 1.05), (3.92, 3.6), fill: white, stroke: framagris)
          content((2.22, 3.12), text(size: 0.78em, weight: "bold", fill: framagrisdark)[*Harness*])
          content((2.22, 2.6), text(size: 0.62em, fill: framagrisdark)[上下文构造])
          content((2.22, 2.08), text(size: 0.62em, fill: framagrisdark)[工具接口 · 状态])
          content((2.22, 1.56), text(size: 0.62em, fill: framagrisdark)[约束 · 验证 · 纠正])

          // Environment 边界（右）—— 浅蓝底 + 深蓝标题，三行黑字与 Harness 同规格
          rect((7.5, 0.5), (11.7, 5.9), fill: framableu.lighten(88%), stroke: framableu)
          content((9.6, 5.45), text(size: 0.78em, weight: "bold", fill: framableu)[*Environment*])
          content((9.6, 4.3), text(size: 0.62em, fill: framagrisdark)[文件 · 数据库 · 网页])
          content((9.6, 3.78), text(size: 0.62em, fill: framagrisdark)[用户 · 其他 Agent])
          content((9.6, 3.26), text(size: 0.62em, fill: framagrisdark)[物理 / 仿真世界])

          // 行动 / 观察：箭头横贯框间走廊，标签在箭头空侧、与线和框边留白
          line((4.2, 4.75), (7.5, 4.75), mark: (end: "stealth"))
          content((5.85, 5.25), text(size: 0.62em, fill: framagrisdark)[行动])
          line((7.5, 1.85), (4.2, 1.85), mark: (end: "stealth"))
          content((5.85, 1.3), text(size: 0.62em, fill: framagrisdark)[观察])
        })
      ],
    )
  ],
)

// 用法: #cetz-canvas({...}) 画三节点循环 —— 思考 → 行动 → 观察
// 改这里: 三个圆分别定义为「思考 / 行动 / 观察」；箭头首尾让出半径，贴住圆边起止。
// ⚠ 坑: ReAct 的「观察回传」走内层箭头（左下→顶部），不是逆时针绕行；
//        观察底色 framavert 属中明度——配 framagrisdark 深字，不配白字；
//        全图说明标签统一 0.66em，落在箭头中点的空白侧。
== CeTZ · ReAct 循环

#grid(
  columns: (1fr, 1.1fr),
  gutter: 1em,
  [
    #cetz-canvas({
      import cetz.draw: *

      // 思考（上，framarouge）+ 行动（右下，framableu）：深底白字
      circle((2.4, 4.6), radius: 0.75, fill: framarouge, stroke: none)
      content((2.4, 4.6), text(size: 0.85em, fill: white, weight: "bold")[*思考*])

      circle((4.6, 1.7), radius: 0.75, fill: framableu, stroke: none)
      content((4.6, 1.7), text(size: 0.85em, fill: white, weight: "bold")[*行动*])

      // 观察（左下，framavert）：中明度底 + 深字
      circle((0.9, 1.7), radius: 0.75, fill: framavert, stroke: none)
      content((0.9, 1.7), text(size: 0.85em, fill: framagrisdark, weight: "bold")[*观察*])

      // 循环箭头：首尾让出半径，标签锚在箭头中点旁的空白侧
      line((2.85, 4.0), (4.15, 2.3), mark: (end: "stealth"))
      content((4.2, 3.7), text(size: 0.66em)[推理下一步])
      line((3.85, 1.7), (1.65, 1.7), mark: (end: "stealth"))
      content((2.75, 1.12), text(size: 0.66em)[调用工具])
      line((1.245, 2.37), (2.06, 3.93), mark: (end: "stealth"))
      content((0.82, 3.5), text(size: 0.66em)[工具结果回传])
    })
  ],
  [
    #keyline(size: 21pt)[$"想" ⟶ "做" ⟶ "看"$]
    #v(gap-primary)
    - *轨迹* = 用户消息 + 模型回复（思考 / 内容 / 工具调用）+ 工具执行结果
    - *想 → 做 → 看*：思考该做什么 → 调用工具 → 观察结果，循环直至任务完成
    - 轨迹可解释、可调试，还可沉淀为知识库或 RL 训练语料
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