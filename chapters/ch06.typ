// chapters/ch06.typ - 第 6 章 交互扩展
// 强调色：framavert（绿），交互扩展观察与动作空间的维度
#import "../lib.typ": *

#section-open(
  index: [6],
  title: [交互扩展],
  subtitle: [从模态与时序两个维度扩展观察与动作空间],
  color: framavert,
)

// ---------- 第 1 页 · framavert ----------

== 模态与时序

#body-slide(
  kicker: [观察与动作沿「模态 × 时机」两个维度扩展],
  inner: [
    #cmp-grid(
      lhs: (title: [观察空间扩展], color: framavert),
      rhs: (title: [动作空间扩展], color: framaorange),
      label-width: 4.6em,
      rows: (
        (label: [内容], left: [上下文工程、记忆与知识库], right: [工具、代码生成]),
        (label: [模态], left: [语音、屏幕、物理传感器], right: [说话、点击、关节运动]),
        (label: [时机], left: [世界主动推送、连续流], right: [跨回合、可打断、可抢占]),
      ),
    )
    #v(gap-primary)
    - 模态轴：文本 → 语音 → 图像/视频 → 触觉
    - 时序轴：同步一问一答 → 异步后台 → 事件驱动
  ],
  closing: note[回合制是模型与接口的一种交互约定，不是环境的性质],
)

// ---------- 第 2 页 · framavert ----------

== 异步与事件驱动

#body-slide(
  kicker: [当世界主动找上门：从轮询到推送],
  inner: [
    - *为什么需要异步*：真实环境不会等模型作出反应
    - 邮件在它思考时到达，用户在它说到一半时插话
    - *事件触发工具*：Agent 注册 → 外部触发 → 驱动执行
    #v(gap-primary)
    #stretch-grid(
      columns: 2,
      gutter: gutter-primary,
      boiteverte(stretch: true)[
        *异步场景*
        - 长任务后台运行
        - WebSocket 实时消息通道
        - 定时任务与批处理
      ],
      boiteorange(stretch: true)[
        *事件驱动机制*
        - 事件注册 + 监听
        - 消息队列缓冲
        - 多优先级调度
      ],
    )
    - GPT-6 Astra 已提供原生异步工具调用和回合中途追加指令
  ],
  closing: note[世界不会等模型 —— 从轮询到推送是 Agent 走向真实环境的必修课],
)

// ---------- 第 3 页 · framavert ----------

== 语音与 Computer Use

#body-slide(
  kicker: [会听会说，还能「看着屏幕操作」],
  inner: [
    - *语音交互*：ASR / TTS 管线、实时对话与打断管理
    - *Computer Use*：屏幕截图 → 识别目标元素 → 点击输入 → 验证结果
    #v(gap-primary)
    #cmp-grid(
      lhs: (title: [观察能力], color: framavert),
      rhs: (title: [动作能力], color: framaorange),
      label-width: 4.2em,
      rows: (
        (label: [文本], left: [读取代码、文档], right: [生成文字、调用 API]),
        (label: [语音], left: [听用户说话、ASR], right: [TTS 回复]),
        (label: [视觉], left: [屏幕截图、图像识别], right: [点击、拖拽、手势]),
        (label: [物理], left: [传感器数据], right: [驱动机器人关节]),
      ),
    )
  ],
  closing: note[Computer Use = 截图 → 识别目标 → 点击输入 → 验证结果],
)

// ---------- 第 4 页 · framavert ----------

== 机器人操作

#body-slide(
  kicker: [从数字世界走进物理世界],
  inner: [
    - 机器人操作：传感器为眼、运动控制为手
    - sim2real 迁移：仿真训练 → 真实世界部署
    #v(gap-primary)
    #stretch-grid(
      columns: 2,
      gutter: gutter-primary,
      boitebleue(stretch: true)[
        *挑战*
        - 物理世界的高维连续动作
        - 实时性与安全性要求
        - sim2real 域差距
      ],
      boiteverte(stretch: true)[
        *路线*
        - 分层控制：规划 + 执行
        - 仿真环境训练
        - 域随机化增强泛化
      ],
    )
    #v(gap-primary)
    - 14 个实验，含外部复现轨道：claude-quickstarts、browser-use、XLeRobot、RoboCrew 等
  ],
  closing: boitefilled[观察与动作空间有多大，Agent 的世界就有多大],
)
