// chapters/ch05.typ - 第 5 章 Coding Agent 与通用 Agent
// 强调色：framableu（蓝），代码是能创造新工具的工具
#import "../lib.typ": *

#section-open(
  index: [5],
  title: [Coding 编码],
  subtitle: [Coding Agent 与通用 Agent —— 代码是「能创造新工具的工具」],
  color: framableu,
)

// ---------- 第 1 页 · framableu ----------

== Coding Agent 的核心能力

#body-slide(
  kicker: [代码生成不是专门化 Agent 的专利，而是每个通用 Agent 的基础能力],
  inner: [
    - Coding Agent 的五类核心操作：浏览（ls/glob）、读取（read）、编辑（edit/write）、运行（bash）、搜索（grep/search）
    #v(gap-primary)
    #cmp-grid(
      lhs: (title: [工具函数], color: framableu),
      rhs: (title: [用途], color: framaorange),
      label-width: 5.2em,
      rows: (
        (label: [浏览目录], left: [`ls` / `glob`], right: [了解项目结构]),
        (label: [读取文件], left: [`read` / `cat`], right: [分析现有代码]),
        (label: [编辑文件], left: [`edit` / `write`], right: [修改代码、创建新文件]),
        (label: [运行命令], left: [`bash`], right: [执行脚本、运行测试]),
        (label: [搜索模式], left: [`grep` / `search`], right: [查找定义、引用、TODO]),
      ),
    )
  ],
  closing: note[五类操作覆盖了几乎所有 Coding Agent 的核心动作],
)

// ---------- 第 2 页 · framableu ----------

== 增量开发循环

#body-slide(
  kicker: [小步快跑：每次只改一点，立刻验证],
  inner: [
    - *增量开发循环*：理解需求 → 搜索相关代码 → 编辑 → 测试 → 调试修复
    - 代码解释器：受限 Python 沙盒，读表 / 清洗 / 统计 / 绘图一站式
    - *沙盒安全*：默认无网络、路径受限、时间 / CPU / 内存 / 输出上限
    #v(gap-primary)
    #stretch-grid(
      columns: 3,
      gutter: gutter-tight,
      boiteverte(stretch: true)[
        *理解需求*
        分析问题 → 确定范围
      ],
      boitebleue(stretch: true)[
        *搜索代码*
        找到相关文件与函数
      ],
      boiteorange(stretch: true)[
        *编辑*
        最小 diff 修改
      ],
      boiteviolette(stretch: true)[
        *测试*
        运行测试 → 验证
      ],
      boiterouge(stretch: true)[
        *调试修复*
        分析失败 → 修正
      ],
    )
  ],
  closing: note[实验 5-1：Coding Agent 实战 —— Claude Code / OpenCode 实践],
)

// ---------- 第 3 页 · framableu ----------

== 通用 Agent 的架构

#body-slide(
  kicker: [通用 Agent = Coding + Deep Research + Computer Use 观察/动作空间的并集],
  inner: [
    - *核心洞察*：开放任务型通用 Agent 的核心是一个 Coding Agent + 文件系统
    - 文件系统 = Agent 的工作空间（代码、数据、记忆、中间产物）
    #v(gap-primary)
    #term-rows(
      label-width: 7em,
      rows: (
        (label: [Coding Agent], value: [读写文件 + 搜索代码 + 运行命令 + 测试验证], color: framableu),
        (label: [Deep Research], value: [检索信息 + 综合阅读 + 长文生成], color: framableu),
        (label: [Computer Use], value: [截图识别 + 模拟点击 + GUI 操作], color: framableu),
        (label: [文件系统], value: [持久化存储代码、数据、记忆、中间产物], color: framableu),
      ),
    )
  ],
  closing: note[基准：SWE-bench、Terminal Bench —— 量化「会不会修代码」],
)

// ---------- 第 4 页 · framableu ----------

== 错误恢复与安全

#body-slide(
  kicker: [健壮的 Coding Agent = 好工具 + 好恢复 + 好安全],
  inner: [
    #stretch-grid(
      columns: 2,
      gutter: gutter-primary,
      boiteverte(stretch: true)[
        *故障与错误恢复*
        - 最小 diff + 可回滚
        - 错误分类：语法错误 vs 逻辑错误 vs 环境问题
        - 多级重试策略
      ],
      boiterouge(stretch: true)[
        *安全要点*
        - 沙盒隔离：无网络、路径受限
        - 操作审计：所有命令和执行结果可追溯
        - 时间 / CPU / 内存 / 输出上限
      ],
    )
    #v(gap-primary)
    - #text(fill: framaorange)[*案例*] 从 Manus 到 OpenClaw，成功的通用 Agent 都遵循 Coding Agent 范式
  ],
  closing: boitefilled[错误恢复让人敢跑，安全边界让人敢放 —— 两者缺一不可],
)
