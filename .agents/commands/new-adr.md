---
description: Create the next-numbered Architecture Decision Record from the kit template.
argument-hint: <title>
---

# /new-adr <title>

Create an ADR for the given decision.

1. Delegate to the `architect` subagent (`.agents/agents/architect.md`).
2. Create the file with the next number in `docs/00_adr/`.

Execution block:

- POSIX: `bash .agents/commands/scripts/adr.sh "<title>"`
- Windows / cross-platform: `python .agents/commands/scripts/adr.py "<title>"`

Then have the architect subagent fill every section of the created file from the
conversation and the codebase.

After the ADR is written, STOP at Gate R1. Present: the ADR path, a short
summary, a checklist of what to verify, and the phrase "Awaiting your review".
