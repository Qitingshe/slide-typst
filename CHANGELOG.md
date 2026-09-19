# Changelog

本仓库遵循 [Keep a Changelog](https://keepachangelog.com/)。
基线（页数 / 用法计数 / 链接数 / API 清单）的变更只写 gates.json，这里记录行为与结构变化。

## [Unreleased]

### Changed
- 分支 `feature/ai-agent-book-overview` 应用 `main` 分支画廊版设计系统：
  `lib.typ` 替换为画廊版（638 行，cetz 0.5.2、新增 cetz-plot 0.1.4、figure-block、
  boitefilled 中明度垫深守卫、stretch-grid gutter 参数、页眉细线命名常量等）；
  `main.typ` 保留书稿章节结构，换用新版骨架（slide-theme.with(config-info)、
  全局两端对齐）；工程化文件（gates.json / verify.py / CI / Pages / pre-commit）从
  main 分支合并；gates.json 基线适配书稿（pages: 55, usage-comments: 20, links: 18）。
