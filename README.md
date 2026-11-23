# dot-agents

A lean, modular, Anthropic Agent Skills-compliant AI governance kit for software repositories.

Optimized for:
- **Primary Harnesses:** Google Antigravity and DeepSeek Harness (`dsh`)
- **Primary Models:** Flash-tier models (`gemini-3.8-flash`, `deepseek v4.1 flash`, `glm-5.3-flash`)
- **Single Primitive:** 10 flat, unified skills discovering natively as `/` slash commands.
- **Ultra-Lean Always-On Context:** `.agents/AGENTS.md` under 50 lines with zero filler or emphasis inflation.

---

## 1. Artifact-Driven Engineering Lifecycle

All significant work follows a strict 5-stage, 4-gate workflow producing self-contained, reviewable Markdown artifacts:

```mermaid
flowchart LR
    A[Stage A: ADR] --> R1{Gate R1}
    R1 --> B[Stage B: Implementation Plan]
    B --> R2{Gate R2}
    R2 --> C[Stage C: Change Plan]
    C --> R3{Gate R3}
    R3 --> D[Stage D: Tests First]
    D --> R4{Gate R4}
    R4 --> E[Stage E: Implement]
    E --> F[Verification & Report]
```

| Lifecycle Stage | Trigger / Slash Command | Primary Skill | Standard Output Artifact | Review Gate |
|---|---|---|---|---|
| **Architectural Decision** | `/adr <title>` | `skills/adr` | `docs/00_adr/######-<title>.md` | Gate R1 (User Review) |
| **System Roadmap (WHAT)** | `/writing-plans` | `skills/writing-plans` | `docs/01_implementation_plans/######-<title>.md` | Gate R2 (User Review) |
| **Scoped Change Plan (HOW)** | `/writing-plans` | `skills/writing-plans` | `docs/02_change_plans/######-<title>.md` | Gate R3 (User Review) |
| **Pre-Implementation Tests** | `/writing-plans` | `skills/writing-plans` | Failing tests + `docs/03_test_plans/######-<title>.md` | Gate R4 (User Review) |
| **Trade-offs / Interview** | `/grill-me` | `skills/grill-me` | Interactive 1-question alignment | None |
| **Minimal Implementation** | `/ponytail` | `skills/ponytail` | Minimal working diffs (stdlib first) | None (Approved in R3/R4) |
| **Surgical Bug Diagnosis** | `/systematic-debugging` | `skills/systematic-debugging` | 4-phase root cause fix + circuit breaker | None |
| **Verification & Completion** | `/verification-before-completion` | `skills/verification-before-completion` | Verified test output + `...-report.md` | Informational |
| **Code & Artifact Review** | `/code-review-excellence` | `skills/code-review-excellence` | Advisory structured review | Advisory |
| **Git Commit** | `/git-commit` | `skills/git-commit` | Standardized imperative commit | User confirmation |
| **Bootstrap & Stack Scout** | `/project-init` / `/find-skills` | `skills/project-init`, `skills/find-skills` | Runtime docs (`.agents/*.md`) + stack skills | Initial setup |

---

## 2. Core Skills Roster (10 Skills)

Every skill resides in `.agents/skills/<kebab-case>/SKILL.md` with progressive disclosure (`assets/` for templates, `resources/` for checklists, `scripts/` for Python helpers):

1. **`adr`**: Record architectural decisions, trade-offs, and consequences (`scripts/adr.py`).
2. **`writing-plans`**: Author Implementation Plans, Change Plans, and Test Plans with test-first discipline.
3. **`verification-before-completion`**: Enforce fresh test evidence, call-graph reachability, and completion reports (`scripts/completion-report.py`).
4. **`code-review-excellence`**: 4-dimension reviews (correctness, security, simplicity, modularity), hunter static sweeps, and cross-model reviews (`scripts/audit-prose.py`).
5. **`git-commit`**: Standardized commit messages referencing ADRs and change plans (`scripts/commit.py`).
6. **`project-init`**: Adapt kit to target repo via `/grill-me`, scaffold runtime docs, and manage context (`scripts/update-context.py`).
7. **`find-skills`**: Discover and install stack-specific or domain-specific skills.
8. **`systematic-debugging`**: 4-phase diagnosis, minimal root-cause fixes, and oscillation circuit breaker.
9. **`ponytail`**: Minimalist implementation mode (YAGNI, standard library first, shortest working diffs).
10. **`grill-me`**: Adversarial design pressure-testing and 1-question interviews.

