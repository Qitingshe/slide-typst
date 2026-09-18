// chapters/core.typ - 核心公式（内容主要源自原书第 1 章）
// 本文件是「排版层级」的设计示例：每页一个强调色，串联起二级标题 / keyline /
// 卡片 / stat，形成 蓝 → 绿 → 橙 → 紫 的四页色彩走位。
//
// 强调色的声明方式（重要）：#slide-accent(色值) 放在「上一页的末尾」，
// 作为被吸收的收尾内容（Touying 不会为它单独翻页）；放在「下一页标题之前」
// 会在两页之间凭空多出一页空页。第一页可省去声明——直接用默认 framableu。
#import "../lib.typ": *

// ---------- 开场页（独立干净页，无页眉/页脚）----------
#section-open(
  title: [核心公式],
  subtitle: [一条公式，贯穿全书的骨架],
  color: framableu,
)

// ---------- 第 1 页 · 强调色 framableu（默认，无需声明）----------

== Agent = LLM + 上下文 + 工具

#body-slide(
  kicker: [大脑思考 · 眼睛观察 · 手脚行动],
  inner: [
    #stretch-grid(
      columns: 3,
      gutter: 1em,
      boitebleue(stretch: true)[
        #align(center)[*大脑 · LLM*]
        - 理解意图、思考规划、判断决策
        - 预训练世界知识 + 后训练固化决策策略（第 8 章）
      ],
      boiteverte(stretch: true)[
        #align(center)[*眼睛 · 上下文*]
        - 每个决策点能看到的信息表示
        - 环境观察、用户记忆、领域知识、任务进展
      ],
      boiteorange(stretch: true)[
        #align(center)[*手脚 · 工具*]
        - 感知或改变世界的接口
        - 工具定义、调用协议、适配器
      ],
    )
  ],
  closing: boiterouge[
    *边界澄清*：该公式只描述 Agent 边界之内的实现，不包含 Environment。
    Agent 通过「观察通道 + 动作接口」与环境交互 —— 见下页闭环图。
  ],
)

// 下一页强调色：本页末尾收尾声明（被吸收，不翻页）
#slide-accent(framavert)

// ---------- 第 2 页 · 强调色 framavert ----------

== Agent 与环境的闭环

#body-slide(
  kicker: [观察进，行动出 —— 通道即边界],
  inner: [
    #grid(
      columns: (1fr, 1fr),
      gutter: 1em,
      [
        - 外层：Agent 与环境闭环交互 —— 环境返回*观察*，Agent 选择*行动*；行动改变环境状态，产生下一次观察。
        - 内层：*Model–Harness 结构* —— Model 负责策略决策；Harness 构造上下文、暴露工具接口、维护循环与状态。
        - 生产系统还会在 Harness 中加入*约束、验证、纠正*（见「工程要点」）。
        #v(gap-primary)
        #note[未进入上下文的观察对模型「不存在」；动作接口不允许的操作只能停留在文字建议。]
      ],
      [
        #cetz.canvas({
          import cetz.draw: *

          // Agent 边界（左）—— 跟随本页强调色（绿）
          rect((0.3, 0.5), (4.6, 5.9), fill: framavert.lighten(80%), stroke: framavert)
          content((2.45, 5.35), text(fill: framavert, weight: "bold")[*Agent*])

          // Model 与 Harness
          circle((2.45, 4.0), radius: 0.7, fill: framaorange.transparentize(15%), stroke: framaorange)
          content((2.45, 4.0), text(size: 0.85em, weight: "bold")[*Model*])

          rect((0.8, 0.8), (4.1, 3.0), fill: white, stroke: framableulight)
          content((2.45, 2.6), text(size: 0.8em, weight: "bold")[*Harness*])
          content((2.45, 2.05), text(size: 0.62em)[上下文构造])
          content((2.45, 1.65), text(size: 0.62em)[工具接口 · 状态])
          content((2.45, 1.25), text(size: 0.62em)[约束 · 验证 · 纠正])

          // Environment 边界（右）—— 用紫色形成绿 / 紫对比
          rect((5.6, 0.5), (10.8, 5.9), fill: framaviolet.lighten(88%), stroke: framaviolet)
          content((8.2, 5.35), text(fill: framaviolet, weight: "bold")[*Environment*])
          content((8.2, 3.9), text(size: 0.68em)[文件 · 数据库 · 网页])
          content((8.2, 3.5), text(size: 0.68em)[用户 · 其他 Agent])
          content((8.2, 3.1), text(size: 0.68em)[物理 / 仿真世界])

          // 观察与行动
          line((4.6, 4.8), (5.6, 4.8), mark: (end: "stealth"))
          content((5.1, 5.1), text(size: 0.68em)[行动])
          line((5.6, 1.6), (4.6, 1.6), mark: (end: "stealth"))
          content((5.1, 1.25), text(size: 0.68em)[观察])
        })
      ],
    )
  ],
)

