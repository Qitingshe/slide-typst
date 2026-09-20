// chapters/ch01.typ - 第 1 章 AI Agent 入门
// 强调色：framableu（蓝），贯穿本章五页
// 差异化（相对 core）：core 用 cmp-grid 做「观察×动作」维度对照，ch01 改用
// 「定义双卡 + 洞察 bullets」；构建原则 core 用三列等高卡，ch01 用编号时间线。
#import "../lib.typ": *

#section-open(
  index: [1],
  title: [AI Agent 入门],
  subtitle: [Agent = LLM + 上下文 + 工具，Harness 是竞争力],
  color: framableu,
)

// ---------- 第 1 页 · framableu ----------

== 产品实证

#body-slide(
  kicker: [五个代表产品，共享同一副 Agent 骨架],
  inner: [
    #stretch-grid(
      columns: 3,
      row-gutter: gutter-tight,
      column-gutter: gutter-primary,
      boitebleue(stretch: true)[*Cursor* 编程助手：开放式工作流与代码操作],
      boiteverte(stretch: true)[*Deep Research* 长程研究：检索、综合、成文],
      boiteorange(stretch: true)[*Manus* 全能执行：拆解任务、调用工具],
      boiteviolette(stretch: true)[*豆包* 大规模智能客服],
      boitemarron(stretch: true)[*游戏 NPC* 嵌入式交互角色],
      boitejaune(stretch: true)[*Pine AI* Agent 协作：共同完成任务],
    )
  ],
  closing: note[共同特征：开放式动作空间 · 内部思考 · 持续交互],
)

// ---------- 第 2 页 · framableu ----------

== 现代 Agent 的定义

#body-slide(
  kicker: [Agent = LLM + 上下文 + 工具 —— 最小工程实现],
  inner: [
    #stretch-grid(
      columns: 2,
      row-gutter: gutter-tight,
      column-gutter: gutter-primary,
      boitebleue(stretch: true)[
        *LLM 是大脑*
        - 理解意图、思考规划、判断决策
        - 来自预训练的世界知识 + 后训练固化策略
      ],
      boiteverte(stretch: true)[
        *上下文是眼睛*
        - 模型看到的全部信息
        - 系统提示词 + 对话历史 + 工具描述
      ],
      boiteorange(stretch: true)[
        *工具是手脚*
        - 感知与执行接口
        - MCP 协议统一接入
        - 装备在 Harness：工具接口 + MCP 适配器
      ],
      boiteviolette(stretch: true)[
        *Environment 在公式之外*
        - Agent 通过观察/动作接口交互
        - 环境包括文件、数据库、用户、物理世界
      ],
    )
  ],
  closing: note[公式的加号 = 工程组件的组合；Harness = 上下文管理 + 工具接口 + 约束 + 验证 + 纠正],
)

// ---------- 第 3 页 · framableu ----------

== 观察与动作空间

#body-slide(
  kicker: [模型与世界之间，隔着观察与动作两个接口],
  inner: [
    #stretch-grid(
      columns: 2,
      gutter: gutter-primary,
      boitebleue(stretch: true)[
        #align(center)[*观察空间*]
        - 模型每个决策点能看到的信息
        - 扩展：上下文工程、记忆、知识库
      ],
      boiteorange(stretch: true)[
        #align(center)[*动作空间*]
        - Agent 允许执行的操作集合
        - 扩展：工具设计、代码生成、交互模态
      ],
    )
    #v(gap-primary)
    - *改哪个更划算？* 信息不全或噪音过多 → 治观察；操作受限或找不到工具 → 治动作。两者往往比换模型更立竿见影
    - Model–Harness 结构：Model 做决策；Harness 构造上下文、暴露工具并实施治理（约束 / 验证 / 纠正）
  ],
  closing: boitefilled[接口设计常被低估 —— 它与模型同等决定 Agent 的能力上限],
)

// ---------- 第 4 页 · framableu ----------

== 构建原则与全书路线

#body-slide(
  kicker: [保持简单 · 保持透明 · 防呆式 ACI],
  inner: [
    #flow-steps(
      dir: "col",
      (title: [防呆式 ACI], desc: [用设计消除错误，而非事后补救；不存在「用户误操作」], color: framavert),
      (title: [模型即 Agent], desc: [RL 把工具调用内化为原生能力（§8 展开）], color: framableu),
      (title: [最小闭环先行], desc: [先跑通一个任务，再扩展观察与动作空间], color: framaorange),
    )
    #v(gap-primary)
    - 实验 1-1：消融上下文各要素 —— 缺提示词 → 风格跑偏；缺工具定义 → 零调用；缺结果 → 盲目重试
  ],
  closing: note[先跑通最小闭环，再逐步扩展 —— 迭代式构建 Agent 的最佳实践],
)