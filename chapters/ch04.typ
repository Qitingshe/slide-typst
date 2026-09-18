// chapters/ch04.typ - 第 4 章 工具
//
// ==== v2 章节约定（其他章节照此改写）====
// 1. 章首用一张 section-open 开场页，并在这里声明本章的强调色与面包屑：
//      #section-open(index: [4], title: [工具], subtitle: [...], color: framaorange)
//    - index 为书章节序号（内容分段省略 index）。
//    - color 会自动写入 accent-state，之后本页/本章的 keyline、stat、
//      boitefilled、页眉紧凑标题都自动沿用该色。
//    - 面包屑自动生成为「第 4 章 · 工具」，显示在内页右上角。
// 2. `==` 标题只写「主题」，不再重复「第 4 章 ·」前缀（前缀已进开场页与面包屑）。
// 3. 章节之间不再需要 #slide-accent(...) 交接色：下一章的 section-open 会自行声明。
// 4. 切记：section-open 必须紧跟在 `=` 之后、本章第一个 `==` 之前，且放在
//    `==` 标题之前不要写 #slide-accent(...)（会凭空多出一页）。
#import "../lib.typ": *

// ---------- 第 4 章 开场页（独立干净页，无页眉/页脚）----------
#section-open(
  index: [4],
  title: [工具],
  subtitle: [工具是 Agent 的双手：五类工具与 MCP 接入],
  color: framaorange,
)

// ---------- 第 1 页 · 强调色 framaorange ----------

== 五类工具

#keyline[工具是 Agent 改变世界的双手]

#v(0.3em)

#stretch-grid(
  columns: 2,
  row-gutter: 0.6em,
  column-gutter: 0.8em,
  boitebleue(stretch: true)[*感知* 搜索 / 文件 / API / 数据库 —— 访问信息],
  boiteverte(stretch: true)[*执行* 代码 / 文件操作 / 系统命令 —— 决策变行动],
  boiteviolette(stretch: true)[*协作* 委托子 Agent / 请求人工确认 / 多 Agent 协调],
  boitejaune(stretch: true)[*事件* 邮件 / 定时 / Webhook —— 外部输入驱动启动],
  boitegrise(stretch: true)[*沟通* 文字 / 语音 / 邮件 —— 与用户互动],
)

#v(0.3em)

#note[事件触发类归入广义工具：让外部世界主动来找 Agent]

// ---------- 第 2 页 · 强调色 framaorange ----------

== 工具调用流程

#keyline[声明 → 决策 → 执行 → 回传，四步一个闭环]

#v(0.3em)

- 工具声明：名称、描述、参数格式（JSON Schema）
- 模型决策：根据上下文选择工具并产出参数
- Harness 执行：校验参数、调用真实接口
- 结果回传：执行结果写回轨迹，供下一轮推理

#v(0.4em)

#note[例：天气工具——「今天北京下雨吗」→ 查声明 → call(北京) → 「小雨，带把伞」]

// ---------- 第 3 页 · 强调色 framaorange ----------

== MCP 与工具设计

#keyline[统一协议 + 明确职责 = 可扩展的工具生态]

#v(0.3em)

- MCP（Model Context Protocol）：统一「模型 ↔ 工具」接口，一次接入、处处复用
- 高风险操作（支付 / 删除 / 投产）封装为专用工具 + 审计 + 人工确认
- 安全边界：权限最小化、可追溯

#v(0.3em)

#boitefilled[通用工具好探索，专用工具保安全]

// 下一章强调色由 ch05 的 section-open 自行声明，这里不再交接。