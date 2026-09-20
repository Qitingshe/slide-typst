// chapters/core.typ - 核心公式（内容源自原书第 1 章）
// 强调色走位：蓝 → 绿 → 橙 → 紫 → 蓝，每页末尾声明下一页颜色。
// 设计定位（与 engineering 的差异化分工）：
//   core =「公式引入」——cmp-grid 维度对照 / flow-steps 流程条 / 纵向时间线；
//   engineering =「工程总结」——流程条压缩版 / 色点图例 / 阅读路径。
//   两处不逐字重复：范式演进 core 纵向带主导者、engineering 横向带实证。
#import "../lib.typ": *

#section-open(
  title: [核心公式],
  subtitle: [一条公式，贯穿全书的骨架],
  color: framableu,
)

// ---------- 第 1 页 · framableu ----------

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
    公式中的加号表示工程组件的组合，而非形式化定义。
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
        - 生产系统还会在 Harness 中加入*约束、验证、纠正*。
        #v(gap-primary)
        #note[未进入上下文的观察对模型「不存在」；动作接口不允许的操作只能停留在文字建议。]
      ],
      [
        #cetz.canvas({
          import cetz.draw: *
          // Agent 边界（左）
          rect((0.2, 0.4), (5.06, 7.6), fill: framavert.lighten(80%), stroke: framavert)
          content((2.63, 7.0), text(fill: framavert.darken(10%), weight: "bold")[*Agent*])
          // Model 圆
          circle((2.63, 5.2), radius: 1.01, fill: framarougelight, stroke: none)
          content((2.63, 5.2), text(size: 0.8em, weight: "bold")[*Model*])
          // Harness 矩形
          rect((0.6, 0.6), (4.5, 3.75), fill: white, stroke: framableulight)
          content((2.55, 3.5), text(size: 0.78em, weight: "bold")[*Harness*])
          content((2.55, 2.7), text(size: 0.62em)[上下文构造])
          content((2.55, 2.1), text(size: 0.62em)[工具接口 · 状态])
          content((2.55, 1.5), text(size: 0.62em)[约束 · 验证 · 纠正])
          // Environment 边界（右）
          rect((6.86, 0.4), (12.86, 7.6), fill: framaviolet.lighten(88%), stroke: framaviolet)
          content((9.86, 7.0), text(fill: framaviolet.darken(10%), weight: "bold")[*Environment*])
          content((9.86, 5.0), text(size: 0.68em)[文件 · 数据库 · 网页])
          content((9.86, 4.4), text(size: 0.68em)[用户 · 其他 Agent])
          content((9.86, 3.8), text(size: 0.68em)[物理 / 仿真世界])
          // 行动（Agent → Environment）
          line((5.06, 6.4), (6.86, 6.4), mark: (end: "stealth"))
          content((5.96, 6.7), text(size: 0.68em)[行动])
          // 观察（Environment → Agent）
          line((6.86, 2.2), (5.06, 2.2), mark: (end: "stealth"))
          content((5.96, 1.9), text(size: 0.68em)[观察])
        })
      ],
    )
  ],
  closing: none, // CeTZ 图 + 左栏 note 已构成完整收束，不再追加
)

#slide-accent(framaorange)

// ---------- 第 3 页 · framaorange ----------

== ReAct 循环

#body-slide(
  kicker: [想 → 做 → 看：Agent 的思考—行动—观察三角],
  inner: [
    #grid(
      columns: (1.2fr, 1fr),
      gutter: gutter-primary,
      [
        #cetz.canvas({
          import cetz.draw: *
          let cx = 5.0
          // 思考（顶部居中）
          circle((cx, 6.0), radius: 1.2, fill: framagrisdark, stroke: none)
          content((cx, 6.0), text(size: 1em, fill: white, weight: "bold")[*思考*])
          // 行动（右下）
          circle((7.5, 2.5), radius: 1.2, fill: framableu, stroke: none)
          content((7.5, 2.5), text(size: 1em, fill: white, weight: "bold")[*行动*])
          // 观察（左下）
          circle((2.5, 2.5), radius: 1.2, fill: framavert, stroke: none)
          content((2.5, 2.5), text(size: 1em, fill: white, weight: "bold")[*观察*])
          // 箭头：思考 → 行动
          line((cx + 0.85, 5.2), (6.8, 3.4), mark: (end: "stealth"))
          // 箭头：行动 → 观察
          line((6.3, 2.5), (3.7, 2.5), mark: (end: "stealth"))
          // 箭头：观察 → 思考
          line((3.35, 3.4), (cx - 0.85, 5.2), mark: (end: "stealth"))
          // 标签
          content((8.5, 4.3), text(size: 0.8em)[推理下一步])
          content((5.0, 2.0), text(size: 0.8em)[调用工具])
          content((1.5, 4.3), text(size: 0.8em)[工具结果回传])
        })
      ],
      [
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
  ],
  closing: none, // 右栏底部 stat 双格即页面收束
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
  closing: none, // 右栏 boitefilled 洞察卡已收束
)

// ---------- 第 5 页 · framaviolet ----------

== 观察空间与动作空间

#body-slide(
  kicker: [模型与世界之间，隔着观察与动作两个接口],
  inner: [
    - 很多「模型不够聪明」的问题，其实是接口设计问题 —— 改变观察与动作空间往往比换模型更立竿见影
    #v(gap-primary)
    #cmp-grid(
      lhs: (title: [观察空间], color: framableu),
      rhs: (title: [动作空间], color: framaorange),
      label-width: 4.2em,
      rows: (
        (label: [内容], left: [上下文窗口、知识库、记忆], right: [工具调用、代码生成、API]),
        (label: [模态], left: [文本、语音、视觉、传感器], right: [文字、语音、点击、运动]),
        (label: [时机], left: [轮询、推送、事件驱动], right: [同步、异步、抢占]),
        (label: [边界], left: [信息粒度、访问权限], right: [权限最小化、安全限制]),
      ),
    )
  ],
  closing: boitefilled[*Agent 的能力 = 模型能力 × 接口设计*],
)

