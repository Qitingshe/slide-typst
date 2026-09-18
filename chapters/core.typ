// chapters/core.typ - 核心公式（内容主要源自原书第 1 章）
#import "../lib.typ": *

== Agent = LLM + 上下文 + 工具

#align(center)[
  #text(size: 26pt, weight: "bold", fill: framableu)[$"Agent" = "LLM" + "上下文" + "工具"$]
]

#v(0.6em)

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 1em,
  [
    #boitebleue[
      #align(center)[*大脑 · LLM*]
      - 理解意图、思考规划、判断决策
      - 预训练习得世界知识 + 后训练固化决策策略（第 8 章）
    ],
  ],
  [
    #boiteverte[
      #align(center)[*眼睛 · 上下文*]
      - 每个决策点能看到的信息表示
      - 环境观察、用户记忆、领域知识、任务进展
    ],
  ],
  [
    #boiteorange[
      #align(center)[*手脚 · 工具*]
      - 感知或改变世界的接口
      - 工具定义、调用协议、适配器
    ],
  ],
)

#v(0.8em)

#boiterouge[
  *边界澄清*：该公式只描述 Agent 边界之内的实现，不包含 Environment。
  Agent 通过「观察通道 + 动作接口」与环境交互 —— 见下页闭环图。
]

== Agent 与环境的闭环

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    - 外层：Agent 与环境闭环交互 —— 环境返回*观察*，Agent 选择*行动*；行动改变环境状态，产生下一次观察。
    - 内层：*Model–Harness 结构* —— Model 负责策略决策；Harness 负责构造上下文、暴露工具接口、维护循环与状态。
    - 生产系统还会在 Harness 中加入*约束、验证、纠正*（见「工程要点」）。
    - 边界：没有进入上下文的观察对模型「不存在」；动作接口不允许的操作只能停留在文字建议。
  ],
  [
    #cetz.canvas({
      import cetz.draw: *

      // Agent 边界（左）
      rect((0.3, 0.5), (4.6, 5.9), fill: framableu.lighten(88%), stroke: framableu)
      content((2.45, 5.35), text(fill: framableu, weight: "bold")[*Agent*])

      // Model 与 Harness
      circle((2.45, 4.0), radius: 0.7, fill: framaorange.transparentize(15%), stroke: framaorange)
      content((2.45, 4.0), text(size: 0.85em, weight: "bold")[*Model*])

      rect((0.8, 0.8), (4.1, 3.0), fill: white, stroke: framableulight)
      content((2.45, 2.6), text(size: 0.8em, weight: "bold")[*Harness*])
      content((2.45, 2.05), text(size: 0.62em)[上下文构造])
      content((2.45, 1.65), text(size: 0.62em)[工具接口 · 状态])
      content((2.45, 1.25), text(size: 0.62em)[约束 · 验证 · 纠正])

      // Environment 边界（右）
      rect((5.6, 0.5), (10.8, 5.9), fill: framavert.lighten(76%), stroke: framavert)
      content((8.2, 5.35), text(fill: framavert, weight: "bold")[*Environment*])
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

== ReAct 循环

#grid(
  columns: (1fr, 1.1fr),
  gutter: 1em,
  [
    #cetz.canvas({
      import cetz.draw: *

      // 思考（上）
      circle((2.2, 4.0), radius: 0.8, fill: framableu, stroke: none)
      content((2.2, 4.0), text(size: 0.85em, fill: white, weight: "bold")[*思考*])

      // 行动（右下）
      circle((4.9, 1.9), radius: 0.8, fill: framaorange, stroke: none)
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
    #align(center)[
      #text(size: 15pt, weight: "bold", fill: framableu)[$"上下文" = "静态前缀" + "轨迹"$]
    ]
    #v(0.5em)
    - *轨迹* = 用户消息 + 模型回复（思考 / 内容 / 工具调用）+ 工具执行结果
    - *想 → 做 → 看*：思考当前该做什么 → 调用工具行动 → 观察结果继续思考，循环直至任务完成
    - 示例：多币种收入汇总 —— 3 次迭代、4 次工具调用完成任务
    - 轨迹可解释、可调试，还可沉淀为知识库或强化学习训练语料（第 7–9 章）
  ],
)

== 上下文五要素

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    #boitebleue[
      *静态前缀*（每次调用不变）
      - 系统提示词：身份 / 权限 / 行为准则；含用户记忆与环境状态
      - 工具定义：名称 / 功能描述 / 参数格式
    ],
  ],
  [
    #boiteorange[
      *动态轨迹*（随交互增长）
      - 用户消息：需求输入；可注入 RAG 外部知识
      - 模型回复：思考 + 内容 + 工具调用
      - 工具执行结果：下一步决策的依据
    ],
  ],
)

#v(0.4em)

#boiteverte[
  *消融洞察（实验 1-1）*：缺工具定义 → 行动归零；缺工具结果 → 盲目重试；缺历史 → 重复犯错。「给出回答」≠「完成任务」——上下文残缺时，失败常表现为完美的编造。
]