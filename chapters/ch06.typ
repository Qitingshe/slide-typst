// chapters/ch06.typ - 第 6 章 交互扩展
#import "../lib.typ": *

// ==== v2 章节约定（其他章节照此改写）====
// 1. 章首用一张 section-open 开场页，并在这里声明本章的强调色与面包屑：
//      #section-open(index: [6], title: [交互扩展], subtitle: [...], color: framavert)
//    - index 为书章节序号（内容分段省略 index）。
//    - color 会自动写入 accent-state，之后本页/本章的 keyline、stat、
//      boitefilled、页眉紧凑标题都自动沿用该色。
//    - 面包屑自动生成为「第 6 章 · 交互扩展」，显示在内页右上角。
// 2. `==` 标题只写「主题」，不再重复「第 N 章 ·」前缀（前缀已进开场页与面包屑）。
// 3. 章节之间不再需要 #slide-accent(...) 交接色：下一章的 section-open 会自行声明。
// 4. 切记：section-open 必须紧跟在 `=` 之后、本章第一个 `==` 之前，且放在
//    `==` 标题之前不要写 #slide-accent(...)（会凭空多出一页）。

// ---------- 第 6 章 开场页（独立干净页，无页眉/页脚）----------
#section-open(
  index: [6],
  title: [交互扩展],
  subtitle: [从模态与时序两个维度扩展观察与动作空间],
  color: framavert,
)

// ---------- 第 1 页 · 强调色 framavert ----------

== 模态与时序

#keyline[观察与动作沿「模态 × 时序」两个维度扩展]

#v(0.4em)

- 模态轴：文本 → 语音 → 图像 / 视频 → 触觉
- 时序轴：同步一问一答 → 异步后台 → 事件驱动
- 维度组合决定 Agent 能处理的任务形态

#v(0.5em)

#note[异步与事件驱动：长任务后台运行、事件循环、WebSocket 消息通道]

// ---------- 第 2 页 · 强调色 framavert ----------

== 语音与 Computer Use

#keyline[会听会说，还能「看着屏幕操作」]

#v(0.4em)

- 语音交互：ASR / TTS 管线、实时对话与打断管理
- Computer Use：屏幕截图 → 识别目标元素 → 点击输入 → 验证结果
- 混合模态与辅助功能：把接口开放给更多场景与人群

// ---------- 第 3 页 · 强调色 framavert ----------

== 机器人操作

#keyline[从数字世界走进物理世界]

#v(0.4em)

- 机器人操作：传感器为眼、运动控制为手
- sim2real 迁移：仿真训练 → 真实世界部署
- 14 个实验，含外部复现轨道（claude-quickstarts、browser-use、XLeRobot、RoboCrew 等）

#v(0.5em)

#boitefilled[观察与动作空间有多大，Agent 的世界就有多大]

// 下一章强调色由 ch07 的 section-open 自行声明，这里不再交接。