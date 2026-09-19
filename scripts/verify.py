#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""这是门禁唯一实现：CI / 本地 / pre-commit 共用；改基线只改 gates.json。

6 项检查：compile / usage-comments / api / links / pages / version。
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
    if proc.returncode != 0 or re.search(r"\b(error|warning)\b", merged, re.IGNORECASE):
        print("[FAIL] compile (typst 输出含 error/warning 或非零退出)")
        if merged.strip():
            print("       " + (merged.strip().splitlines() or [""])[0][:200])
        failed = True
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
    pdf = os.path.join(ROOT, "main.pdf")
    if not os.path.exists(pdf):
        print("[FAIL] links (main.pdf 不存在——应先跑完 compile)")
        failed = True
    else:
        proc = run(["rg", "-a", "-o", "/Link", "main.pdf"])
        count = proc.stdout.count("/Link")
        if count == baselines["links"]:
            print(f"[PASS] links ({count})")
        else:
            print(f"[FAIL] links ({count} != {baselines['links']})")
            failed = True

    # ---- 5. pages：macOS 优先 mdls，其余优先 rg /Type /Page[^s]，取不到 WARN ----
    def pages_macos():
        try:
            p = run(["mdls", "-name", "kMDItemNumberOfPages", "-raw", "main.pdf"])
            v = p.stdout.strip()
            return int(v) if v.isdigit() else None
        except Exception:
            return None

    def pages_via_rg():
        try:
            p = run(["rg", "-a", "-o", "/Type /Page[^s]", "main.pdf"])
            return len(re.findall(r"/Type /Page[^s]", p.stdout))
        except Exception:
            return None

    if sys.platform == "darwin":
        methods = [pages_macos, pages_via_rg]
    else:
        methods = [pages_via_rg, pages_macos]
    n = None
    for m in methods:
        n = m()
        if n is not None:
            break
    if n is None:
        print("[WARN] pages (无法获取页数：mdls / rg 均不可用)")
    elif n == baselines["pages"]:
        print(f"[PASS] pages ({n})")
    elif strict_pages:
        print(f"[FAIL] pages ({n} != {baselines['pages']}, --strict-pages)")
        failed = True
    else:
        print(f"[WARN] pages ({n} != {baselines['pages']})")

    # ---- 6. version：typst 主次版本与 compiler 基线（默认 0.15.1）不一致 WARN ----
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