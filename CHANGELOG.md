# Changelog

本仓库遵循 [Keep a Changelog](https://keepachangelog.com/)。
基线（页数 / 用法计数 / 链接数 / API 清单）的变更只写 gates.json，这里记录行为与结构变化。

## [Unreleased]

### Fixed
- verify.py：移除以 rg/ripgrep 为依赖的链接/页数统计（GitHub 托管 runner 镜像不装 ripgrep，
  此前 CI 在 links 检查直接 FileNotFoundError 崩溃），改纯 Python 字节计数，语义逐字节等价；
  compile 检查对非 macOS 的 `unknown font family` 字型缺失 warning 降级 WARN（内容级仍硬闸）
- verify.py：pages 字节回退路径兼容 0.14+ krilla 引擎（页面对象序列化为无空格 `/Type/Page`，
  旧正则恒计 0 → 非 macOS 上 pages 静默恒 WARN），regex 改 `/Type\s*/Page[^sL]`
  （排除 `/Type/Pages` 与每页一个的 `/Type/PageLabel`），实测新旧 PDF 均返回 39

### Changed
- 工具链锁步升级：typst 0.13.1 → 0.15.1（typst.toml / CI / Pages / verify 版本闸同步；链接序列化基线 22 → 42）
- 画廊第四轮反馈落地：show.cards 引用块卡片 + 竖向文本（rotate 侧标 / stack-ttb 中文竖列）、show.basic 表格深底白字表头 + 斑马纹 + 末行强调、新增「多子图 · 三图一线」页（39 页基线 / 用法注释 29）

## [0.1.0] - 2026-09-19

### Added
- 画廊落地（8 家族 showcase，38 页基线）：封面/骨架/cards/data/nav/配色/常规元素/CeTZ 各家族可借页样例
- `figure-block` 图注元件（图与图注同宽同左缘、紧贴图下沿）
- 工程化基座：`typst.toml`（钉 0.13.1）、`gates.json`（基线单一事实源）、`scripts/verify.py`（六项门禁唯一实现）、`.github/workflows/ci.yml`、`.pre-commit-config.yaml`
- 设计 token：`framagris-soft` 助文灰、`gutter-tight`/`gutter-primary`/`gutter-loose` 三档网格距
- GitHub Pages 部署（`.github/workflows/pages.yml`，macOS strict-pages + main.pdf 预览）

### Changed
- 重构：删死 show 规则（figure.caption/footnote）；提取 `_boite-box`/`_filled-box`/`_stat-box` 视觉常量；合并 `_cover-page`/`_opener-page` → `_full-page`；`alert` 改为 `frameEmph` 转发；`cover` 身份默认参数清空（deck 身份住 main.typ）；`boitefilled` 中明度裸色自动垫深 28%（发虚守卫）
- 文档：lib.typ 头部补 API 地图（44 公开符号）与字号阶梯注释；AGENTS.md 补架构原理与升级协议
- 移除书稿 deck（`chapters/` 仅存于 feature 分支）

### Fixed
- 图注与图间距、中明度 boitefilled 白字发虚（此前在 showcase 侧局部 workaround，现已上收到元件层）