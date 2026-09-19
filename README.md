# AI Agent 书稿概览（slide-typst）

基于《深入理解 AI Agent —— 设计原理与工程实践》全书的 Typst 幻灯片概览 deck，使用 `main` 分支的 `lib.typ` 设计系统（画廊版）。

## 特性

- **55 页全书概览**：封面 → 目标 → 目录 → 核心公式 → 十章速览 → 工程要点 → 小结
- **Frama 18 色设计系统**：8 种品牌原色 × 深浅两档 + 深灰色系
- **CeTZ 示意图**：Agent 与环境闭环图、ReAct 循环图
- **自动目录与页面 chrome**：页眉标题 + 细线 + 面包屑 + 页脚三格 + 进度条
- **工程化门禁**：编译零错误零警告、基线校验、CI 硬闸、pre-commit 钩子

> 本分支为 `feature/ai-agent-book-overview`，画廊展示见 `main` 分支。

## 快速开始

需要 [Typst](https://typst.app) **0.15.1**（配套 touying 0.7.4 / cetz 0.5.2 / cetz-plot 0.1.4 / numbly 0.1.0）。

```bash
typst compile main.typ   # 生成 main.pdf
open main.pdf

typst watch main.typ     # 开发模式
```

## 目录结构

| 路径 | 职责 |
|---|---|
| `lib.typ` | 设计系统 API 源（画廊版，46 个公开符号） |
| `main.typ` | 入口：字体配置、slide-theme、deck 身份、`#include` 章节文件 |
| `chapters/core.typ` | 核心公式：Agent 公式、闭环图、ReAct、上下文五要素 |
| `chapters/ch01.typ` … `ch10.typ` | 十章速览正文 |
| `chapters/engineering.typ` | 工程要点：Harness 五要素、范式演进 |
| `chapters/wrapup.typ` | 小结：一条主线、展望与行动 |
| `chapters/tour-map.typ` | 十章地图入口页 |
| `gates.json` | 基线单一事实源 |
| `scripts/verify.py` | 门禁唯一实现 |

## 工程化与门禁

```bash
python3 scripts/verify.py              # 本机门禁
python3 scripts/verify.py --strict-pages  # 页数升级为硬闸
```

## 变更记录

见 [CHANGELOG.md](CHANGELOG.md)。