---

## 3. Quick Start: Install & Bootstrap

### Installation into a Target Repository

From this repository, run the installer pointing to your target project repository:

**PowerShell (Windows):**
```powershell
.\install.ps1 -TargetRepo "C:\path\to\your-project" [-LocalIgnore] [-AllPointers] [-DryRun] [-Force]
```

**Bash (Linux / macOS):**
```bash
./install.sh /path/to/your-project [--local-ignore] [--all-pointers] [--dry-run] [--force]
```

#### Installer Options & Flags

| Flag (PowerShell / Bash) | Description |
|---|---|
| `-TargetRepo <path>` / `<path>` | Path to target project repository (required). |
| `-LocalIgnore` / `--local-ignore` | Idempotently appends `.agents/`, root pointers (`AGENTS.md`, `CLAUDE.md`, `GEMINI.md`), `skills-lock.json`, and local planning artifact directories (`docs/00_adr/`, `docs/01_implementation_plans/`, `docs/02_change_plans/`, `docs/03_test_plans/`) to the target repo's git private exclude (`.git/info/exclude`), leaving project `.gitignore` untouched. |
| `-AllPointers` / `--all-pointers` | Copies `bootstrap/CLAUDE.md` and `bootstrap/GEMINI.md` in addition to default `bootstrap/AGENTS.md`. |
| `-DryRun` / `--dry-run` | Previews file copies, removals, and local ignore modifications without altering disk state. |
| `-Force` / `--force` | Overwrites existing context files and templates in target `.agents/`. |

#### Safe Upgrades with Manifest Tracking

The installer writes a `.agents/.kit-manifest` file containing all copied core kit file paths and a `# commit: <short-sha>` header:
- **Clean Pruning:** On subsequent runs/upgrades, files that existed in an older kit version but are no longer in source kit are cleanly deleted.
- **Safety Guarantee:** User-managed context files (`project_overview.md`, `architecture.md`, `coding_standards.md`, `context.md`, `USER.md`) and custom skills added by the user/team are **never** deleted or overwritten.
- **Tidy Tree:** Empty skill directories left behind by pruned files are automatically cleaned up.

### Bootstrap Your Project

Once installed, start an AI session in your target project and run:

```
/project-init
```

The agent will auto-scan your repository manifests (`package.json`, `pyproject.toml`, `*.csproj`, etc.) to detect stack dependencies and test runners, interview you via `/grill-me` for any missing domain context, populate `.agents/` runtime docs, and scout stack-specific skills.

---

## 4. Repository Governance & Evaluation Tooling

This repository includes standard-library verification and evaluation tooling located at the repository root (never bundled into target repositories):

### Repository Validation (`validate.py`)

Run the self-contained validator (requires Python 3.8+ standard library only):

```bash
python validate.py
```

Checks enforced:
1. **Always-On Context Budget:** Ensures `.agents/AGENTS.md` remains $\le 130$ lines for optimal Flash-model attention.
2. **Skill Discovery & Standards:** Verifies all skills reside in flat kebab-case directories, contain valid YAML frontmatter matching directory names, keep `SKILL.md` $\le 150$ lines, and have no nested skills.
3. **Broken Reference Sweep:** Scans all `.md` files for unknown backticked slash commands and broken `.agents/` path references.
4. **Script Syntax Integrity:** Compiles all Python helpers using `py_compile` (in-memory without producing `__pycache__`) and validates shell script syntax (`bash -n install.sh`).
5. **Evaluation Dataset Integrity:** Validates that `evals/triggers.json` contains valid benchmark test cases and routing expectations.

### Flash-Tier Routing Benchmark (`evals/triggers.json`)

Contains a 26-prompt evaluation dataset designed to test skill routing accuracy across Flash-tier models (`gemini-3.8-flash`, `deepseek v4.1 flash`, `glm-5.3-flash`):
- **Positive Triggers (20 prompts):** 2 realistic prompts for each of the 10 core skills.
- **Negative Controls (6 prompts):** 6 routine programming requests with `"expected_skill": null` to verify models do not falsely trigger governance skills for standard single-line edits, read-only questions, or generic language lookups.

