# .agents Governance

Entry point for AI agents in this repository. Portable across Antigravity and DeepSeek Harness (`dsh`).

## 1. Core Engineering & Communication Invariants

- **Truthful & Direct:** Code and verified facts first. No filler, throat-clearing, marketing fluff, or cheerleading endings. Keep explanations under 3 lines unless a report is requested.
- **YAGNI & Simplicity (Ponytail):** Standard library first. Shortest working diffs. No unrequested abstractions, premature generalizations, or speculative config.
- **Never Change Code Without Approval:** No file changes without an approved Change Plan (Gate R3) or explicit user instruction ("Implement <ref>").
- **Security Guardrails:** Never print, commit, or hardcode secrets or credentials. Always use parameterized queries and validate input at trust boundaries.
- **Modularity & Reachability:** Keep functions under 50 lines and modules under 300 lines. Pure logic at the core, I/O at edges. Confirm newly added symbols have active callers from production entry points (zero callers = dead code).
- **Verification Before Completion:** No completion claims without fresh verification evidence. Always run tests and verify output before declaring done.
- **Gate Protocol & Strict Approval:** After producing any planning artifact, STOP and present the path, a short summary, a verification checklist, and "Awaiting your review".
  - Approval syntax is strictly: `APPROVED`, `Approve <gate-id>` (e.g. `Approve R2`), or `Approved: <path>`. Generic words (ok, proceed, do it) are NOT approval.

## 2. Artifact-Driven Workflow Map

| Lifecycle Stage | Slash Command / Trigger | Primary Skill | Standard Output Artifact |
|---|---|---|---|
| Architectural Decision | `/adr` | `skills/adr` | `docs/00_adr/######-<title>.md` (Gate R1) |
| Feature / System Roadmap | `/writing-plans` | `skills/writing-plans` | `docs/01_implementation_plans/######-<title>.md` (Gate R2) |
| Scoped Change Plan (HOW) | `/writing-plans` | `skills/writing-plans` | `docs/02_change_plans/######-<title>.md` (Gate R3) |
| Pre-Implementation Tests | `/writing-plans` | `skills/writing-plans` | Failing tests + `docs/03_test_plans/######-<title>.md` (Gate R4) |
| Requirements & Trade-offs | `/grill-me` | `skills/grill-me` | Interactive 1-question interview |
| Minimal Implementation | `/ponytail` | `skills/ponytail` | Minimal working diffs (stdlib first) |
| Surgical Bug Diagnosis | `/systematic-debugging` | `skills/systematic-debugging` | 4-phase root cause fix + memory log |
| Verification & Completion | `/verification-before-completion` | `skills/verification-before-completion` | Fresh test evidence + `docs/02_change_plans/######-<title>-report.md` |
| Code & Cross-Model Review | `/code-review-excellence` | `skills/code-review-excellence` | Advisory structured review |
| Git Commit | `/git-commit` | `skills/git-commit` | Standardized imperative commit |
| Project Init & Skill Scout | `/project-init` / `/find-skills` | `skills/project-init`, `skills/find-skills` | Runtime docs (`.agents/*.md`) + stack skills |

## 3. Project Context Files

- `.agents/project_overview.md`: High-level domain purpose and core stack.
- `.agents/architecture.md`: System components, boundaries, and data flows.
- `.agents/coding_standards.md`: Code formatting, style, and conventions.
- `.agents/credentials.md`: Locations and mechanisms for credentials (gitignored, no secrets).
- `.agents/context.md`: Current sprint state, recent changes, and active focus.
- `.agents/memory/YYYY-MM-DD.md`: Rolling daily log for session progress and debugging lessons.
*(If any context file is an empty stub, run `/project-init` to populate it).*

## 4. Working Style & Discipline

- Prioritize test verification: run tests before claiming success. If tests fail, fix the code, never the test.
- Maintain persistent daily logs in `.agents/memory/YYYY-MM-DD.md` during complex multi-step debugging.
