---
name: project-init
description: "Use when initializing or bootstrapping .agents governance in a new or existing repository. Do not use for day-to-day feature development or bug fixes."
---

# Project Initialization (`/project-init`)

Adapts the `.agents` governance kit to a project's architecture, tech stack, and conventions.

## Workflow

1. **Self-Bootstrap:** Verify `.agents/AGENTS.md` and core skills exist.
2. **Grill-Me Interview:** Conduct an interactive interview via `/grill-me` (ask one question at a time, recommended default first):
   - Target harnesses (Antigravity, DSH, Claude Code).
   - Project name, domain purpose, languages, and runtime versions.
   - Frameworks (web, ORM, CLI), package managers, build tools.
   - Test framework and exact full-suite test command.
   - Linters, formatters, and pre-commit commands.
   - Databases, environment configuration files, external services.
3. **Fill Project Runtime Docs:** Populate the following files from `.agents/skills/project-init/assets/`:
   - `.agents/project_overview.md`
   - `.agents/architecture.md`
   - `.agents/coding_standards.md`
   - `.agents/USER.md`
4. **Initialize Context:**
   - Execute: `python .agents/skills/project-init/scripts/update-context.py --log "Initialized project governance"`
5. **Scout Stack Skills:**
   - Use `/find-skills` to discover and install any language- or framework-specific skills matching the project's stack.
6. **Configure Harness Entry Points:**
   - Ensure root bootstrap files exist: `AGENTS.md`, `CLAUDE.md`, and `GEMINI.md` pointing to `.agents/AGENTS.md`.
