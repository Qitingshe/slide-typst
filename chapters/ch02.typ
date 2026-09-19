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

== 上下文的结构

#body-slide(
  kicker: [上下文 = 静态前缀 + 轨迹],
  inner: [
    #stretch-grid(
      columns: 2,
      gutter: gutter-primary,
      boitebleue(stretch: true)[
        #align(center)[*静态前缀*]
        - 系统提示词：身份 / 权限 / 行为准则
        - 工具定义：名称 / 描述 / 参数格式
      ],
      boiteorange(stretch: true)[
        #align(center)[*动态轨迹*]
        - 用户消息（可注入 RAG 知识）
        - 模型回复 + 工具执行结果
      ],
    )
    #v(gap-secondary)
    - KV Cache 缓存已见 token 的键值，避免重复预填充——静态前缀越长，缓存收益越大
    - 实验 2-1：消 Kit 上下文各要素——缺提示词 → 答非所问；缺工具描述 → 不调用工具
  ],
  closing: note[上下文 = 每次调用拼接后的完整输入],
)

// ---------- 第 2 页 · framableu ----------

== 从提示工程到上下文工程

#body-slide(
  kicker: [上下文决定能力上限：系统性地管理模型看到的一切],
  inner: [
    - 从「怎么问」到「让模型看到什么」：上下文质量优先于措辞技巧
    - 优先级与令牌预算：什么信息该进、哪些该剪
    - Agent Skills：把可复用能力封装成带教程与示例的技能包
    - Sidecar 旁路查询：不撑爆主窗口，按需注入外部信息
  ],
  closing: note[提示工程 ⊂ 上下文工程],
)

// ---------- 第 3 页 · framableu ----------

== 长程任务与压缩

#body-slide(
  kicker: [轨迹越长，越需要工程化治理],
  inner: [
    - 上下文压缩三路径：摘要 / 丢弃 / 检索注入
    - 长程任务：数小时的自主运行需要令牌预算与记忆管理
    - 语境与遗忘：旧信息何时该让位——衔接第 3 章记忆
  ],
  closing: boitefilled[上下文是根：一切 Agent 能力都长在它上面],
)