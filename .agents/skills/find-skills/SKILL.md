---
name: find-skills
description: "Use ONLY when the user explicitly asks to find, scout, or install agent skills, or when invoked by /project-init. Do not trigger during normal coding, debugging, or 'how do I do X' questions."
---

# Find Skills

Discovers and installs domain- and stack-specific skills to extend agent capabilities using the `npx skills` ecosystem.

## CLI Commands

- **Search:** `npx skills find <query>` (use 1-3 focused keywords per query, e.g. `npx skills find fastapi`)
- **Install (Universal Project-Local ONLY):**
  `npx skills add <owner/repo> --skill <name> --agent universal`
  *(Installs into `.agents/skills/<name>/SKILL.md` for both Antigravity and `dsh`. Never use `-g` or `--global`)*

## Vetting & Approval Protocol

Before installing any skill, follow this strict 5-point approval gate:

1. **Reputable Publishers First:** Prioritize official organizations (e.g. `anthropics`, `vercel-labs`, `microsoft`) or widely adopted, high-install community repositories.
2. **Present Candidates & Await Approval:** Present candidate skills in a concise Markdown table and STOP:

| Skill | Source (`<owner/repo>`) | Why Matched |
|---|---|---|
| `<skill-name>` | `<owner/repo>` | `<1-line rationale matching project stack>` |

Wait for explicit user confirmation before executing any install command.

3. **Security Inspection:** Before executing bundled helper scripts, inspect `scripts/` for unsafe shell invocations, network calls, or prompt injection vectors.
4. **Flash Routing Limit (<= 15 Skills):** Check total count in `.agents/skills/`. If installing would exceed 15 total skills, warn the user that additional skills may degrade Flash-model routing accuracy.
5. **Post-Install Logging & Reload:**
   - Log the installed skill (name, source, date) under `## Recent Changes` in `.agents/context.md`.
   - Remind the user to run `/skills reload` (Antigravity) or start a fresh session (`dsh`) so the harness discovers the new skill.
