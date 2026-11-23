# .agents - Lean Portable AI Governance Kit

A modular, Anthropic Agent Skills-compliant governance framework optimized for Antigravity and DeepSeek Harness (`dsh`).

## Core Architecture

1. **Unified Skills Primitive:** 10 core capabilities reside in flat directories at `.agents/skills/<kebab-case>/SKILL.md` with explicit routing boundaries.
2. **Core Skills Roster:**
   - `/adr` (`skills/adr`): Architectural Decision Records (Gate R1).
   - `/writing-plans` (`skills/writing-plans`): Implementation Plans (Gate R2), Change Plans (Gate R3), and Test Plans (Gate R4).
   - `/verification-before-completion` (`skills/verification-before-completion`): Verification evidence and completion reports.
   - `/code-review-excellence` (`skills/code-review-excellence`): Code review, hunter static sweep, and prose slop auditing.
   - `/git-commit` (`skills/git-commit`): Standardized imperative commits.
   - `/project-init` (`skills/project-init`): Project configuration and runtime doc scaffolding.
   - `/find-skills` (`skills/find-skills`): Dynamic stack-specific skill scouting.
   - `/systematic-debugging` (`skills/systematic-debugging`): 4-phase diagnosis, surgical fixes, and circuit breaker.
   - `/ponytail` (`skills/ponytail`): Minimal implementation mode (YAGNI, stdlib first).
   - `/grill-me` (`skills/grill-me`): 1-question interactive interview and trade-off alignment.
3. **Artifact-Driven Workflow:** 5 stages with 4 user approval gates producing reviewable Markdown artifacts in `docs/`.
4. **Ultra-Lean Always-On Context:** `.agents/AGENTS.md` stays under 50 lines for Flash-model efficiency.
5. **Cross-Platform:** Pure Python 3 helpers with standard library only.
