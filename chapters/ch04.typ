// chapters/ch04.typ - 第 4 章 工具
// 强调色：framaorange（继承自 ch03）；结尾交还 framableu 给 ch05。
#import "../lib.typ": *

// ---------- 第 1 页 · 强调色 framaorange（继承）----------

== 第 4 章 · 五类工具

#keyline[工具是 Agent 改变世界的双手]

#v(0.3em)

#grid(
  columns: (1fr, 1fr),
  row-gutter: 0.6em,
  column-gutter: 0.8em,
  boitebleue[*感知* 搜索 / 文件 / API / 数据库 —— 访问信息],
  boiteverte[*执行* 代码 / 文件操作 / 系统命令 —— 决策变行动],
  boiteviolette[*协作* 委托子 Agent / 请求人工确认 / 多 Agent 协调],
  boitejaune[*事件* 邮件 / 定时 / Webhook —— 外部输入驱动启动],
  boitegrise[*沟通* 文字 / 语音 / 邮件 —— 与用户互动],
)

#v(0.3em)

#note[事件触发类归入广义工具：让外部世界主动来找 Agent]

// ---------- 第 2 页 · 强调色 framaorange ----------

== 第 4 章 · 工具调用流程

#keyline[声明 → 决策 → 执行 → 回传，四步一个闭环]

#v(0.3em)

- 工具声明：名称、描述、参数格式（JSON Schema）
- 模型决策：根据上下文选择工具并产出参数
- Harness 执行：校验参数、调用真实接口
- 结果回传：执行结果写回轨迹，供下一轮推理

#v(0.4em)

#note[例：天气工具——「今天北京下雨吗」→ 查声明 → call(北京) → 「小雨，带把伞」]

// ---------- 第 3 页 · 强调色 framaorange ----------

== 第 4 章 · MCP 与工具设计

#keyline[统一协议 + 明确职责 = 可扩展的工具生态]

#v(0.3em)

- MCP（Model Context Protocol）：统一「模型 ↔ 工具」接口，一次接入、处处复用
- 高风险操作（支付 / 删除 / 投产）封装为专用工具 + 审计 + 人工确认
- 安全边界：权限最小化、可追溯

#v(0.3em)

#boitefilled[通用工具好探索，专用工具保安全]

// 下一页强调色：本页末尾收尾声明（衔接 ch05）
#slide-accent(framableu)