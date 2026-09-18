// chapters/tour.typ - 十章速览（全书内容地图，对应原书第 1–10 章）
#import "../lib.typ": *

== 十章地图

#grid(
  columns: (1fr, 1fr),
  row-gutter: 0.45em,
  column-gutter: 1em,
  boitebleue[*§1 AI Agent 入门* —— Agent＝LLM＋上下文＋工具，Harness 是竞争力],
  boiteverte[*§2 上下文工程* —— 上下文决定能力上限：KV Cache、Skills、压缩],
  boiteorange[*§3 记忆与知识库* —— 跨会话记忆、RAG、结构化索引、知识图谱],
  boiteviolette[*§4 工具* —— 五类工具与 MCP 标准接入],
  boitejaune[*§5 Coding Agent* —— 代码是「能创造新工具的工具」],
  boitemarron[*§6 交互扩展* —— 异步事件、语音、Computer Use、机器人],
  boitegrise[*§7 评估* —— 环境、指标、统计显著性、评估驱动选型],
  boitebleue[*§8 模型后训练* —— 预训练 / SFT / RL，内化决策策略],
  boiteverte[*§9 持续进化* —— 轨迹驱动：知识、指令、程序、参数四层更新],
  boiteorange[*§10 多 Agent 协作* —— 协作框架、上下文共享 / 隔离、Agent 社会],
)

== §1 · AI Agent 入门

#boiterouge[
  *核心* Agent = LLM + 上下文 + 工具；模型之外、Agent 边界之内的 Harness 工程才是竞争力
]

- 产品实证：Cursor、Deep Research、Manus、豆包、Pine AI —— 共同特征：开放式动作空间、内部思考、持续交互
- 观察空间与动作空间是模型与世界的接口：很多「模型不够聪明」的问题其实是接口问题
- Model–Harness 结构：Model 做决策；Harness 构造上下文、暴露工具并实施治理
- 模型即 Agent：RL 把工具调用内化为原生能力（Kimi K3、GPT-5.6，展开见 §8）
- 构建原则：保持简单 · 保持透明 · 防呆式 ACI（用设计消除错误）

== §2 · 上下文工程

#boiteverte[
  *核心* 上下文决定能力上限 —— 静态前缀 + 轨迹
]

- API 结构：系统提示词 + 工具定义 = 静态前缀；用户消息 / 模型回复 / 工具结果 = 轨迹
- KV Cache：缓存已见 token 的键值，避免重复预填充计算，是长上下文的关键机制
- 从提示工程到上下文工程：从「怎么问」走向系统性管理模型看到的一切
- Agent Skills：把可复用能力封装成带教程与示例的技能包
- 上下文压缩：摘要、丢弃与检索注入，撑起数小时的长程任务
- Sidecar 旁路查询：不撑爆主窗口，按需注入外部信息

== §3 · 用户记忆和知识库

#boiteorange[
  *核心* 跨会话记住用户、接入外部知识
]

- 用户记忆：偏好与历史跨会话保留；记忆分级、按需召回、需用户授权与隐私边界
- RAG：切分 → 嵌入 → 检索 → 生成；检索质量决定回答上限与时效
- 结构化索引 / 知识图谱：实体与关系建模、多跳推理，回答「关系型」问题
- 知识库更新：与外部数据源同步，弥补模型训练截止与领域私有知识的空白

== §4 · 工具

#boiteviolette[
  *核心* 工具是 Agent 的双手；MCP 让工具接入标准化
]

- 感知工具：搜索 / 文件 / API / 数据库 —— 让 Agent 访问信息
- 执行工具：代码 / 文件操作 / 系统命令 / 外部调用 —— 决策变成行动
- 协作工具：委托子 Agent / 请求人工确认 / 多 Agent 协调
- 事件触发工具：邮件 / 定时 / Webhook —— 外部输入驱动 Agent 启动（归入广义工具）
- 用户沟通工具：文字消息 / 语音 / 邮件
- 设计原则：通用能力用于组合与探索；支付、删除、投产等高风险操作封装专用工具 + 审计 + 人工确认
- MCP（Model Context Protocol）：统一「模型 ↔ 工具」接口，一次接入、处处复用

== §5 · Coding Agent 与通用 Agent

#boitejaune[
  *核心* 代码是「能创造新工具的工具」
]

- 增量开发循环：理解需求 → 搜索相关代码 → 编辑 → 测试 → 调试修复
- 代码解释器 vs 专用工具：受限 Python 沙盒更易组合与探索（读表、清洗、统计、绘图一站式）
- 沙盒安全：默认无网络、路径受限、时间 / CPU / 内存 / 输出上限
- 通用 Agent = Coding + Deep Research + Computer Use 观察 / 动作空间的并集
- 基准：SWE-bench、Terminal Bench 等（评估详见 §7）

== §6 · 交互：观察与动作空间的扩展

#boitemarron[
  *核心* 从模态与时序两个维度扩展 Agent 的观察与动作空间
]

- 异步与事件驱动：长任务后台运行、事件循环、WebSocket 消息通道
- 语音交互：ASR / TTS 管线、实时对话与打断管理
- Computer Use：屏幕截图 → 识别目标元素 → 点击输入 → 验证结果
- 机器人操作：传感器为眼、运动控制为手，sim2real 迁移
- 14 个实验，含外部复现轨道（claude-quickstarts、browser-use、XLeRobot、RoboCrew 等）

== §7 · Agent 的评估

#boitegrise[
  *核心* 把表现变成可比较的信号
]

- 评估环境：SWE-bench、OSWorld、GAIA、Terminal Bench、AndroidWorld……（各覆盖一类 Agent 能力）
- 指标：任务成功率、步骤效率、成本、可靠性 —— 看「任务完成」而非「给出回答」
- 统计显著性：多次运行 + 置信区间，区分真实差异与随机噪声
- 评估驱动选型：模型、工具、编排的取舍必须在自己任务上实测，不要只看排行榜

== §8 · 模型后训练

#boitebleue[
  *核心* 预训练 / SFT / RL 三阶段，把决策策略内化为模型参数
]

- 预训练：海量互联网文本，习得语言规律与世界知识
- SFT：模仿示范行为 —— 数据充分、成本较低、行为可控（何时选 SFT）
- RL：面向决策策略 —— 何时调用工具、调哪个、传什么参数（何时选 RL）
- 工具调用内化 = 模型即 Agent：Kimi K3、GPT-5.6 为代表
- 实验栈：MiniMind 预训练、SFTvsRL、verl / ReTool、RLVP、SimpleVLA-RL（共 19 个实验）

== §9 · Agent 的持续进化

#boiteverte[
  *核心* 从运行轨迹获得学习信号，四层更新
]

- 更新知识：事实与经验沉淀进记忆 / 知识库
- 更新指令：可语言化的策略写进 Prompt / Skill
- 更新程序：确定性流程与约束写进工具与 Harness
- 更新参数：难以显式表达的高维能力交给后训练（§8）
- 三个时间尺度：上下文临场适应 → 外部产物可控积累 → 参数内化

== §10 · 多 Agent 协作

#boiteorange[
  *核心* 群体智能高于个体
]

- 协作框架：主从委派 / 对等协商；任务分解、结果聚合
- 上下文共享与隔离：共享提升协同效率，隔离收窄安全边界 —— 需权限治理
- 涌现的 Agent 社会：斯坦福 AI 小镇 —— 记忆、反思、计划驱动的生成式个体
- 编排视角：Loop / Graph 工程自然延伸至多 Agent 系统
- 实验：TalkAct 双 Agent 架构（边操作电脑边与用户沟通）