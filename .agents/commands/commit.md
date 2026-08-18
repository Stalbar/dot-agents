---
description: Format the commit message per the kit rules, stage files, show the diff, and commit after confirmation.
argument-hint: <short-summary>
---

# /commit <short-summary>

Prepare a commit per `.agents/rules/git-commit-messages.md`.

Execution block:

- POSIX: `bash .agents/commands/scripts/commit.sh "<short-summary>"`
- Cross-platform: `python .agents/commands/scripts/commit.py "<short-summary>"`

The script formats the message (summary < 50 chars, what was changed,
benefits, ADR and change plan refs), stages the files, shows the staged diff
and the message, and asks for confirmation before running `git commit`.

After the commit, report the commit hash and the message summary. If the user
declined, report that nothing was committed.
