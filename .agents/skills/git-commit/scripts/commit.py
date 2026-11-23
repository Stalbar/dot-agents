#!/usr/bin/env python3
"""Format a kit commit message, stage files, show diff, and commit."""

import argparse
import subprocess
import sys


def git(*args):
    return subprocess.run(["git", *args], capture_output=True, text=True)


def main(argv=None):
    parser = argparse.ArgumentParser(
        description="Format a kit commit message, stage, show, and commit."
    )
    parser.add_argument("summary", help="Short summary (imperative, under 50 characters)")
    parser.add_argument("-y", "--yes", action="store_true", help="Skip confirmation prompt")
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
        "Change plans:\n-\n"
    )

    print("---- staged diff (stat) ----")
    print(git("diff", "--cached", "--stat").stdout)
    print("---- commit message ----")
    print(msg)
    print("------------------------")

    if not args.yes:
        try:
            answer = input("Commit? [y/N] ").strip().lower()
        except EOFError:
            answer = "n"
        if answer not in ("y", "yes"):
            print("aborted, nothing committed")
            return 3

    result = subprocess.run(["git", "commit", "-F", "-"], input=msg, text=True)
    return result.returncode


if __name__ == "__main__":
    sys.exit(main())
