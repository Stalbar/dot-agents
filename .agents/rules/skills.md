# Skills

The kit bundles skills in `.agents/skills/`. The agent may download and install
more.

1. The agent is free to download and install any appropriate skill into
   `.agents/skills/` without a gate, during init or during normal work.
2. Before installing during normal work, say one sentence: "I want to add
   skill X because Y." Then proceed. Do not wait for approval.
3. Record every installed skill in `skills/MANIFEST.md`: name, source (path or
   URL), date. Note it in `context.md` too.
4. Never modify a bundled skill's content. Extend by adding a new skill.
5. Prefer skills that need no code execution on the user's machine. If a skill
   needs it, ask first.
6. Remove nothing without an explicit user request.
7. Downloaded skills are committed to git inside `.agents/skills/`, so the kit
   stays reproducible across machines and CI.
