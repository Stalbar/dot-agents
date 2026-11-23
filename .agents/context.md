# Current Context

**Last Updated:** 2026-11-23

## Recent Changes
- Refactored repository into lean Anthropic Agent Skills-compliant architecture.
- Replaced separate `agents/`, `commands/`, `prompts/`, and `rules/` layers with flat skills under `.agents/skills/`.
- Condensed `.agents/AGENTS.md` to under 100 lines for high Flash-model token efficiency.
- Preserved complete 5-stage / 4-gate artifact lifecycle (`docs/00_adr`, `docs/01_implementation_plans`, `docs/02_change_plans`, `docs/03_test_plans`).
- Replaced all platform-specific shell scripts with cross-platform Python 3 stdlib implementations.
- Folded testing discipline into `writing-plans` and renamed `skill-hunter` to `find-skills`.

## Current State
- Ready for active development under Antigravity and DSH harnesses.

## Next Steps
- Execute `/project-init` when configuring for specific project repositories.
