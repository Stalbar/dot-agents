# Skills Manifest

Status: bundled (ships with the kit) | downloaded (added later, committed).

| Skill | Status | Source | Installed |
|-------|--------|--------|-----------|
| grill-me | bundled | ~/.agents/skills/grill-me (DSH native) | 2026-08-18 |
| ponytail | bundled | ~/.gemini/config/plugins/ponytail/.openclaw/skills/ponytail; GitHub: https://github.com/DietrichGebert/ponytail (MIT) | 2026-08-18 |
| tdd-testing | bundled | kit-authored | 2026-08-18 |
| skill-hunter | bundled | kit-authored | 2026-08-18 |
| web-search | bundled | ~/.agents/skills/web-search (DSH: pi-web-access tools) | 2026-08-18 |
| code-navigation | bundled | ~/.agents/skills/code-navigation | 2026-08-18 |
| systematic-debugging | bundled | kit-authored | 2026-08-18 |
| verification-before-completion | bundled | kit-authored | 2026-08-18 |
| token-thrift | bundled | kit-authored | 2026-08-18 |
| writing-plans | bundled | kit-authored | 2026-08-18 |
| code-review-excellence | bundled | kit-authored | 2026-08-18 |

## Harness mapping

- DSH: reads `.agents/skills/<name>/SKILL.md` natively.
- Antigravity: map this folder to its skill mechanism during `/agents-init`.
- Claude Code: reads skill folders as project skills.
- Other harnesses: `AGENTS.md` treats `skills/` as reference material; follow
  the SKILL.md content when the task matches its description.

## Recording rules

Every new skill must be added to this table with name, status, source, and
date. Bundled skills must never be modified in place. Downloaded skills are
committed to git.
