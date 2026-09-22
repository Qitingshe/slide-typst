#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""这是门禁唯一实现：CI / 本地 / pre-commit 共用；改基线只改 gates.json。

7 项检查：compile / usage-comments / api / links / section-open 区域 / pages / version。
默认模式 pages 的偏差为 WARN；--strict-pages 时 pages 偏差升级为 FAIL。
任一 FAIL -> exit 1；纯 WARN 或全 PASS -> exit 0。
运行位置不限：仓库根目录由本文件位置推导。
"""

import glob
import json
import os
import re
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def load_gates():
    path = os.path.join(ROOT, "gates.json")
    with open(path, encoding="utf-8") as f:
        return json.load(f)


def run(cmd):
    return subprocess.run(cmd, cwd=ROOT, capture_output=True, text=True)


def main():
    strict_pages = "--strict-pages" in sys.argv[1:]
    try:
        gates = load_gates()
    except Exception as e:
        print(f"[FAIL] gates.json 读取失败: {e}")
        return 1

    baselines = gates["baselines"]
    failed = False

    # ---- 1. compile：typst 必须零错误零警告（硬闸） ----
    proc = run(["typst", "compile", "main.typ", "--diagnostic-format=short"])
    merged = proc.stdout + proc.stderr
    # 门禁分层补全：CI（非 macOS）字体未捆绑入库（现 CI 经 apt 安装 fonts-noto-cjk，但包
    # 版本/度量仍可能与 macOS 不同）时 typst 仅输出字型缺失 warning，属预期差异，此场景
    # 豁免 FAIL；其余任何 error/warning（内容级）仍按硬闸 FAIL。macOS 本地与 Pages runner
    # 字体完整，不受影响。
    font_only = (
        sys.platform != "darwin"
        and bool(merged.strip())
        and all(re.search(r"unknown font family", line, re.IGNORECASE) for line in merged.splitlines() if line.strip())
    )
    if proc.returncode != 0 or (merged.strip() and not font_only and re.search(r"\b(error|warning)\b", merged, re.IGNORECASE)):
        print("[FAIL] compile (typst 输出含 error/warning 或非零退出)")
        if merged.strip():
            print("       " + (merged.strip().splitlines() or [""])[0][:200])
        failed = True
    elif font_only:
        print("[WARN] compile (非 macOS 字型缺失 warning：系统字体未入库属预期，内容级 warning 仍硬闸)")
    else:
        print("[PASS] compile")

    # ---- 2. usage-comments：showcase 各文件含 “// 用法:” 的行数之和 == 基线（硬闸） ----
    total = 0
    for path in sorted(glob.glob(os.path.join(ROOT, "showcase", "*.typ"))):
        with open(path, encoding="utf-8") as f:
            total += sum(1 for line in f if "// 用法:" in line)
    if total == baselines["usage-comments"]:
        print(f"[PASS] usage-comments ({total})")
    else:
        print(f"[FAIL] usage-comments ({total} != {baselines['usage-comments']})")
        failed = True

    # ---- 3. api：gates.json.api 每一名必须是 lib.typ 顶层 #let 导出（⊇，硬闸） ----
    # 注：Typst 标识符可含连字符（如 accent-state），故捕获组用 [\w-]+。
    libsrc = open(os.path.join(ROOT, "lib.typ"), encoding="utf-8").read()
    exports = {n for n in re.findall(r"^#let ([\w-]+)", libsrc, re.M) if not n.startswith("_")}
    missing = [n for n in gates["api"] if n not in exports]
    if missing:
        print(f"[FAIL] api 缺少导出: {missing}")
        failed = True
    else:
        print(f"[PASS] api ({len(gates['api'])}/{len(gates['api'])})")

    # ---- 4. links：main.pdf 中 /Link 出现次数 == 基线（硬闸） ----
    # 纯 Python 字节计数（语义与 `rg -a -o` 逐字节等价），不依赖 rg——
    # GitHub 托管 runner 镜像不装 ripgrep，此前 CI 在此直接 FileNotFoundError 崩溃。
    pdf = os.path.join(ROOT, "main.pdf")
    if not os.path.exists(pdf):
        print("[FAIL] links (main.pdf 不存在——应先跑完 compile)")
        failed = True
    else:
        data = open(pdf, "rb").read()
        count = data.count(b"/Link")
        if count == baselines["links"]:
            print(f"[PASS] links ({count})")
        else:
            print(f"[FAIL] links ({count} != {baselines['links']})")
            failed = True

    # ---- 5. section-open 区域：section-open 自成一张 slide（touying-slide），
    # 其后到段内首个 `=`/`==`/`#heading` 之间只允许注释/空行/#include —— 挂任何
    # 内容（slide-accent、卡片、正文）都会凭空多插一页（Touying 分页机制，探针
    # 实证）。只扫 main.typ：家族 section-open 都在这里；show.cover.typ 的连续
    # 全页演示（cover×2 + section-open×2 互不夹内容）是故意例外，不在扫描范围。
    violations = []
    main_lines = open(os.path.join(ROOT, "main.typ"), encoding="utf-8").read().splitlines()
    i = 0
    while i < len(main_lines):
        if main_lines[i].strip().startswith("#section-open("):
            j = i + 1
            while j < len(main_lines):
                s = main_lines[j].strip()
                if s.startswith("=") or s.startswith("#heading("):
                    break
                if s and not s.startswith("//") and not s.startswith("#include "):
                    violations.append(f"{j + 1}: {s[:60]}")
                j += 1
            i = j
        else:
            i += 1
    if violations:
        print(f"[FAIL] section-open 区域 (section-open 后挂了 {len(violations)} 处内容，如 {violations[:2]})")
        failed = True
    else:
        print("[PASS] section-open 区域")

    # ---- 6. pages：macOS 优先 mdls，其余用字节计数取数，取不到 WARN ----
    def pages_macos():
        try:
            p = run(["mdls", "-name", "kMDItemNumberOfPages", "-raw", "main.pdf"])
            v = p.stdout.strip()
            return int(v) if v.isdigit() else None
        except Exception:
            return None

    def pages_via_bytes():
        # 原始字节上的正则计数（不依赖 rg）。注意 0.14+ krilla 引擎把页面对象
        # 序列化为无空格 `/Type/Page`，旧正则 `/Type /Page` 恒计 0；改用
        # `\s*` 同时兼容新旧两种形式，`[^sL]` 排除 `/Type/Pages` 与每页一个的
        # `/Type/PageLabel`（实测 krilla 下两者均会误计）。
        try:
            return len(re.findall(rb"/Type\s*/Page[^sL]", open(pdf, "rb").read()))
        except Exception:
            return None

    if sys.platform == "darwin":
        methods = [pages_macos, pages_via_bytes]
    else:
        methods = [pages_via_bytes, pages_macos]
    n = None
    for m in methods:
        n = m()
        if n is not None:
            break
    if n is None:
        print("[WARN] pages (无法获取页数：mdls / 字节计数均不可用)")
    elif n == baselines["pages"]:
        print(f"[PASS] pages ({n})")
    elif strict_pages:
        print(f"[FAIL] pages ({n} != {baselines['pages']}, --strict-pages)")
        failed = True
    else:
        print(f"[WARN] pages ({n} != {baselines['pages']})")

    # ---- 7. version：typst 主次版本与 compiler 基线（默认 0.15.1）不一致 WARN ----
    try:
        p = run(["typst", "--version"])
        m = re.search(r"(\d+)\.(\d+)", p.stdout or "")
        actual = f"{m.group(1)}.{m.group(2)}" if m else "?"
    except Exception:
        actual = "?"
    expected = ".".join(gates.get("compiler", "0.15.1").split(".")[:2])
    if actual != expected:
        print(f"[WARN] version ({actual} != {expected})")
    else:
        print(f"[PASS] version ({actual})")

    return 1 if failed else 0


if __name__ == "__main__":
    sys.exit(main())