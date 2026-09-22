// showcase/show.cards.typ
// 家族：卡片与网格 —— 信息分块的主力元件。
//
// 演示两组元件：
//   · 浅色卡片 boitebleue / verte / rouge / orange / violette / jaune / marron / grise
//     （3pt 左竖条 + 极浅底 + 圆角，一个内容参数）。
//   · 实色卡片 boitefilled（强调色底 + 白字，放结论 / 高反差）。
//   · 引申样例：引用块卡片（quote + boite 视觉，观点/金句）与竖向文本
//     （rotate 侧标 + stack(dir: ttb) 中文竖列——typst 无 text(dir: ttb)）。
//   · stretch-grid(..cells, columns, row-gutter, column-gutter, gutter)：自动等高网格。
//
// 关键机制（stretch 协议）：卡片加 stretch: true 时不再返回排版好的块，而返回一个
// 「规格字典」，必须交给 stretch-grid 排版——它自动测量各格自然高度、按行取最大，
// 生成等高网格；stat 的大数字还会锚定行垂直中心。
//
// 交叉引用：末页「全要素样板页」是任何真实内容页的起手式。
// ⚠ 坑：stretch: true 的卡片只能交给 stretch-grid；单元格里卡片外面不要再包 []。
// ⚠ 溢出: stretch-grid 每格建议 ≤ 3 行文本（或等量内容），超过会被静默截断。
#import "../lib.typ": *

// 用法: boitebleue[...] / boiteverte[...] / ... 八色浅色卡片（每色一个函数）
// 改这里: 直接把内容写进方括号；颜色语义自定（蓝/绿/红/橙/紫/黄/棕/灰）。
// ⚠ 坑: 并排展示时用 stretch: true + stretch-grid —— 自动等高同宽，
//        不会被最长/最宽的文字拉扯；单元格里卡片外面不要再包 []。
//        色名右侧的几何角标是色盲冗余（形状×颜色双编码，8 个互异保守码位
//        ●■▲◆★▼◎◇，取自 Noto CJK 高覆盖集合）；换演示内容时保住「一色一形」
//        即可，0.55em 深灰字级——只做冗余标记，不抢卡片正文的戏。
== 八色卡片 · boite 系列

