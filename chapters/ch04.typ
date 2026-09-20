// chapters/ch04.typ - 第 4 章 工具
// 强调色：framavert（绿），工具是 Agent 改变世界的双手
#import "../lib.typ": *

#section-open(
  index: [4],
  title: [工具],
  subtitle: [五类工具与 MCP 接入],
  color: framavert,
)

// ---------- 第 1 页 · framavert ----------

== 工具的分类

#body-slide(
  kicker: [工具是 Agent 改变世界的双手 —— 五类工具的完整谱系],
  inner: [
    #stretch-grid(
      columns: 3,
      row-gutter: gutter-tight,
      column-gutter: gutter-primary,
      boitebleue(stretch: true)[
        *感知工具* — 主动发起
        对象：获取信息
        例：搜索 / 文件 / API / 数据库
      ],
      boiteverte(stretch: true)[
        *执行工具* — 主动发起
        对象：改变世界
        例：代码 / 文件操作 / 系统命令
      ],
      boiteviolette(stretch: true)[
        *协作工具* — 主动发起
        对象：驱动他人
        例：委托子 Agent / 请求人工确认
      ],
      boitejaune(stretch: true)[
        *事件触发工具* — 外部触发
        对象：驱动 Agent
        例：邮件 / 定时 / Webhook
      ],
      boitegrise(stretch: true)[
        *用户沟通工具* — 主动发起
        对象：与用户互动
        例：文字 / 语音 / 邮件
      ],
      // 第 2 行留空一格（3 列 × 2 行，5 卡自然排布）
    )
  ],
  closing: note[关键特征：调用方向（谁发起）× 作用对象（作用于什么）—— 两个正交维度],
)

// ---------- 第 2 页 · framavert ----------

== 工具设计原则

#body-slide(
  kicker: [好的工具设计 = 命名直观 + 参数清晰 + 行为可预测],
  inner: [
    - *能力的表达形式*：专用工具 vs 通用执行器 vs Skill
    - *工具描述的艺术*：名称 + 描述 + JSON Schema 参数格式
    - *参数传递的保真性*：避免歧义、类型明确
    #v(gap-primary)
    #cmp-grid(
      lhs: (title: [特点], color: framavert),
      rhs: (title: [适用场景], color: framaorange),
      label-width: 5.4em,
      rows: (
        (label: [专用工具], left: [职责单一、参数明确], right: [高确定性操作（支付、查询）]),
        (label: [通用执行器], left: [灵活、可编程], right: [不确定操作（代码执行）]),
        (label: [Skill], left: [组合工具 + 知识 + 约束], right: [复杂领域任务（客服、翻译）]),
      ),
    )
  ],
  closing: note[专用工具保安全，通用执行器保灵活 —— Skill 桥接两者],
)

// ---------- 第 3 页 · framavert ----------

== 工具调用流程

#body-slide(
  kicker: [声明 → 决策 → 执行 → 回传，四步一个闭环],
  inner: [
    #flow-steps(
      dir: "row",
      (title: [工具声明], desc: [名称 + 描述 + JSON Schema 参数格式], color: framavert),
      (title: [模型决策], desc: [选工具并生成参数 · call("北京")], color: framableu),
      (title: [Harness 执行], desc: [校验参数 → 调真实接口 → 捕获结果或错误], color: framaorange),
      (title: [结果回传], desc: [写入轨迹供下一轮推理], color: framaviolet),
    )
    #v(gap-primary)
    - 示例：天气工具 —「今天北京下雨吗」→ 查声明 → `call("北京")` →「小雨，带把伞」
  ],
  closing: note[四步闭环是 Agent 工具调用的最小原子操作],
)

// ---------- 第 4 页 · framavert ----------

== MCP 协议

#body-slide(
  kicker: [统一协议 + 明确职责 = 可扩展的工具生态],
  gap: 0pt, // 对比网格偏高：kicker 后收紧
  closing-gap: 0.1em, // 收尾双行：较默认略紧（溢出页二轮收紧）
  inner: [
    - *MCP*：统一「模型 ↔ 工具」接口
    - 工具生态分发：MCP 协议 + Skill Hub
    #v(0.1em) // 列表→对比网格的段间留白收紧（溢出页二轮）
    #cmp-grid(
      lhs: (title: [使用 MCP], color: framavert),
      rhs: (title: [不使用 MCP], color: framagris),
      label-width: 4.6em,
      row-gap: 0.1em, // 四行对比收紧（溢出页二轮）
      header-gap: 0.13em, // 表头→首行收紧（溢出页二轮）
      rows: (
        (label: [接入新工具], left: [配置一行命令], right: [手动实现封装]),
        (label: [协议标准], left: [统一、可互操作], right: [各自为政、重复劳动]),
        (label: [安全审计], left: [标准化权限声明], right: [临时安全检查]),
        (label: [生态复用], left: [社区共享工具], right: [内部自建、不互通]),
      ),
    )
  ],
  closing: [#boitefilled[通用工具好探索，专用工具保安全] #v(0.05em) // 收尾双行紧凑化（溢出页二轮）
  #note[高风险操作（支付/删除/投产）→ 专用工具 + 审计 + 人工确认 · 实验 4-1]],
)
