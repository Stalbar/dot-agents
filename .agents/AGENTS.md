# .agents - Agent Governance Bootstrap

This file is the entry point for every AI agent working in this repository.
Follow it before doing anything else. It is agent- and harness-independent:
the same rules apply whether the agent runs in Antigravity (Gemini), DSH
(DeepSeek/MiMo), Claude Code, Cursor, or any other harness.

## 1. Read order

Before any work, read:

1. `.agents/workflow.md` - the process, stages, and gates
2. `.agents/rules/communication.md` - how to communicate with the user
3. Every other file in `.agents/rules/` - general rules (including `memory.md`, `skills.md`)
4. `.agents/USER.md` - developer profile, communication style, and preferences
5. `.agents/architecture.md` - project architecture (filled by `/agents-init`)
6. `.agents/context.md` - current project state (update it freely)
7. `.agents/coding_standards.md` - code style (filled by `/agents-init`)

## 2. Commands

When the user types `/name` or asks to "run name", read
`.agents/commands/name.md` and follow it exactly. If the command needs
arguments and none were given, ask for them first, one question at a time.

Command files end with an execution block that runs the matching script from
`.agents/commands/scripts/` through the wrappers defined in
`.agents/rules/scripts.md`. Never retype the script's logic inline.

If a command file is missing, say so and stop. Do not improvise a replacement.

## 3. The pipeline and gates

All significant work follows the 5-stage / 4-gate pipeline in
`.agents/workflow.md`:

```
ADR → [user review] → implementation plan → [user review] → change plan →
[user review] → unit tests → [user review] → implementation
```

- After producing an artifact (ADR, plan, tests), STOP and present it:
  artifact path, a short summary, a checklist of what to verify, and the
  phrase "Awaiting your review".
- Approval is only: `APPROVED` (standalone word), `Approve <gate-id>`
  (e.g. `Approve R2`), or `Approved: <artifact-path>`. Generic words like
  ok, proceed, apply, or "do it" are NOT approval. If the user uses one,
  ask: "Did you mean to approve this gate? Reply 'Approve <gate-id>'."
- Questions are never approval. "How would I fix X?" is a question.
- Reviewer subagent verdicts are advisory input for the user. Only the user
  approves a gate. There is no pre-delegation of gates.

## 4. Subagents

Delegate each stage to exactly one specialist subagent defined in
`.agents/agents/`:

- `architect` writes ADRs
- `planner` writes implementation plans and change plans
- `test-writer` writes tests (before implementation)
- `implementer` makes direct changes to project code
- `surgeon` performs isolated micro-fixes and targeted bug repairs
- `hunter` conducts read-only whole-codebase audits and sweeps
- `adr-reviewer`, `plan-reviewer`, `code-reviewer` produce verdicts only

Constraints:

- Only the `implementer` subagent writes project code. All other subagents
  propose text in `docs/` or `.agents/` (init-agent) or return reports.
- Give each subagent: the task, the template path, the paths of all approved
  artifacts it depends on, the relevant rules, and a read-only view of the
  repo. Subagents start from files, not from this conversation's memory.
- Never run subagents in parallel across a gate. A reviewer verdict never
  replaces user approval.

## 5. Rules that override everything

- Never modify `.agents/` files without an explicit user request, except
  `context.md`, `USER.md`, `memory/`, `skills/MANIFEST.md`, and new files the
  user asked to add.
- Never change files in the repository without explicit confirmation or an
  approved change plan.
- Implementation is complete only when the new tests AND the whole existing
  test suite pass. Never edit tests to make them pass - fix the code.
- Repeated action sequences become parametrized scripts in
  `commands/scripts/` (see `.agents/rules/scripts.md`).
- The agent is free to download and install any appropriate skill into
  `.agents/skills/` and must record it in `skills/MANIFEST.md`
  (see `.agents/rules/skills.md`).
