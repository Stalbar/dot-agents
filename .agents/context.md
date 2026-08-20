# Current Context

**Last Updated:** 2026-08-18

## Recent Changes
- Bundled general-purpose, harness-independent skills into `.agents/skills/`: `grill-me`, `ponytail`, `code-navigation`, `systematic-debugging`, `verification-before-completion`, `token-thrift`, `writing-plans`, `code-review-excellence`, `tdd-testing`, `skill-hunter`, and `web-search`.
- Updated `skills/MANIFEST.md`.
- Updated `/agents-init` workflow to explicitly query for target coding agents during the interview and generate bootstrap pointers only for selected harnesses.
- Implemented workspace memory architecture: added `USER.md` (developer profile), `rules/memory.md`, and rolling `memory/` logs.
- Standardized `.agents/skills/` to the 4-part progressive disclosure architecture (`SKILL.md`, `scripts/`, `resources/`, `assets/`, `examples/`).
- Adopted core discipline patterns from `deepseek-harness-discipline`: Call-Graph Reachability Gate (`rules/modularity.md`), Oscillation Circuit Breaker (`token-thrift`, `systematic-debugging`), Gap Round reporting (`completion-report.template.md`, `verification-before-completion`), and Impact Mapping (`planner.md`, `change-plan.template.md`).
- Added specialized subagents `surgeon` (micro-fixes) and `hunter` (codebase sweeps).

## Current State

Not initialized.

## Known Issues

## Open Questions
