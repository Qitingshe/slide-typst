// chapters/ch03.typ - 第 3 章 记忆与知识库
// 强调色：framaviolet（紫），记忆是上下文跨会话延续的基础
#import "../lib.typ": *

#section-open(
  index: [3],
  title: [记忆与知识库],
  subtitle: [跨会话记住用户、接入外部知识],
  color: framaviolet,
)

// ---------- 第 1 页 · framaviolet ----------

== 用户记忆

#body-slide(
  kicker: [记住用户，是 Agent 聪明的第一步],
  inner: [
    - *用户记忆* + 分级召回：短期 / 长期 / 事实 / 偏好
    - 授权与隐私边界 + 一致性：记住之后要用得上、用得对
    #v(gap-primary)
    #cmp-grid(
      lhs: (title: [人类类比], color: framagris),
      rhs: (title: [Agent 记忆], color: framaviolet),
      label-width: 5.2em,
      rows: (
        (label: [工作记忆], left: [短期记住当前任务细节], right: [上下文窗口 = 轨迹]),
        (label: [情景记忆], left: [上周三的晚餐], right: [具体事件与经历]),
        (label: [语义记忆], left: [用户是素食者], right: [从经验提取的事实]),
        (label: [程序记忆], left: [订机票的标准步骤], right: [行为模式与流程]),
      ),
    )
  ],
  closing: boitefilled[记忆 = 上下文的跨会话延续],
)

// ---------- 第 2 页 · framaviolet ----------

== 记忆存储策略

#body-slide(
  kicker: [四种存储格式，从极简到丰富],
  gap: 0pt, // 四卡网格偏高：kicker 后收紧
  closing-gap: 0.1em, // 收尾取诀卡：较默认略紧（溢出页二轮收紧）
  inner: [
    #stretch-grid(
      columns: 2,
      row-gutter: 0.25em, // 网格两行收紧：降行距换页高（溢出页二轮收紧）
      column-gutter: gutter-primary,
      boiteviolette(stretch: true)[
        *Simple Notes* — 每事实一原子记录
        #v(0.1em) // 卡内换行留白（紧凑档）
        开销极低 O(1)
        #v(0.1em) // 卡内换行留白（紧凑档）
        代价：信息关联丢失
      ],
      boiteverte(stretch: true)[
        *Enhanced Notes* — 保留叙事结构
        #v(0.1em) // 卡内换行留白（紧凑档）
        语义完整
        #v(0.1em) // 卡内换行留白（紧凑档）
        代价：冗余与更新复杂
      ],
      boitebleue(stretch: true)[
        *JSON Cards* — 分级嵌套
        #v(0.1em) // 卡内换行留白（紧凑档）
        可扩展部分更新
        #v(0.1em) // 卡内换行留白（紧凑档）
        代价：刚性结构
      ],
      boitejaune(stretch: true)[
        *Advanced JSON Cards* — 背景+关系
        #v(0.1em) // 卡内换行留白（紧凑档）
        消歧
        #v(0.1em) // 卡内换行留白（紧凑档）
        代价：生成维护成本高
      ],
    )
  ],
  closing: boitefilled[*取舍* 少量关键 → JSON Cards；大量非关键 → Simple Notes],
)

// ---------- 第 3 页 · framaviolet ----------

== 知识库与 RAG

#body-slide(
  kicker: [外部知识：补上训练截止与领域私域的空白],
  gap: 0pt, // 列表 + 四步流水线偏高：kicker 后收紧
  closing-gap: 0pt, // 同左：收尾附注前不留额外缝隙
  inner: [
    #flow-steps(
      dir: "col",
      row-gap: 0pt, // 四步纵向排列：降行距换页高（溢出页二三轮收紧）
      (title: [文档分块], desc: [固定/结构感知/语义切分], color: framableu),
      (title: [嵌入], desc: [稠密语义+稀疏关键词], color: framavert),
      (title: [混合检索], desc: [稠密+稀疏+重排序], color: framaorange),
      (title: [生成], desc: [检索结果+上下文作答], color: framaviolet),
    )
    #v(0.1em) // 流水线→回收行的段间留白收紧（溢出页二轮）
    - 结构化索引 / 知识图谱 · 实验 3-4/3-5
  ],
  closing: note[检索质量决定回答上限与时效 · 混合检索三阶段：并行检索 → RRF 融合 → 神经重排序],
)

// ---------- 第 4 页 · framaviolet ----------

== 检索质量指标

#body-slide(
  kicker: [没有度量就没有改进],
  inner: [
    #term-rows(
      label-width: 6.2em,
      rows: (
        (label: [#text("recall@k")], value: [前 k 个结果中「该找的找到了吗」—— 最贴近 RAG 需求], color: framaviolet),
        (label: [MRR], value: [「找到得够不够靠前」—— 排第 1 得 1 分，排第 10 得 0.1 分], color: framaviolet),
        (label: [nDCG], value: [「整个排序列表的质量」—— 考虑排名与相关程度], color: framaviolet),
        (label: [检索失败率], value: [正确信息未出现在 top-k 中的查询比例], color: framaviolet),
      ),
    )
    #v(gap-primary)
    - 混合检索三阶段：并行检索 → 倒数排名融合（RRF）→ 神经重排序
    - 稠密嵌入：语义理解（BERT、BGE-M3）；稀疏嵌入：精确关键词（BM25）
    - 实验 3-6：完整混合检索流水线
  ],
  closing: boitefilled[先看找没找到（#text("recall@k")），再看够不够靠前（MRR）· 检索失败率盯住下限],
)
