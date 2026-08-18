---
name: skill-hunter
description: How to search for, download, install, and record new skills into .agents/skills/.
---

# Skill Hunter

The agent is free to download and install any appropriate skill into
`.agents/skills/`. This skill is the procedure.

1. Decide the skill solves a real recurring need. Say one sentence to the
   user: "I want to add skill X because Y." Then proceed. No waiting.
2. Search local sources first: `~/.agents/skills/`, plugin folders, the
   harness's skill directories. Then public registries and GitHub.
3. Prefer skills that need no code execution on the user's machine. If one
   needs it, ask first.
4. Install: create `.agents/skills/<name>/SKILL.md` with the skill content.
   Keep the frontmatter (name, description). Preserve license and source.
5. Record in `skills/MANIFEST.md`: name, status, source, date. Note it in
   `context.md`.
6. Never modify a bundled skill. Extend by adding a new skill.
7. Commit the new skill folder to git.
