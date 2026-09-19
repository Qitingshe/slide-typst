// chapters/ch10.typ - 第 10 章 多 Agent 协作
// 强调色：framaviolet（紫），多 Agent 协作是全书终点，也是下一站起点
#import "../lib.typ": *

#section-open(
  index: [10],
  title: [多 Agent 协作],
  subtitle: [群体智能高于个体],
  color: framaviolet,
)

// ---------- 第 1 页 · framaviolet ----------

== 协作框架

#body-slide(
  kicker: [好团队胜过单个超人],
  inner: [
    - 协作框架：主从委派 / 对等协商
    - 任务分解与结果聚合
    - 共享内存与消息机制传递状态
    - 实验 10-1：主从委派模式实现
  ],
  closing: note[Loop / Graph 编排的自然延伸],
)

// ---------- 第 2 页 · framaviolet ----------

== 上下文共享与隔离

#body-slide(
  kicker: [共享提升协同，隔离收窄安全边界],
  inner: [
    - 何时共享：需要一致信息的协作任务
    - 何时隔离：权限收窄、风险隔离
    - 治理：按需授予、审计追踪
  ],
  closing: boitefilled[共享与隔离是一对需要权衡的工程参数],
)

// ---------- 第 3 页 · framaviolet ----------

== Agent 社会

#body-slide(
  kicker: [从协作系统，到涌现有组织的 Agent 社会],
  inner: [
    - 斯坦福 AI 小镇：记忆、反思、计划驱动的生成式个体
    - TalkAct 双 Agent 架构：边操作电脑边与用户沟通（实验）
    - 多 Agent 协作是全书终点，也是下一站起点
  ],
)