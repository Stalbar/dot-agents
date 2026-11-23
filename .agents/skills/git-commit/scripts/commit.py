#!/usr/bin/env python3
"""Format a standardized commit message, stage files, and commit."""

import argparse
import subprocess
import sys


def git(*args, check=True):
    res = subprocess.run(["git", *args], capture_output=True, text=True, encoding="utf-8")
    if check and res.returncode != 0:
        err = res.stderr.strip() or f"git {' '.join(args)} failed with exit code {res.returncode}"
        raise RuntimeError(err)
    return res


def main(argv=None):
    parser = argparse.ArgumentParser(
        description="Format a standardized commit message, stage files, and commit."
    )
    parser.add_argument("summary", help="Short summary (imperative, under 50 characters)")
    parser.add_argument("-a", "--all", action="store_true", help="Stage all modified and untracked files before committing")
    parser.add_argument("-y", "--yes", action="store_true", help="Skip confirmation prompt")
    parser.add_argument("-b", "--benefits", action="append", default=[], help="Benefit of changes (repeatable)")
    parser.add_argument("--adr", help="ADR reference (e.g. docs/00_adr/000001-auth.md)")
    parser.add_argument("-p", "--plan", action="append", default=[], help="Change plan reference (repeatable)")
    args = parser.parse_args(argv)

    if len(args.summary) > 50:
        print("error: summary longer than 50 characters", file=sys.stderr)
        return 2

    try:
        if args.all:
            git("add", "-A")

        diff_staged = git("diff", "--cached", "--name-only")
        staged_files = [f for f in diff_staged.stdout.splitlines() if f.strip()]

        if not staged_files:
            print("error: no staged changes. Stage files first (git add <files>) or pass --all (-a).", file=sys.stderr)
            return 2

        names = staged_files[:30]
        names = [n if len(n) <= 72 else n[:69] + "..." for n in names]
        body = "\n".join(f"- {n}" for n in names)

        lines = [args.summary, "", "Detailed explanation of changes:", body]

        if args.benefits:
            lines.extend(["", "Benefits:"])
            for b in args.benefits:
                lines.append(f"- {b}")

        if args.adr:
            lines.extend(["", f"ADR: {args.adr}"])

        if args.plan:
            lines.extend(["", "Change plans:"])
            for p in args.plan:
                lines.append(f"- {p}")

        msg = "\n".join(lines) + "\n"

        print("---- staged diff (stat) ----")
        stat_res = git("diff", "--cached", "--stat")
        print(stat_res.stdout)
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

        commit_res = subprocess.run(["git", "commit", "-F", "-"], input=msg, text=True, encoding="utf-8")
        return commit_res.returncode
    except RuntimeError as e:
        print(f"error: {e}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    sys.exit(main())
