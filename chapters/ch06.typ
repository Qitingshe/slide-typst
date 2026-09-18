// chapters/ch06.typ - 第 6 章 交互：观察与动作空间的扩展
// 强调色：全章 framavert（承接 §5 交接），结尾交接 framaviolet
#import "../lib.typ": *

// ---------- 第 1 页 · 强调色 framavert（承接 §5，无需声明）----------

== 第 6 章 · 模态与时序

#keyline[观察与动作沿「模态 × 时序」两个维度扩展]

#v(0.4em)

- 模态轴：文本 → 语音 → 图像 / 视频 → 触觉
- 时序轴：同步一问一答 → 异步后台 → 事件驱动
- 维度组合决定 Agent 能处理的任务形态

#v(0.5em)

#note[异步与事件驱动：长任务后台运行、事件循环、WebSocket 消息通道]

// ---------- 第 2 页 · 强调色 framavert ----------

== 第 6 章 · 语音与 Computer Use

#keyline[会听会说，还能「看着屏幕操作」]

#v(0.4em)

- 语音交互：ASR / TTS 管线、实时对话与打断管理
- Computer Use：屏幕截图 → 识别目标元素 → 点击输入 → 验证结果
- 混合模态与辅助功能：把接口开放给更多场景与人群

// ---------- 第 3 页 · 强调色 framavert ----------

== 第 6 章 · 机器人操作

#keyline[从数字世界走进物理世界]

#v(0.4em)

- 机器人操作：传感器为眼、运动控制为手
- sim2real 迁移：仿真训练 → 真实世界部署
- 14 个实验，含外部复现轨道（claude-quickstarts、browser-use、XLeRobot、RoboCrew 等）

#v(0.5em)

#boitefilled[观察与动作空间有多大，Agent 的世界就有多大]

// 下一页强调色：本页末尾收尾声明（交接 §7 framaviolet）
#slide-accent(framaviolet)