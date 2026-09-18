// chapters/ch10.typ - 第 10 章 多 Agent 协作
#import "../lib.typ": *

// ==== v2 章节约定（其他章节照此改写）====
// 1. 章首用一张 section-open 开场页，并在这里声明本章的强调色与面包屑：
//      #section-open(index: [10], title: [多 Agent 协作], subtitle: [...], color: framaviolet)
//    - index 为书章节序号（内容分段省略 index）。
//    - color 会自动写入 accent-state，之后本页/本章的 keyline、stat、
//      boitefilled、页眉紧凑标题都自动沿用该色。
//    - 面包屑自动生成为「第 10 章 · 多 Agent 协作」，显示在内页右上角。
// 2. `==` 标题只写「主题」，不再重复「第 N 章 ·」前缀（前缀已进开场页与面包屑）。
// 3. 章节之间不再需要 #slide-accent(...) 交接色：下一章的 section-open 会自行声明。
// 4. 切记：section-open 必须紧跟在 `=` 之后、本章第一个 `==` 之前，且放在
//    `==` 标题之前不要写 #slide-accent(...)（会凭空多出一页）。

// ---------- 第 10 章 开场页（独立干净页，无页眉/页脚）----------
#section-open(
  index: [10],
  title: [多 Agent 协作],
  subtitle: [群体智能高于个体],
  color: framaviolet,
)

// ---------- 第 1 页 · 强调色 framaviolet ----------

== 协作框架

#body-slide(
  kicker: [好团队胜过单个超人],
  inner: [
    - 协作框架：主从委派 / 对等协商
    - 任务分解与结果聚合
    - 共享内存与消息机制传递状态
  ],
  closing: note[Loop / Graph 编排的自然延伸],
)

// ---------- 第 2 页 · 强调色 framaviolet ----------

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

// ---------- 第 3 页 · 强调色 framaviolet ----------

== Agent 社会

#body-slide(
  kicker: [从协作系统，到涌现有组织的 Agent 社会],
  inner: [
    - 斯坦福 AI 小镇：记忆、反思、计划驱动的生成式个体
    - TalkAct 双 Agent 架构：边操作电脑边与用户沟通（实验）
    - 多 Agent 协作是全书终点，也是下一站起点
  ],
)

// 后续分段强调色由各分段文件的 section-open 自行声明，这里不再交接。