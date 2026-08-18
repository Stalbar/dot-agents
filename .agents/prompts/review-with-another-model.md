# Review with another model

Use this when you want a second model to review an artifact at a gate. Copy
the prompt below, paste it into the other model (the same harness or the
other one; ideally a different model than the producer), fill in the
placeholders, and paste the verdict back into this conversation.

Verdicts are advisory. You still approve the gate yourself with `Approve <gate-id>`.

---

You are reviewing `<artifact-path>` for a project governed by `.agents/`.
Read the artifact, the checklist in `.agents/agents/<reviewer>.md`, and
`.agents/rules/`. Return a verdict (approve, approve-with-changes, or reject)
plus issues grouped by severity (critical, major, minor). Do not modify any
files.

Reviewer choices per gate:

- Gate R1 (ADR): `.agents/agents/adr-reviewer.md`
- Gate R2/R3 (plans): `.agents/agents/plan-reviewer.md`
- Gate R4 (tests): `.agents/agents/code-reviewer.md`
- General: `.agents/agents/code-reviewer.md`