#stretch-grid(
  columns: 4,
  gutter: 0.6em,
  boitebleue(stretch: true)[#align(center)[*bleue* #h(0.3em) #text(size: 0.55em, fill: framagrisdark)[●] \ #text(size: 0.72em)[主色 · 默认] \ #text(size: 0.6em, fill: framagris)[设计系统核心组件库]]],
  boiteverte(stretch: true)[#align(center)[*verte* #h(0.3em) #text(size: 0.55em, fill: framagrisdark)[■] \ #text(size: 0.72em)[辅助 · 成功] \ #text(size: 0.6em, fill: framagris)[数据同步与状态校验]]],
  boiterouge(stretch: true)[#align(center)[*rouge* #h(0.3em) #text(size: 0.55em, fill: framagrisdark)[▲] \ #text(size: 0.72em)[警示 · 错误] \ #text(size: 0.6em, fill: framagris)[异常触发告警与回滚]]],
  boiteorange(stretch: true)[#align(center)[*orange* #h(0.3em) #text(size: 0.55em, fill: framagrisdark)[◆] \ #text(size: 0.72em)[强调 · 稀有] \ #text(size: 0.6em, fill: framagris)[高优事项标记预警]]],
  boiteviolette(stretch: true)[#align(center)[*violette* #h(0.3em) #text(size: 0.55em, fill: framagrisdark)[★] \ #text(size: 0.72em)[次要 · 深色组] \ #text(size: 0.6em, fill: framagris)[扩展策略配置面板]]],
  boitejaune(stretch: true)[#align(center)[*jaune* #h(0.3em) #text(size: 0.55em, fill: framagrisdark)[▼] \ #text(size: 0.72em)[提示 · 浅色] \ #text(size: 0.6em, fill: framagris)[表单输入实时校验提示]]],
  boitemarron(stretch: true)[#align(center)[*marron* #h(0.3em) #text(size: 0.55em, fill: framagrisdark)[◎] \ #text(size: 0.72em)[中性 · 柔和] \ #text(size: 0.6em, fill: framagris)[历史归档数据概览]]],
  boitegrise(stretch: true)[#align(center)[*grise* #h(0.3em) #text(size: 0.55em, fill: framagrisdark)[◇] \ #text(size: 0.72em)[弱化 · 置灰] \ #text(size: 0.6em, fill: framagris)[禁用或已完成项目]]],
)

// 用法: #quote(block: true)[引文] 装进 #boiteXXX —— 引用块卡片（观点/金句/原则）
// 改这里: 引文写 quote 里，出处改「— …」；boite 换色即换气氛（#boitebleue → #boiteXXX）。
// ⚠ 坑: #quote 的 block: false 会**自动加弯引号**（适合句子中行内引用），
//        block: true 不加引号（卡片型引用用它，引号自写或留白给缩进表意）。
#v(gap-secondary)
#grid(
  columns: (1.4fr, 1fr),
  gutter: 0.8em,
  [
    #boitebleue[
      #quote(block: true)[
        设计系统是收敛的选择，不是自由的匮乏。
      ]
    ]
  ],
  [
    #boitegrise[
      *引用块卡片*
      高频场景：观点、原则、金句。
      quote 不自带花哨样式，视觉由外层 boite
      的浅底竖条提供；出处用 `#h(1fr)` 推右。
    ]
  ],
)

// 用法: #boitefilled(color: X, stretch: true) 交给 stretch-grid —— 实色卡片（色底 + 白字）
// 改这里: 并排时每张加 stretch: true 让三栏等高（内容一行两行不齐，等高补齐底边）；
//         color 只传真正够深的底色：framableu / framarouge / framaviolet 直接可用，
//         framaorange 这类中明度色须 darken(25~30%) 垫深后再配白字；
//         color: auto（默认值）渲染时按当前 section 强调色解析（见 auto 色卡片）；
//         stat(stretch: true) 与 boitefilled(stretch: true) 可混排同一 stretch-grid。
// ⚠ 坑: 白字对比由底色的明度决定，与饱和度无关——framavert / framaorange /
//        framajaune / framamarron 裸用会发虚，务必 darken 或换深原色；
//        _mid-tone-darken 守卫：对比度 < 4.5:1 的中明度色自动 darken(28%)，
//        传已垫深色（如 .darken(28%)）可绕过守卫。
== 实色卡片 · boitefilled

#stretch-grid(
  columns: 3,
  gutter: 0.6em,
  boitefilled(color: framableu, stretch: true)[*蓝底结论* 高反差，一眼抓住],
  boitefilled(color: framarouge, stretch: true)[*红底结论* 放风险提醒],
  boitefilled(color: framaorange.darken(28%), stretch: true)[*橙底结论* 垫深后才配白字],
)

// 用法: #boitefilled(color: X) + stack-ttb 中文竖排（借页即用形态）——实色卡竖排组合
//        #rotate(90deg, reflow: true) 西文侧标 / #stack(dir: ttb, spacing: …) 灰字中文竖列
// 改这里: boitefilled 换色即换气氛（framaviolet / framableu 裸用即可）；竖排逐字传 #stack；
//         侧标文本写 rotate 里（短词 + tracking 拉开）；SIDEBAR 可选配或省略。
// ⚠ 坑: typst 无 #text(dir: ttb)——中文竖排必须显式 #stack(dir: ttb)；
//        rotate 务必带 reflow: true，否则旋转后不参与布局、会叠到隔壁内容上；
//        实色竖块与灰字竖排并排，形成「色块 vs 文字」对照层次。
#v(0.15em)
#grid(
  columns: (auto, auto, auto, 1fr),
  column-gutter: 0.6em,
  align(horizon)[
    #boitefilled(color: framaviolet)[
      #align(center)[
        #stack(dir: ttb, spacing: 0.2em,
          text(size: 1em)[借],
          text(size: 1em)[页],
          text(size: 1em)[即],
          text(size: 1em)[用])
      ]
    ]
  ],
  align(horizon)[
    #rotate(90deg, reflow: true)[
      #text(size: 7.5pt, fill: framagris, tracking: 0.3em)[SIDEBAR]
    ]
  ],
  align(horizon)[
    #stack(dir: ttb, spacing: 0.15em,
      text(size: 0.72em, fill: framagris)[借],
      text(size: 0.72em, fill: framagris)[页])
  ],
  align(horizon)[
    #text(size: 0.6em, fill: framagris)[rotate + stack-ttb：竖排侧标与中文竖列的紧凑形态]
  ],
)

