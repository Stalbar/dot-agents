# Skills

The kit bundles portable, modular skills in `.agents/skills/`. The agent may install more.

---

## 1. Standard Skill Anatomy

Every skill directory in `.agents/skills/<skill-name>/` follows this structure:

```
.agents/skills/<skill-name>/
├── SKILL.md            # Required: YAML frontmatter + concise workflow (< 100 lines)
├── scripts/            # Optional: Executable code (Python/Bash/PS1) for deterministic tasks
├── resources/          # Optional: Deep reference docs, checklists, schemas
├── assets/             # Optional: Templates, starter snippets, boilerplates
└── examples/           # Optional: Few-shot input/output demonstration pairs
```

---

## 2. Progressive Disclosure Principle (Token Efficiency)

To preserve context window capacity, skills follow a 3-tier loading model:

1. **Tier 1 (Manifest & Metadata)**: The agent sees only the `name` and `description` in YAML frontmatter.
2. **Tier 2 (Invocation)**: When triggered, the agent loads `SKILL.md` for core step-by-step instructions.
3. **Tier 3 (Execution on Demand)**: Supporting files in `resources/`, `scripts/`, or `assets/` are loaded only when the task requires them.

---

## 3. Skill Frontmatter Format

Every `SKILL.md` must start with YAML frontmatter containing explicit third-person trigger conditions:

```markdown
---
name: skill-name
description: "Use when [condition] to [action]. Explains exact triggering scope."
---
```

---

## 4. Installation and Governance

1. The agent is free to install appropriate skills into `.agents/skills/` without a gate.
2. Before installing during work, state in one sentence: *"I want to add skill X because Y."*
3. Record every installed skill in `skills/MANIFEST.md` with name, status, source, and date. Note it in `context.md`.
4. Prefer deterministic scripts in `scripts/` over asking LLMs to guess complex calculations.
5. Downloaded skills are committed to git inside `.agents/skills/` to ensure portability.
