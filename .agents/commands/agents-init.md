---
description: Initialize the .agents kit for this project. Grill-me interview, template filling, local rules, skills, starter scripts.
argument-hint: none
---

# /agents-init - Initialize this project with .agents/

You are the init agent for this repository. A portable AI-governance kit lives in
`.agents/`. Adapt the kit to THIS project. Do not modify any project code and do
not start any development work.

## Step 0 - Self-bootstrap

If you have not read `.agents/AGENTS.md` yet, read it now. Continue with this
command afterwards.

## Step 1 - Read the kit

Read, in order: `.agents/AGENTS.md`, `.agents/workflow.md`, every file in
`.agents/rules/`, every template in `.agents/templates/`, and
`.agents/skills/MANIFEST.md`.

## Step 2 - Skills

You are free to download and install any appropriate skill into `.agents/skills/`.
Required skills: `grill-me` and `ponytail`. If either is missing, fetch or copy it
from an available source (ponytail: local
`~/.gemini/config/plugins/ponytail/.openclaw/skills/ponytail`, then its GitHub
repository; grill-me: `~/.agents/skills/grill-me` or a public registry).
Recommended: `web-search` and `code-navigation`. Record every skill you add
(name, source, date) in `skills/MANIFEST.md` and `context.md`.

## Step 3 - Grill-me interview

Use the `grill-me` skill on me. Ask one question at a time, each with your
recommended answer. Walk this decision tree in order:

1. Which AI coding agent(s) / harnesses will be used in this project?
   (e.g., Antigravity / Gemini CLI, Claude Code, Cursor, DSH / DeepSeek, OpenAI / Codex. Recommend the harness currently running.)
2. Project name and one-sentence purpose.
3. Main language(s) and versions.
4. Frameworks (web, ORM, CLI, data).
5. Package manager and core commands.
6. Test framework and the exact command that runs the full suite.
7. Lint/format tools and commands.
8. Databases/storage and any split (config vs analytics).
9. Infrastructure (containers, cloud, CI) and the files that define it.
10. Where environment variables are declared (all files that must stay in sync).
11. API framework and docs tool, if any.
12. Notebooks or scripts that must be importable, if any.
13. Documentation language (recommend: English).
14. External services and how credentials are provided.
15. Anything else that makes rules project-specific.

## Step 4 - Fill and generate

- Fill `architecture.md` (all 11 mandatory sections, including selected coding agents),
  `project_overview.md`, `coding_standards.md`, `credentials.md` from the templates
  with my answers. Replace every `{{PLACEHOLDER}}`.
- OVERWRITE GUARD: if a target file already exists, never overwrite silently.
  If the repo is under git, check `git diff` for that file; otherwise compare
  against the template default. If it contains customizations, ask me before
  overwriting. When overwriting, create a timestamped backup
  `<name>.bak-<date>` first.
- Generate `rules/*_local.md` from the matching `templates/rules/*.template.md`
  (only the ones that apply). Keep each generated file under 12,000 characters.
- Create `docs/00_adr/`, `docs/01_implementation_plans/`, `docs/02_change_plans/`,
  `docs/03_test_plans/`, each with a short README explaining numbering.
- Generate root bootstrap files ONLY for the coding agent(s) selected in Question 1:
  - `AGENTS.md` (root: universal base entry point, always created)
  - `GEMINI.md` (root: created only if Antigravity / Gemini is selected)
  - `CLAUDE.md` (root: created only if Claude Code is selected)
  - `.cursor/rules/agents.mdc` (created only if Cursor is selected)
  Do NOT generate files or rule directories for unselected harnesses.
- Static collision check: compare every command name in `commands/` against
  `commands/KNOWN-BUILTINS.md`. If a collision is found, STOP and ask me for a
  new name; do not rename files yourself.
- Create the starter scripts in `commands/scripts/`: `run-tests` (.sh and .ps1,
  argument `unit|integration|all`), `pre-commit-checks` (.sh and .ps1), `adr.sh`
  and `adr.py`, `completion-report.py`, `update-context.py`, `commit.sh` and
  `commit.py`. Each script gets a header comment: purpose, usage, parameters,
  example. Fill the test/lint commands from my grill-me answers.
- Write `context.md`: today's date, "Initialization complete", stack summary,
  skills installed, open questions.

## Step 5 - Report

List what you created, what I should verify, and confirm that no project code was
modified. Then stop and wait for me.
