// showcase/show.cover.typ
// 家族：封面与开场 —— 一份 deck 的头尾门面。
//
// 演示两个「自成一张 slide」的全页元件（调用即多出一页，不需要写 `==`）：
//   · cover(title, subtitle, author, institution, date)：封面。左侧渐变大面板、
//     层叠圆、超淡年份背景字，唯一强调是右下角一枚橙色小方块。
//   · section-open(title, subtitle, index, color)：章节 / 分段开场页。左侧强调竖条
//     + 大标题 + 副标题；index 有值 → 右下角超淡大号章节数字，无值 → 圆角色块装饰。
//
// 交叉引用：本 deck 的封面与「目录」开场页见 main.typ 顶部。
// ⚠ 两者都会写入 accent-state / breadcrumb-state：调用之后，本家族后续内页的强调色
//    与右上角面包屑都会被改写——演示结束后由下一个家族的 section-open 复位。
#import "../lib.typ": *

// 用法: #cover(title: ..., subtitle: ..., author: ..., institution: ..., date: ...)
// 改这里: 五个具名参数；subtitle 传 none 即只留大标题。
// ⚠ 坑: 调用即自成一张 slide（无需 `==`，也不要在前面写标题）；date 默认取今天。
#cover(
  title: [幻灯片模板画廊],
  subtitle: [换一个标题就是你的 deck],
  author: [王小明],
  institution: [示例机构],
  date: [2026 年 3 月],
)

// 用法: #cover(title: [...], subtitle: none) —— 极简封面（省略副标题）
// 改这里: subtitle: none 不渲染副标题行；author / institution 换成自己的。
// ⚠ 坑: 连续两个 cover() 会连续出两张封面页，中间不夹任何 `==`。
#cover(
  title: [只有大标题的封面],
  subtitle: none,
  author: [QITINGSHE],
  institution: [slide-typst],
)

// 用法: #section-open(index: [2], title: [...], subtitle: [...], color: framaviolet)
// 改这里: 传 index → 面包屑变「第 N 章 · 标题」，右下角渲染超淡大号章节数字。
// ⚠ 坑: 自成一张 slide，须放在 `=` 之后、段内第一个 `==` 之前。此处仅作参数演示。
#section-open(
  index: [2],
  title: [带序号的章节页],
  subtitle: [有 index：右下角是大号章节数字],
  color: framaviolet,
)

// 用法: #section-open(title: [...], subtitle: [...], color: framavert) —— 内容分段（无 index）
// 改这里: 省略 index → 右下角改为超淡圆角色块 + 小实色方块；面包屑只显示标题。
// ⚠ 坑: 调用会把 breadcrumb-state 改成这里的标题，直到下一个 section-open 覆盖。
#section-open(
  title: [不带序号的分段页],
  subtitle: [无 index：右下角是圆角色块装饰],
  color: framavert,
)
