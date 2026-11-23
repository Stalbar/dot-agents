---
name: find-skills
description: "Use when discovering, evaluating, and installing stack-specific or domain-specific agent skills into .agents/skills/. Do not use for invoking installed core skills."
---

# Find Skills

Discovers and installs domain- and stack-specific skills to extend agent capabilities.

## Workflow

1. **Identify Skill Need:** When encountering a specialized framework (e.g., Django, Next.js, Kubernetes) or language requiring specific conventions.
2. **Search Sources:**
   - Local plugin directories (e.g. `~/.gemini/config/plugins/`).
   - Anthropic Agent Skills repositories and public agent registries.
   - Web search using `/web-search` with specific library and task terms.
3. **Evaluation Criteria:**
   - Flat directory structure: `.agents/skills/<kebab-case>/SKILL.md`.
   - Valid YAML frontmatter: `name` matching directory, precise routing `description`.
   - Progressive disclosure: Procedural `SKILL.md` (< 150 lines), templates in `assets/`, checklists in `resources/`, Python scripts in `scripts/`.
   - Standard library and YAGNI first; reject bloated dependencies.
4. **Install & Verify:**
   - Install skill into `.agents/skills/<skill-name>/`.
   - Log installation in `.agents/context.md`.
