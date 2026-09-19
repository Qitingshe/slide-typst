// chapters/ch03.typ - 第 3 章 记忆与知识库
// 强调色：framaviolet（紫），记忆是上下文跨会话延续的基础
#import "../lib.typ": *

#section-open(
  index: [3],
  title: [记忆与知识库],
  subtitle: [跨会话记住用户、接入外部知识],
  color: framaviolet,
)

// ---------- 第 1 页 · framaviolet ----------

== 用户记忆

#body-slide(
  kicker: [记住用户，是 Agent 聪明的第一步],
  inner: [
    - 用户记忆：偏好与历史跨会话保留
    - 记忆分级与按需召回：短期 / 长期 / 事实 / 偏好
    - 授权与隐私边界：只有被允许的信息才可被记住与使用
    - 一致性：记住之后要「用得上、用得对」
    - 实验 3-1：Session 粒度短程记忆实现
  ],
  closing: boitefilled[记忆 = 上下文的跨会话延续],
)

// ---------- 第 2 页 · framaviolet ----------

== 知识库与检索增强

#body-slide(
  kicker: [外部知识：补上训练截止与领域私域的空白],
  inner: [
    - RAG 流水线：切分 → 嵌入 → 检索 → 生成
    - 检索质量决定回答上限与时效
    - 结构化索引 / 知识图谱：实体与关系建模，支撑多跳推理
    - 知识库更新：与外部数据源同步，保持新鲜
    - 实验 3-2：Mini-RAG 流水线搭建
  ],
  closing: note[记忆管用户，知识库管世界——二者共同构成观察通道],
)