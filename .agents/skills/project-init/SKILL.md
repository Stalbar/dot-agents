---
name: project-init
description: "Use when initializing or bootstrapping .agents governance in a new or existing repository. Do not use for day-to-day feature development or bug fixes."
---

# Project Initialization (`/project-init`)

Adapts the `.agents` governance kit to a project's architecture, tech stack, and conventions.

## Workflow

### 1. Auto-Scan Repository (Fingerprint First)
Before asking any questions, inspect repository configuration and manifest files to detect the tech stack:
- Project manifests: `package.json`, `tsconfig.json`, `pyproject.toml`, `setup.py`, `Cargo.toml`, `go.mod`, `pom.xml`, `build.gradle`, `*.csproj`, `*.sln`, `composer.json`
- Infrastructure: `Dockerfile`, `docker-compose.*`, Kubernetes/Helm manifests, Terraform files
- CI/CD workflows: `.github/workflows/`, `.gitlab-ci.yml`, `azure-pipelines.yml`
- Test & lint configs: `pytest.ini`, `jest.config.*`, `.eslintrc.*`, `ruff.toml`, etc.

Extract: languages, frameworks, package manager, linter/formatter commands, and test suite commands.

### 2. Targeted Confirmation (via `/grill-me` for Gaps Only)
Present the detected findings. Ask exactly one question at a time using `/grill-me` ONLY for missing or ambiguous details:
- Project domain purpose (if not obvious from README/manifests).
- Target coding harnesses (Antigravity, DSH, Claude Code).
- Exact full-suite test command (if multiple options exist or configuration is non-standard).

### 3. Populate Runtime Docs
Fill project documentation from `.agents/skills/project-init/assets/` using verified commands and findings:
- `.agents/project_overview.md` (from `project-overview.template.md`)
- `.agents/architecture.md` (from `architecture.template.md`)
- `.agents/coding_standards.md` (from `coding-standards.template.md`)
*(Note: `.agents/USER.md` is pre-populated with developer preferences and is only modified if the user explicitly requests changes).*

### 4. Initialize Context
Execute the context updater:
`python .agents/skills/project-init/scripts/update-context.py --log "Initialized project governance"`

### 5. Automatic Stack Skill Scouting
1. Derive 2-4 targeted search queries from the detected stack (e.g. `npx skills find django`, `npx skills find pytest`).
2. Shortlist at most 3-5 high-signal, non-overlapping candidate skills from reputable sources.
3. Present candidate skills in the approval table per `/find-skills` and await user confirmation.
4. Install approved skills using `npx skills add <owner/repo> --skill <name> --agent universal`.
5. Remind user to run `/skills reload` (Antigravity) or restart session (`dsh`).

### 6. Verify Root Entry Points
Verify that root `AGENTS.md` exists and points to `.agents/AGENTS.md`. Only create secondary entry pointers (`CLAUDE.md` or `GEMINI.md`) if explicitly requested by the user.
