#!/usr/bin/env python3
#
# name: commit
# purpose: format a kit commit message, stage files, show the diff, commit on confirmation (cross-platform primary)
# usage: commit.py "<short-summary>"
# example: python .agents/commands/scripts/commit.py "Fix deprecation warnings"
# created: 2026-08-18, by init-agent subagent (kit starter)
# params: summary from argv[1]; stdlib only

import argparse
import subprocess
import sys


def git(*args):
    return subprocess.run(["git", *args], capture_output=True, text=True)


def main(argv=None):
    parser = argparse.ArgumentParser(
        description="Format a kit commit message, stage, show, and commit on confirmation."
    )
    parser.add_argument("summary", help="short summary, under 50 characters")
    args = parser.parse_args(argv)

    if len(args.summary) > 50:
        print("error: summary longer than 50 characters", file=sys.stderr)
        return 2

    status = git("status", "--porcelain")
    if not status.stdout.strip():
        print("nothing to commit", file=sys.stderr)
        return 2

    git("add", "-A")

    names = git("diff", "--cached", "--name-only").stdout.splitlines()[:30]
    names = [n if len(n) <= 72 else n[:69] + "..." for n in names]
    body = "\n".join(f"- {n}" for n in names)
    msg = (
        f"{args.summary}\n\n"
        "Detailed explanation of changes:\n"
        f"{body}\n\n"
        "Benefits:\n-\n\n"
        "ADR:\n"
        "Change plans:\n\n-\n"
    )

    print("---- staged diff (stat) ----")
    print(git("diff", "--cached", "--stat").stdout)
    print("---- commit message ----")
    print(msg)
    print("------------------------")

    answer = input("Commit? [y/N] ").strip().lower()
    if answer not in ("y", "yes"):
        print("aborted, nothing committed")
        return 3

    result = subprocess.run(["git", "commit", "-F", "-"], input=msg, text=True)
    return result.returncode


if __name__ == "__main__":
    sys.exit(main())
