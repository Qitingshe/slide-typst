// chapters/ch02.typ - 第 2 章 上下文工程
// 强调色：framableu（蓝），上下文是 Agent 能力的基础
#import "../lib.typ": *

#section-open(
  index: [2],
  title: [上下文工程],
  subtitle: [上下文决定能力上限：静态前缀 + 轨迹],
  color: framableu,
)

// ---------- 第 1 页 · framableu ----------

== 上下文的决定作用

#body-slide(
  kicker: [没有上下文，模型只知道「世界的一般规律」，不知道「你的问题」],
  inner: [
    - 上下文是指每次调用时模型实际「看到」的全部信息
    - 上下文的设计与管理称为*上下文工程（Context Engineering）*
    - 一个设计精良的上下文 = 高效的信息供给系统
    #v(gap-primary)
    #term-rows(
      label-width: 5.6em,
      rows: (
        (label: [编码助手], value: [无代码库结构 → 写出的代码风格不匹配项目], color: framableu),
        (label: [客服 Agent], value: [无业务规则 → 无法处理具体投诉], color: framableu),
        (label: [研究助手], value: [无领域知识 → 回答空泛或错误], color: framableu),
        (label: [翻译 Agent], value: [无术语表 → 全书术语不一致], color: framableu),
      ),
    )
  ],
  closing: note[上下文决定能力上限 —— 比提示工程更根本],
)

// ---------- 第 2 页 · framableu ----------

== 上下文的结构

#body-slide(
  kicker: [上下文 = 静态前缀 + 轨迹],
  inner: [
    #stretch-grid(
      columns: 2,
      gutter: gutter-primary,
      boitebleue(stretch: true)[
        #align(center)[*静态前缀*（每次调用不变）]
        - 系统提示词：身份 / 权限 / 行为准则
        - 工具定义：名称 / 描述 / 参数格式
      ],
      boiteorange(stretch: true)[
        #align(center)[*动态轨迹*（随交互增长）]
        - 用户消息（可注入 RAG 知识）
        - 模型回复 + 工具执行结果
      ],
    )
    #v(gap-secondary)
    - KV Cache 缓存已见 token 的键值，避免重复预填充——静态前缀越长，缓存收益越大
    - 消息的四种角色：system / user / assistant / tool
  ],
  closing: note[上下文 = 每次调用拼接后的完整输入],
)

// ---------- 第 3 页 · framableu ----------

== 从提示工程到上下文工程

#body-slide(
  kicker: [上下文决定能力上限：系统性地管理模型看到的一切],
  inner: [
    - 从「怎么问」到「让模型看到什么」：上下文质量优先于措辞技巧
    - Skills / Sidecar / RAG 按需供料：优先级与令牌预算决定什么进、什么剪
    #v(gap-primary)
    #cmp-grid(
      lhs: (title: [提示工程], color: framagris),
      rhs: (title: [上下文工程], color: framableu),
      label-width: 4.6em,
      rows: (
        (label: [关注点], left: [指令措辞], right: [信息供给系统]),
        (label: [范围], left: [单次 Prompt], right: [全生命周期信息流]),
        (label: [工具], left: [少样本示例], right: [Skills + Sidecar + RAG]),
        (label: [目标], left: [模型理解指令], right: [模型获得正确信息]),
        (label: [关系], left: [—], right: [提示工程 ⊂ 上下文工程]),
      ),
    )
  ],
  closing: note[提示工程 ⊂ 上下文工程],
)

// ---------- 第 4 页 · framableu ----------

== KV Cache 与性能

#body-slide(
  kicker: [缓存让重复上下文「零成本」],
  inner: [
    - *KV Cache*：缓存已见 token 的键值对，避免每次调用重新计算
    - 静态前缀（系统提示词 + 工具定义）被缓存后，后续调用只需处理新增轨迹
    - 长静态前缀时，缓存收益巨大
    #v(gap-primary)
    #stretch-grid(
      columns: 3,
      gutter: gutter-tight,
      boitegrise(stretch: true)[
        *不加缓存*
        #v(0.25em) // 卡内换行留白
        延迟随上下文线性增长
        #v(0.25em) // 卡内换行留白
        适合：短对话、轮次少
      ],
      boitebleue(stretch: true)[
        *前缀缓存*
        #v(0.25em) // 卡内换行留白
        延迟固定只算新增
        #v(0.25em) // 卡内换行留白
        适合：长系统提示词 + 多轮交互
      ],
      boiteverte(stretch: true)[
        *分层缓存*
        #v(0.25em) // 卡内换行留白
        只重建失效部分
        #v(0.25em) // 卡内换行留白
        适合：动态切换角色与 Skill 的 Agent
      ],
    )
  ],
  closing: boitefilled[上下文是根：一切 Agent 能力都长在它上面],
)

// ---------- 第 5 页 · framableu ----------

== 长程任务与压缩

#body-slide(
  kicker: [轨迹越长，越需要工程化治理],
  inner: [
    - 上下文压缩三路径：*摘要* 用新 token 压缩旧历史；*丢弃* 选择性遗忘；*检索注入* 按需取用
    #v(gap-primary)
    #stretch-grid(
      columns: 3,
      gutter: gutter-tight,
      boiteverte(stretch: true)[
        *摘要压缩*
        将旧历史压缩为一段摘要
        适合：对话历史太长、关键信息可概括
      ],
      boiteorange(stretch: true)[
        *选择性丢弃*
        丢弃不再需要的中间步骤
        适合：工具调用结果、调试日志
      ],
      boitebleue(stretch: true)[
        *检索注入*
        从外部存储按需召回
        适合：长程任务中阶段性结果
      ],
    )
    #v(gap-primary)
    - 语境与遗忘：旧信息何时该让位——衔接第 3 章记忆管理
  ],
  closing: boitefilled[没有上下文就没有 Agent —— 它是构造 Agent 的起点],
)
