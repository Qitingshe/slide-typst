// chapters/engineering.typ - 工程要点（Harness 五要素 / 范式演进 / 全书数据与阅读路径）
// 强调色走位：framableu → framaorange → framaviolet
// 设计定位（与 core 的差异化分工）：engineering 是「工程总结」——同类素材用与
// core 不同的构图与提炼：Harness 走横向流程条（core 是公式 + 五色卡）、范式
// 演进走横向压缩版（core 是纵向时间线带主导者）、全书数据用色点图例而非表格。
#import "../lib.typ": *

#section-open(
  title: [工程要点],
  subtitle: [从公式到生产：Harness 五要素与范式演进],
  color: framableu,
)

// ---------- 第 1 页 · framableu ----------

== Harness 五要素

#body-slide(
  kicker: [生产级 Agent 的工程骨架 —— 模型之外的竞争力],
  inner: [
    #flow-steps(
      (title: [Context], desc: [信息要充分：提示词、知识库、Sidecar], color: framableu),
      (title: [Tools], desc: [命名直观、参数有例（MCP 协议）], color: framavert),
      (title: [Constrain], desc: [故障安全默认值，显式开放], color: framarouge),
      (title: [Verify], desc: [只看结构化数据，防提示注入], color: framaorange),
      (title: [Correct], desc: [静默重试、熔断、回退人工], color: framajaune),
    )
  ],
  closing: note[行业转向：从「能做事」转向「可靠地做事」——约束 + 验证 + 纠正正是关键],
)

// ---------- 第 2 页 · framableu ----------

== 工具调用与 MCP

#body-slide(
  kicker: [工具是 Agent 改变世界的手段 —— 协议统一是生态繁荣的前提],
  inner: [
    #stretch-grid(
      columns: 2,
      gutter: gutter-primary,
      boitebleue(stretch: true)[
        *工具调用四步*
        声明（JSON Schema）
        → 决策（模型选工具）
        → 执行（Harness 校验 + 调用）
        → 回传（结果写轨迹）
      ],
      boiteverte(stretch: true)[
        *MCP 协议价值*
        一次接入、处处复用
        标准化安全审计
        社区共享工具生态
      ],
    )
  ],
  closing: note[实验 4-1：MCP 工具搭建与调用 —— 高风险操作（支付 / 删除 / 投产）封装为专用工具 + 审计 + 人工确认],
)

#slide-accent(framaorange)

// ---------- 第 3 页 · framaorange ----------

== 范式演进

#body-slide(
  kicker: [层层包含，不是替代 —— 提示 → 上下文 → Harness → Loop → Graph],
  inner: [
    #flow-steps(
      (title: [提示工程], desc: [优化自然语言指令], color: framableu),
      (title: [上下文工程], desc: [管理模型看到的一切], color: framavert),
      (title: [Harness 工程], desc: [上下文 + 工具 + 约束 + 验证 + 纠正], color: framaorange),
      (title: [Loop 工程], desc: [跨轮次持续自主运转], color: framaviolet),
      (title: [Graph 工程], desc: [显式执行图：节点 / 边 = 依赖与路由], color: framajaune),
    )
  ],
  closing: boitebleue[
    *实证* LangChain 在 Terminal Bench 2.0 上从 52.8% 提到 66.5%（30 名开外 → 前 5）。
    模型没变，换的是 Harness。
  ],
)

// ---------- 第 4 页 · framaorange → framaviolet ----------

== 全书数据概览

#body-slide(
  kicker: [10 章 · 109 实验 · 从 LLM 基础到多 Agent 社会],
  gap: 0pt, // 大数字 + 十章色点偏高：kicker 后收紧
  closing-gap: 0pt, // 同左：收尾附注前不留额外缝隙
  inner: [
    #stretch-grid(
      columns: 3,
      row-gutter: gutter-tight,
      column-gutter: gutter-tight,
      stat(amount-size: 27pt, color: framableu, stretch: true, [10], [章节]),
      stat(amount-size: 27pt, color: framavert, stretch: true, [109], [配套实验]),
      stat(amount-size: 27pt, color: framaorange, stretch: true, [15], [编程语言]),
    )
    #v(0.1em) // 大数字→章色点的段间留白收紧（溢出页二轮）
    #chapter-dots(
      row-gutter: 0.25em, // 十章两行收紧（溢出页二轮）
      (n: [1], name: [入门], desc: [LLM+上下文+工具], color: framableu),
      (n: [2], name: [上下文], desc: [静态前缀+轨迹], color: framableu),
      (n: [3], name: [记忆], desc: [用户记忆+RAG], color: framaviolet),
      (n: [4], name: [工具], desc: [五类工具+MCP], color: framavert),
      (n: [5], name: [Coding], desc: [Coding Agent], color: framableu),
      (n: [6], name: [交互], desc: [语音+电脑使用], color: framavert),
      (n: [7], name: [评估], desc: [评估环境与指标], color: framaviolet),
      (n: [8], name: [后训练], desc: [SFT vs RL], color: framaorange),
      (n: [9], name: [进化], desc: [四层更新], color: framaviolet),
      (n: [10], name: [协作], desc: [多 Agent 协作], color: framaviolet),
    )
  ],
  closing: note[色点即各章强调色 —— 翻开对应章节，页眉主题条会以同色出现],
)

#slide-accent(framaviolet)

// ---------- 第 5 页 · framaviolet ----------

== 阅读路径

#body-slide(
  kicker: [不同读者，不同路线 —— 从入门到高阶的推荐路径],
  inner: [
    #stretch-grid(
      columns: 2,
      gutter: gutter-primary,
      boiteverte(stretch: true)[
        *新入门*
        §1 打基础
        → §2 上下文 + §3 记忆
        → §4 工具 + §5 编码
        → §7 评估
      ],
      boiteorange(stretch: true)[
        *有经验*
        §8 后训练 + 实验
        → §9 持续进化
        → §10 多 Agent 协作
        → §6 交互扩展
      ],
    )
    #v(gap-primary)
    #boitebleue[
      *动手建议*
      - 从实验 1-1 消融开始，亲手验证上下文五要素的权重
      - 用公式对照每个产品：它扩展了哪个观察 / 动作空间？
      - 跑通一章实验 → 沉淀轨迹 → 形成自己的进化闭环
    ]
  ],
  closing: note[全开源 · 10 章 · 109 实验 · 15 语言 · github.com/bojieli/ai-agent-book],
)