// ---------- 第 6 页 · framaviolet → framableu ----------

== 五类工具

#body-slide(
  kicker: [Agent 改变世界的五种途径],
  inner: [
    #stretch-grid(
      columns: 3,
      row-gutter: gutter-tight,
      column-gutter: gutter-primary,
      boitebleue(stretch: true)[
        *感知工具* — 获取信息
        搜索 · 文件 · API · 数据库
      ],
      boiteverte(stretch: true)[
        *执行工具* — 改变世界
        代码 · 文件操作 · 系统命令
      ],
      boiteviolette(stretch: true)[
        *协作工具* — 驱动他人
        委托子 Agent · 请求人工确认
      ],
      boitejaune(stretch: true)[
        *事件触发工具* — 外部驱动
        邮件 · 定时 · Webhook
      ],
      boitegrise(stretch: true)[
        *用户沟通工具* — 与用户互动
        文字 · 语音 · 邮件 · 通知
      ],
    )
  ],
  closing: note[工具分类的关键特征：调用方向（谁发起）× 作用对象（作用于什么）],
)

#slide-accent(framableu)

// ---------- 第 7 页 · framableu ----------

== 工具调用流程

#body-slide(
  kicker: [声明 → 决策 → 执行 → 回传，四步一个闭环],
  inner: [
    #flow-steps(
      (title: [工具声明], desc: [名称 + 描述 + JSON Schema 参数格式], color: framableu),
      (title: [模型决策], desc: [根据上下文选工具并生成参数], color: framavert),
      (title: [执行], desc: [Harness 校验参数 → 调用接口 → 捕获结果], color: framaorange),
      (title: [结果回传], desc: [执行结果写入轨迹，供下一轮推理使用], color: framaviolet),
    )
  ],
  closing: note[天气示例：「今天北京下雨吗」→ 查声明 → `call("北京")` →「小雨，带把伞」],
)

// ---------- 第 8 页 · framableu ----------

== Harness 五要素

#body-slide(
  kicker: [生产级 Agent 的工程骨架 —— 模型之外的竞争力],
  gap: 0pt, // 公式两行即 keyline 后的主节奏，不再额外撑距
  inner: [
    #align(center)[
      #text(size: 15.5pt, weight: "bold", fill: framagrisdark)[$"Agent" = "Model" + "Harness"$]
    ]
    #align(center)[
      #text(size: 12.5pt, weight: "bold", fill: framableu)[$"Harness" = "上下文管理" + "工具接口" + "约束" + "验证" + "纠正"$]
    ]
    #v(gap-secondary)
    #stretch-grid(
      columns: 3,
      row-gutter: gutter-tight,
      column-gutter: gutter-tight,
      boitebleue(stretch: true)[*Context* — 信息要充分：提示词、知识库、Sidecar],
      boiteverte(stretch: true)[*Tools* — 命名直观、参数有例（MCP 协议）],
      boiterouge(stretch: true)[*Constrain* — 故障安全默认值，显式开放],
      boiteorange(stretch: true)[*Verify* — 只看结构化数据，防提示注入],
      boitejaune(stretch: true)[*Correct* — 静默重试、熔断、回退人工],
    )
  ],
  closing: note[生产系统从「能做事」转向「可靠地做事」——约束 + 验证 + 纠正正是关键],
)

// ---------- 第 9 页 · framableu → framaorange ----------

== 范式演进

#body-slide(
  kicker: [层层包含而非替代：提示 → 上下文 → Harness → Loop → Graph], // 一轮时两行换页，压成一行换页高
  gap: 0pt, // 纵向五步时间线偏高一档：kicker 后收紧，把空间让给时间线
  closing-gap: 0pt, // 同左：收尾实证卡前不留额外缝隙
  inner: [
    #flow-steps(
      dir: "col",
      row-gap: 0pt, // 五步纵向排列：降行距换页高（溢出页二三轮收紧）
      (title: [提示工程], desc: [优化自然语言指令], color: framableu),
      (title: [上下文工程], desc: [系统性管理模型所见], color: framavert),
      (title: [Harness 工程], desc: [上下文+工具+约束+验证+纠正], color: framaorange),
      (title: [Loop 工程], desc: [跨轮次自主运转], color: framaviolet),
      (title: [Graph 工程], desc: [节点=Agent/程序/人工], color: framajaune),
    )
  ],
  closing: note[*实证* 模型没变，换的是 Harness —— 52.8% → 66.5%（前 5）],
)

#slide-accent(framaorange)

// ---------- 第 10 页 · framaorange ----------

== 构建原则

#body-slide(
  kicker: [保持简单 · 保持透明 · 防呆式 ACI],
  inner: [
    #stretch-grid(
      columns: 3,
      gutter: gutter-primary,
      boiteverte(stretch: true)[
        *防呆式 ACI*
        用设计消除错误，而非事后补救；
        不存在「用户误操作」。
      ],
      boitebleue(stretch: true)[
        *模型即 Agent*
        RL 把工具调用内化为原生能力；
        从「外挂提示」到「原生能力」。
      ],
      boiteorange(stretch: true)[
        *最小闭环先行*
        先跑通一个任务，
        再扩展观察与动作空间。
      ],
    )
  ],
  closing: note[全书路线：上下文（§2–3）→ 工具（§4–5）→ 交互（§6）→ 评估（§7）→ 后训练（§8）→ 进化（§9）→ 协作（§10）],
)

// 收尾：把强调色还给默认 framableu
#slide-accent(framableu)