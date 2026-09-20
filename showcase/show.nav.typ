// showcase/show.nav.typ
// 家族：导航与目录 —— 让读者知道「我在哪、能去哪」。
//
// 演示两件事：
//   · 自动目录 recipe：#show outline.entry 重排条目样式 + #outline(depth: 1) 生成。
//     条目自动链接到对应页，删改章节时目录自动跟随。
//   · 页面 chrome：页眉（标题 + 细线）、右上角面包屑、页脚三格（作者 / deck 标题 /
//     日期+页码）、顶部进度条。
//     chrome 全部由主题自动渲染，无需调用任何元件。
//
// 交叉引用：main.typ 的「内容地图」页用了同一套 recipe；本页演示换一种样式。
// ⚠ outline entry 是方法调用 it.body() / it.page() / it.element.location()（0.15.1）
//   （不是字段）；show 规则体必须用代码上下文 it => {...}。
#import "../lib.typ": *

// 用法: #show outline.entry: it => {...} 紧贴 #outline(title: none, depth: 1)
// 改这里: 条目样式在 show 规则里（这里页码在左、条目名在右）；depth 控制收录层级。
// ⚠ 坑: (1) 用标记块 [ ... ] 写 show 规则体会把 link/grid 当字面文字排版；
//        (2) show 规则与 #outline 要保持相邻（Touying 提示）；
//        (3) 页码取 it.page()，链接取 it.element.location()；
//        (4) show 规则从声明点起至文档末尾全局生效（覆盖此前的样式、接管之后
//            所有 outline）——若你的 deck 已有目录样式，把本页放在目录之后，
//            或只抄 #outline 那段、不抄 show 规则。
== 自动目录 · recipe

#show outline.entry: it => {
  link(
    it.element.location(),
    grid(
      columns: (1.6em, 1fr),
      column-gutter: 2.4em,
      align(right, text(size: 0.9em, weight: "bold", fill: framableu)[#it.page()]),
      text(size: 1.02em, fill: framagrisdark)[#it.body()],
    ),
  ) + v(0.05em) // 条目间距：收紧（原 0.42em→0.28em→0.18em→0.05em）让 10 行目录 + note 收尾回本页
}

#body-slide(
  kicker: [把八族再列一遍，演示 recipe 可整体搬走],
  inner: [
    #v(0.2em) // 页顶留白：收紧给 10 行目录 + note 收尾腾位
    #outline(title: none, depth: 1)
  ],
  closing: note[每行都可点击跳转；条目名来自各 `=` 分段标题。],
)

// 用法: 页面 chrome 由主题自动渲染——无需手动调用任何元件
// 改这里: 页眉标题 = 本页 `==` 文案；面包屑 = 最近一次 section-open 的标题；
//          页脚三格 = config-info 驱动（touying 默认渲染）：作者 / deck 标题 /
//          日期+页码（N/M），三色块各 0.4em 高、白字。
// ⚠ 坑: 面包屑为 none 时不渲染、不留空位；`==` 标题已被移到页眉，
//        正文里再写标题样式规则无效。
== 页面 chrome · 页眉 / 面包屑 / 页脚 / 进度条

#body-slide(
  kicker: [不用写代码，chrome 每页自动就位],
  inner: [
    #stretch-grid(
      columns: 2,
      gutter: 0.8em,
      boitebleue(stretch: true)[*页眉* 标题 + 整行浅色细线；标题颜色跟随当前强调色。],
      boitegrise(stretch: true)[*面包屑* 右上角小灰字 = 最近一次 section-open 的标题。],
      boiteverte(stretch: true)[*页脚* 三格：作者 / deck 标题 / 日期+页码（N/M）。],
      boiteorange(stretch: true)[*进度条* 页面顶部细条，指示当前页在整个 deck 中的位置。],
    )
  ],
  closing: note[页眉细线与标题色随强调色连锁更新——见「配色与强调」家族。],
)
