// chapters/core.typ - 核心公式（内容源自原书第 1 章）
// 强调色走位：蓝 → 绿 → 橙 → 紫，每页末尾声明下一页颜色。
// 本分段从 main.typ 的 `= 核心公式` 进入，开场页紧随其后。
#import "../lib.typ": *

#section-open(
  title: [核心公式],
  subtitle: [一条公式，贯穿全书的骨架],
  color: framableu,
)

// ---------- 第 1 页 · framableu（默认，无需声明）----------

== Agent = LLM + 上下文 + 工具

#body-slide(
  kicker: [大脑思考 · 眼睛观察 · 手脚行动],
  inner: [
    #stretch-grid(
      columns: 3,
      gutter: gutter-primary,
      boitebleue(stretch: true)[
        #align(center)[*大脑 · LLM*]
        - 理解意图、思考规划、判断决策
        - 预训练世界知识 + 后训练固化决策策略
      ],
      boiteverte(stretch: true)[
        #align(center)[*眼睛 · 上下文*]
        - 每个决策点能看到的信息表示
        - 环境观察、用户记忆、领域知识、任务进展
      ],
      boiteorange(stretch: true)[
        #align(center)[*手脚 · 工具*]
        - 感知或改变世界的接口
        - 工具定义、调用协议、适配器（MCP）
      ],
    )
  ],
  closing: boiterouge[
    *边界澄清*：公式描述的是 Agent 内部的实现结构，
    不包含 Environment。Agent 通过观察 + 动作接口与环境交互。
  ],
)

#slide-accent(framavert)

// ---------- 第 2 页 · framavert ----------

== Agent 与环境的闭环

#body-slide(
  kicker: [观察进，行动出 —— 通道即边界],
  inner: [
    #grid(
      columns: (1fr, 1fr),
      gutter: gutter-loose,
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
          rect((0.2, 0.4), (5.06, 7.6), fill: framavert.lighten(80%), stroke: framavert)
          content((2.63, 7.0), text(fill: framavert.darken(10%), weight: "bold")[*Agent*])
          // Model 圆（半径再放大 1.2 倍 → 0.7×1.44≈1.01）
          circle((2.63, 5.2), radius: 1.01, fill: framarougelight, stroke: none)
          content((2.63, 5.2), text(size: 0.8em, weight: "bold")[*Model*])
          // Harness 矩形（偏移保持，宽×1.2、高×1.5）
          rect((0.6, 0.6), (4.5, 3.75), fill: white, stroke: framableulight)
          content((2.55, 3.5), text(size: 0.78em, weight: "bold")[*Harness*])
          content((2.55, 2.7), text(size: 0.62em)[上下文构造])
          content((2.55, 2.1), text(size: 0.62em)[工具接口 · 状态])
          content((2.55, 1.5), text(size: 0.62em)[约束 · 验证 · 纠正])
          // Environment 边界（右，间距按 1.2 倍）
          rect((6.86, 0.4), (12.86, 7.6), fill: framaviolet.lighten(88%), stroke: framaviolet)
          content((9.86, 7.0), text(fill: framaviolet.darken(10%), weight: "bold")[*Environment*])
          content((9.86, 5.0), text(size: 0.68em)[文件 · 数据库 · 网页])
          content((9.86, 4.4), text(size: 0.68em)[用户 · 其他 Agent])
          content((9.86, 3.8), text(size: 0.68em)[物理 / 仿真世界])
          // 行动（Agent → Environment，长度 1.2→1.8×1.5）
          line((5.06, 6.4), (6.86, 6.4), mark: (end: "stealth"))
          content((5.96, 6.7), text(size: 0.68em)[行动])
          // 观察（Environment → Agent，长度 1.2→1.8×1.5）
          line((6.86, 2.2), (5.06, 2.2), mark: (end: "stealth"))
          content((5.96, 1.9), text(size: 0.68em)[观察])
        })
      ],
    )
  ],
  closing: none,
)

#slide-accent(framaorange)

// ---------- 第 3 页 · framaorange ----------

== ReAct 循环

#grid(
  columns: (1.2fr, 1fr),
  gutter: gutter-primary,
  [
    #cetz.canvas({
      import cetz.draw: *
      // 等腰三角形布局：思考（顶），行动（右下），观察（左下）
      // 画布宽 0-10，高 0-7，图形居中在 4-7 高度
      let cx = 5.0  // 水平中心
      // 思考（顶部居中）
      circle((cx, 6.0), radius: 1.2, fill: framagrisdark, stroke: none)
      content((cx, 6.0), text(size: 1em, fill: white, weight: "bold")[*思考*])
      // 行动（右下）
      circle((7.5, 2.5), radius: 1.2, fill: framableu, stroke: none)
      content((7.5, 2.5), text(size: 1em, fill: white, weight: "bold")[*行动*])
      // 观察（左下）
      circle((2.5, 2.5), radius: 1.2, fill: framavert, stroke: none)
      content((2.5, 2.5), text(size: 1em, fill: white, weight: "bold")[*观察*])
      // 箭头：思考 → 行动（右下方向）
      line((cx + 0.85, 5.2), (6.8, 3.4), mark: (end: "stealth"))
      // 箭头：行动 → 观察（左下方向）
      line((6.3, 2.5), (3.7, 2.5), mark: (end: "stealth"))
      // 箭头：观察 → 思考（上方向）
      line((3.35, 3.4), (cx - 0.85, 5.2), mark: (end: "stealth"))
      // 标签
      content((8.5, 4.3), text(size: 0.8em)[推理下一步])
      content((5.0, 2.0), text(size: 0.8em)[调用工具])
      content((1.5, 4.3), text(size: 0.8em)[工具结果回传])
    })
  ],
  [
    #keyline(size: 21pt)[$"上下文" = "静态前缀" + "轨迹"$]
    #v(gap-primary)
    - *轨迹* = 用户消息 + 模型回复（思考/内容/工具调用）+ 工具结果
    - *想→做→看*：思考 → 调用工具 → 观察结果，循环直至任务完成
    - 轨迹可解释、可调试，还可沉淀为知识库或 RL 训练语料
    #v(gap-primary)
    #stretch-grid(
      columns: 2,
      gutter: gutter-tight,
      stat(amount-size: 30pt, color: framaorange, stretch: true, [2], [迭代步]),
      stat(amount-size: 30pt, color: framableu, stretch: true, [3], [工具调用]),
    )
  ],
)

#slide-accent(framaviolet)

// ---------- 第 4 页 · framaviolet ----------

== 上下文五要素

#body-slide(
  kicker: [残缺的上下文，持续生产「完美」的错觉],
  inner: [
    #grid(
      columns: (1.25fr, 1fr),
      gutter: gutter-tight,
      [
        #boiteviolette[
          *静态前缀*（每次调用不变）
          - 系统提示词：身份 / 权限 / 行为准则
          - 工具定义：名称 / 描述 / 参数格式
        ]
        #v(0.2em)
        #boiteorange[
          *动态轨迹*（随交互增长）
          - 用户消息：需求输入，可注入 RAG 外部知识
          - 模型回复 + 工具结果：思考 / 调用 / 反馈
        ]
      ],
      [
        #stat(amount-size: 36pt, [5], [上下文要素])
        #v(0.2em)
        #boitefilled(color: framableu)[
          *消融洞察（实验 1-1）*
          缺工具定义 → 行动归零；缺工具结果 → 盲目重试；缺历史 → 重复犯错。
          「给出回答」≠「完成任务」。
        ]
      ],
    )
  ],
)

// 收尾：把强调色还给默认 framableu，避免「紫」泄漏到后续分段
#slide-accent(framableu)