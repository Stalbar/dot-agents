# .agents - Lean Portable AI Governance Kit

A modular, Anthropic Agent Skills-compliant governance framework optimized for Antigravity and DeepSeek Harness (`dsh`).

## Core Architecture

1. **Unified Skills Primitive:** All capabilities reside in flat directories at `.agents/skills/<kebab-case>/SKILL.md` with explicit routing boundaries.
2. **Artifact-Driven Workflow:**
   - **Gate R1:** Architecture Decision Records (`docs/00_adr/`) via `/adr`
   - **Gate R2:** Implementation Plans (`docs/01_implementation_plans/`) via `/writing-plans`
   - **Gate R3:** Change Plans (`docs/02_change_plans/`) via `/writing-plans`
   - **Gate R4:** Pre-implementation Tests (`docs/03_test_plans/`) via `/writing-plans`
   - **Stage E:** Implementation via `/ponytail` + Verification via `/verification-before-completion`
3. **Ultra-Lean Always-On Context:** `.agents/AGENTS.md` stays under 130 lines for Flash-model efficiency.
4. **Cross-Platform:** Pure Python 3 helpers with standard library only.
