---
description: Run a structured code review over files, folders, staged changes, or a commit range.
argument-hint: <path | staged | commit-range>
---

# /code-review <target>

Run a code review without modifying anything.

1. Delegate to the `code-reviewer` subagent (`.agents/agents/code-reviewer.md`).
2. Target resolution:
   - a path: review that file or folder
   - `staged`: review the staged git changes
   - a commit range (e.g. `HEAD~3..HEAD`): review those commits
3. The reviewer returns the structured report: Summary, Critical, Major,
   Minor, Positive Observations, Improvement Opportunities, Suggested Tests.

This command produces a report only. It never edits files and it is not a gate.
If the user wants a verdict for a specific gate, say so in the report summary.
