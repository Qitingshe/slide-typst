// showcase/show.tables.typ
// 家族：表格与流程 —— 表格替代语言三组件 + body-slide center 变体。
//
// 演示四件事：
//   · cmp-grid（对比网格）：左/右栏双色对比表，替代原生 table 灰细线对标。
//   · term-rows（术语行）：名称→说明枚举，替代灰色表格式术语表。
//   · flow-steps（编号流程条）：横向/纵向编号药丸＋箭头连接，替代步骤枚举表。
//   · body-slide(center: true)：垂直居中变体——内容块在正文区内上下等距居中。
//
// 交叉引用：lib.typ 定义了三组件与 body-slide center 模式；
//           本页演示每组的典型用法与坑点。
// 借页：沿用法注释复制到你的 deck 即可。
#import "../lib.typ": *

// 用法: cmp-grid(lhs, rhs, rows) 替代原生 3 列表格。
// 改这里: lhs/rhs 定义左右栏标题与强调色；rows 的每项 = (label, left, right)。
// ⚠ 坑: lhs/rhs 的 color 省略 = 跟随当前页强调色；标题行用 boitefilled 实色框；
//        label 是灰色加粗右对齐维度名；单元格只放纯行内文本（见 _cmp-cell）。
== 对比网格 · cmp-grid

#body-slide(
  kicker: [双色对比表，替代「维度×两侧」原生 table],
  inner: [
    #cmp-grid(
      lhs: (title: [方案 A], color: framableu),
      rhs: (title: [方案 B], color: framaorange),
      rows: (
        (label: [架构], left: [单体部署], right: [微服务拆解]),
        (label: [扩展], left: [垂直扩容], right: [水平弹性]),
        (label: [运维], left: [人工介入], right: [自动编排]),
        (label: [成熟度], left: [企业验证], right: [社区活跃]),
      ),
    )
  ],
  closing: note[四行对比，每行维度名靠右、值单元格自动单行居中对齐。],
)

// 用法: term-rows(rows) 替代 2 列术语表。
// 改这里: rows 的每项 = (label, value, color: auto)。
// ⚠ 坑: label 自动灰色加粗右对齐；value 单元格用当前强调色左竖条。
== 术语行 · term-rows

#body-slide(
  kicker: [名称→说明枚举，以左竖条卡片语言替代斑马纹表格],
  inner: [
    #term-rows(
      rows: (
        (label: [接口], value: [RESTful API，JSON 序列化]),
        (label: [鉴权], value: [OAuth 2.0 + JWT 令牌]),
        (label: [缓存], value: [Redis 只读副本，TTL 可配]),
      ),
    )
  ],
  closing: note[三行术语，标签列宽 7em；长文本自动左对齐。],
)

// 用法: flow-steps(..., dir: "row") 替代编号步骤表。
// 改这里: 每步 = (title, desc, color)；dir = "row"（横向→）或 "col"（纵向↓）。
// ⚠ 坑: 横向时步骤数 ≤5；纵向步骤数 ≤5且说明 ≤3 行——见 flow-steps 注释。
== 编号流程条 · flow-steps（横向）

#body-slide(
  kicker: [药丸编号 + 箭头连接，替代步骤枚举表],
  inner: [
    #flow-steps(
      (title: [规划], desc: [需求分析与设计], color: framableu),
      (title: [开发], desc: [编码与单元测试], color: framavert),
      (title: [部署], desc: [CI/CD 流水线], color: framaorange),
    )
  ],
  closing: note[横向三步骤，默认用 → 连接。],
)

// 用法: body-slide(center: true) 使整块垂直居中。
// 改这里: 加 center: true 参数；注意 fr 方案的原理（lib.typ 有完整论证注释）。
// ⚠ 坑: 纵向 flow-steps 的行高被药丸度量锁死 ≈61.5pt/行；body-slide(center: true)
//        配合纵向步骤适用于中等长度内容——页高充裕时不浪费上方空白。
== 纵向流程 · body-slide center 变体

#body-slide(
  kicker: [垂直居中 + 纵向步骤，适合紧凑或签名式结尾页],
  inner: [
    #flow-steps(
      dir: "col",
      (title: [输入], desc: [原始数据清洗], color: framableu),
      (title: [处理], desc: [特征工程与模型推理], color: framavert),
      (title: [输出], desc: [结果可视化与存储], color: framaorange),
    )
  ],
  closing: note[body-slide(center: true) 使内容在正文区内上下居中。],
  center: true,
)
