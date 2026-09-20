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
  kicker: [好团队胜过单个超人 —— 从协作系统到 Agent 社会],
  inner: [
    - 协作核心维度：上下文是否共享 × 协作拓扑（控制权与信息流动结构）
    - 共享上下文 vs 不共享上下文 —— 信息传递方式的根本选择
    #v(gap-primary)
    #cmp-grid(
      lhs: (title: [共享上下文], color: framaviolet),
      rhs: (title: [不共享上下文], color: framagris),
      label-width: 4.6em,
      rows: (
        (label: [信息传递], left: [继承完整轨迹], right: [通过文件/消息交换]),
        (label: [优势], left: [信息不丢失], right: [模块化、易扩展、可并发]),
        (label: [挑战], left: [上下文快速膨胀], right: [同步与隔离问题]),
        (label: [适用], left: [顺序执行的多角色任务], right: [并行执行的多 Agent 系统]),
      ),
    )
  ],
  closing: note[共享与隔离是一对需要权衡的工程参数],
)

// ---------- 第 2 页 · framaviolet ----------

== 三种协作拓扑

#body-slide(
  kicker: [对等协作 · 管理者模式 · 去中心化 —— 三种拓扑，不同权衡],
  inner: [
    辩论不引入新信息 → 效果有限；执行反馈引入新信息 → 显著提升
  ],
  closing: note[核心判据：协作是否引入了单 Agent 无法获得的新信息？],
)

// ---------- 第 3 页 · framaviolet ----------

== 提议者-审核者范式

#body-slide(
  kicker: [引入独立证据的迭代改进 —— 多 Agent 协作的最经典模式],
  inner: [
    - 提议者（Proposer）生成候选方案
    - 审核者（Reviewer）检查独立证据 —— 不能只复读提议者
    #v(gap-primary)
    #cmp-grid(
      lhs: (title: [审核证据], color: framaviolet),
      rhs: (title: [不能只靠], color: framagris),
      label-width: 4.6em,
      rows: (
        (label: [代码审核], left: [测试执行结果], right: [代码再读一遍]),
        (label: [PPT 生成], left: [渲染截图 + Vision LLM], right: [代码再读一遍]),
        (label: [事实核查], left: [外部工具验证], right: [模型内部知识]),
        (label: [安全审查], left: [策略库 + 权限表], right: [模型自己的判断]),
      ),
    )
  ],
  closing: boitefilled[模型可以提出「完成」，但不能批准自己的「完成」],
)

// ---------- 第 4 页 · framaviolet ----------

== Agent 通信与控制

#body-slide(
  kicker: [Agent 世界与操作系统的类比 —— 健壮的多 Agent 系统需要完善的控制平面],
  inner: [
    #term-rows(
      label-width: 6.5em,
      row-gap: 0.25em,
      rows: (
        (label: [进程内存], value: [轨迹], color: framaviolet),
        (label: [CPU], value: [LLM], color: framaviolet),
        (label: [系统调用], value: [工具调用], color: framaviolet),
        (label: [程序], value: [静态前缀（系统提示词 + 工具定义）], color: framaviolet),
        (label: [fork / kill / ps], value: [spawn / cancel / list], color: framaviolet),
        (label: [共享内存 / 消息], value: [共享文件系统 / 消息总线], color: framaviolet),
      ),
    )
    #v(gap-primary)
    - 虚拟文件系统 · 消息信封
  ],
  closing: note[多 Agent 协作是全书终点，也是下一站起点],
)

// ---------- 第 5 页 · framaviolet ----------

== Agent 社会

#body-slide(
  kicker: [从协作系统，到涌现有组织的 Agent 社会],
  inner: [
    #stretch-grid(
      columns: 2,
      gutter: gutter-primary,
      boitebleue(stretch: true)[
        *斯坦福 AI 小镇*
        记忆、反思、计划驱动的生成式个体
        涌现社交行为
      ],
      boiteverte(stretch: true)[
        *TalkAct 双 Agent*
        边操作电脑边与用户沟通
        实验探索人机协作新范式
      ],
    )
    #v(gap-primary)
    - Google DeepMind《从 AGI 到 ASI》：大规模多 Agent 集体 = 通往超级智能的关键路径
    - 从「专家级 AI」迈向「超越人类整体」的根本路径
  ],
  closing: boitefilled[群体智能 —— 哪怕每个 Agent 只相当于人类专家，组织得当也能超越个体总和],
)
