#!/usr/bin/env python3
#
# name: audit-prose
# purpose: scan markdown/text files for common AI writing tells and buzzword clusters
# usage: audit-prose.py <path-to-file-or-dir>
# stdlib only

import argparse
import re
import sys
from pathlib import Path

BUZZWORDS = [
    r"\bdelve\b",
    r"\btestament to\b",
    r"\btapestry\b",
    r"\bin today's\b",
    r"\bit's important to note\b",
    r"\bat its core\b",
    r"\bplays a (crucial|vital|pivotal) role\b",
    r"\bseamlessly\b",
    r"\brobust\b",
    r"\btransformative\b",
    r"\bmultifaceted\b",
    r"\bleverage\b",
    r"\bfoster\b",
    r"\butilize\b",
    r"\bgroundbreaking\b",
    r"\bunlock(?:s|ing)? the (?:power|potential)\b",
    r"—",  # em dash
]

PATTERNS = [re.compile(p, re.IGNORECASE) for p in BUZZWORDS]


def audit_file(path: Path) -> list:
    findings = []
    try:
        lines = path.read_text(encoding="utf-8").splitlines()
    except Exception:
        return findings

    for line_no, line in enumerate(lines, start=1):
        # Skip code fences
        if line.strip().startswith("```") or line.strip().startswith("`"):
            continue
        for pat in PATTERNS:
            match = pat.search(line)
            if match:
                findings.append((line_no, match.group(0), line.strip()))
    return findings


def main(argv=None):
    parser = argparse.ArgumentParser(description="Audit files for AI writing tells.")
    parser.add_argument("target", help="File or directory to scan")
    args = parser.parse_args(argv)

    target_path = Path(args.target)
    if not target_path.exists():
        print(f"Error: path {target_path} does not exist", file=sys.stderr)
        return 1

    files = [target_path] if target_path.is_file() else list(target_path.rglob("*.md"))
    total_findings = 0

    for f in sorted(files):
        results = audit_file(f)
        if results:
            print(f"\n{f}:")
            for line_no, token, snippet in results:
                print(f"  L{line_no} [{token}]: {snippet[:80]}")
                total_findings += 1

    if total_findings == 0:
        print("No AI slop clusters detected.")
        return 0
    else:
        print(f"\nTotal potential tells flagged: {total_findings}")
        return 0


if __name__ == "__main__":
    sys.exit(main())