// 下一页强调色：本页末尾收尾声明
#slide-accent(framaorange)

// ---------- 第 3 页 · 强调色 framaorange ----------

== ReAct 循环

#grid(
  columns: (1fr, 1.1fr),
  gutter: 1em,
  [
    #cetz.canvas({
      import cetz.draw: *

      // 思考（上）—— 跟随本页强调色（橙）
      circle((2.2, 4.0), radius: 0.8, fill: framaorange, stroke: none)
      content((2.2, 4.0), text(size: 0.85em, fill: white, weight: "bold")[*思考*])

      // 行动（右下）
      circle((4.9, 1.9), radius: 0.8, fill: framableu, stroke: none)
      content((4.9, 1.9), text(size: 0.85em, fill: white, weight: "bold")[*行动*])

      // 观察（左下）
      circle((2.2, 0.2), radius: 0.8, fill: framavert, stroke: none)
      content((2.2, 0.2), text(size: 0.85em, fill: white, weight: "bold")[*观察*])

      // 循环箭头
      line((2.9, 3.65), (4.15, 2.45), mark: (end: "stealth"))
      line((4.45, 1.35), (2.95, 0.55), mark: (end: "stealth"))
      line((1.55, 0.95), (1.55, 3.15), mark: (end: "stealth"))

      // 说明
      content((5.8, 2.7), text(size: 0.66em)[推理下一步])
      content((5.8, 0.9), text(size: 0.66em)[调用工具])
      content((0.5, 3.8), text(size: 0.66em)[工具结果回传])
    })
  ],
  [
    #keyline(size: 21pt)[$"上下文" = "静态前缀" + "轨迹"$]
    #v(gap-primary)
    - *轨迹* = 用户消息 + 模型回复（思考 / 内容 / 工具调用）+ 工具执行结果
    - *想 → 做 → 看*：思考该做什么 → 调用工具 → 观察结果，循环直至任务完成
    - 轨迹可解释、可调试，还可沉淀为知识库或 RL 训练语料（第 7–9 章）
    #v(gap-primary)
    #stretch-grid(
      columns: 2,
      gutter: 0.7em,
      stat(amount-size: 30pt, color: framaorange, stretch: true, [3], [多币种汇总 · 迭代]),
      stat(amount-size: 30pt, color: framableu, stretch: true, [4], [多币种汇总 · 工具调用]),
    )
  ],
)

// 下一页强调色：本页末尾收尾声明
#slide-accent(framaviolet)

// ---------- 第 4 页 · 强调色 framaviolet ----------

== 上下文五要素

#body-slide(
  kicker: [残缺的上下文，持续生产「完美」的错觉],
  inner: [
    #grid(
      columns: (1.25fr, 1fr),
      gutter: 0.9em,
      [
        #boiteviolette[
          *静态前缀*（每次调用不变）
          - 系统提示词：身份 / 权限 / 行为准则
          - 工具定义：名称 / 描述 / 参数格式
        ]
        #v(0.2em) // 单元格内堆叠留白收紧：整页元素密集，保证单页容纳
        #boiteorange[
          *动态轨迹*（随交互增长）
          - 用户消息：需求输入，可注入 RAG 外部知识
          - 模型回复 + 工具结果：思考 / 调用 / 反馈
        ]
      ],
      [
        #stat(amount-size: 36pt, [5], [上下文要素])
        #v(0.2em) // 单元格内堆叠留白收紧：整页元素密集，保证单页容纳
        #boitefilled(color: framableu)[
          *消融洞察（实验 1-1）*
          缺工具定义 → 行动归零；缺工具结果 → 盲目重试；缺历史 → 重复犯错。
          「给出回答」≠「完成任务」。
        ]
      ],
    )
  ],
)

// 收尾：把强调色还给默认 framableu，避免「紫」路泄漏到后续章节
#slide-accent(framableu)