// 裸色直用 / auto跟随强调色 / stat+boitefilled 混排等高——更多实色卡变体演示
// auto 省略 color 参数，渲染时按当前 section 强调色解析（_mid-tone-darken 同步生效）；
// stat(stretch: true) 大数字锚定行垂直中心，boitefilled 补齐右侧，演示真实内容页起手式。
#v(0.2em)
#stretch-grid(
  columns: 4,
  gutter: 0.5em,
  boitefilled(color: framaviolet, stretch: true)[*violet* 深原色直用 6.38],
  boitefilled(color: framagrisdark, stretch: true)[*gris dark* 深灰收束],
  boitefilled(stretch: true)[*auto* 跟随 violet],
  stat(stretch: true)[3][裸色直用],
)

// 用法: #stretch-grid(columns: 3, gutter: 1em, boiteXXX(stretch: true)[...], ...)
// 改这里: 每张卡片加 stretch: true；columns 传整数（列数），行数自动推导。
// ⚠ 坑: 三格内容长短不一也会被拉成等高；stretch: true 的卡片不能再包 []。
== stretch-grid · 3 列等高

#stretch-grid(
  columns: 3,
  gutter: 1em,
  boitebleue(stretch: true)[*短* 不等高的内容也会被拉齐],
  boiteverte(stretch: true)[
    *中等长度* 自动测量自然高度，按行取最大值，
    让同一行的卡片底部对齐。
  ],
  boiteorange(stretch: true)[
    *最长* 无论几行文字，同行的邻居都会长到和它一样高，
    整行像一条齐整的卡片带。
  ],
)

// 用法: #stretch-grid(columns: 5, row-gutter: 0.5em, column-gutter: 0.6em, ...)
// 改这里: gutter 同时设定行列间距；也可分开用 row-gutter / column-gutter。
// ⚠ 坑: columns 是整数（列数），不要传数组；gutter 优先级高于另两个。
== stretch-grid · 5 列与 gutter

#stretch-grid(
  columns: 5,
  row-gutter: 0.5em,
  column-gutter: 0.6em,
  boitebleue(stretch: true)[*一* \ #text(size: 0.5em, fill: framagris)[紧凑]],
  boiteverte(stretch: true)[*二* \ #text(size: 0.5em, fill: framagris)[适中]],
  boiteorange(stretch: true)[*三* \ #text(size: 0.5em, fill: framagris)[宽松]],
  boiteviolette(stretch: true)[*四* \ #text(size: 0.5em, fill: framagris)[列距]],
  boitegrise(stretch: true)[*五* \ #text(size: 0.5em, fill: framagris)[行距]],
)

// 用法: body-slide + stretch-grid(boite + stat) + boitefilled + note 的完整组合
// 改这里: 把这张页当作任何真实内容页的起手式，逐块替换文案即可。
// ⚠ 坑: stat(stretch: true) 与 boite(stretch: true) 可混在同一行等高。
== 全要素样板页

#body-slide(
  kicker: [一张真实内容页的全部零件],
  inner: [
    #stretch-grid(
      columns: 3,
      gutter: 0.8em,
      stat(stretch: true)[8][家族数],
      boitebleue(stretch: true)[*要点一* 结论性的一句话],
      boiteverte(stretch: true)[*要点二* 与左边等高的说明],
    )
    #v(gap-secondary)
    #stretch-grid(
      columns: 2,
      gutter: 0.8em,
      stat(stretch: true)[18][调色板色值],
      boitefilled(stretch: true)[*结论条* 用实色卡片收束本页],
    )
  ],
  closing: note[页尾 note 交代出处、口径或下一步；也可以换成 boitefilled。],
)
