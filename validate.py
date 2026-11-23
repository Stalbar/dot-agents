#!/usr/bin/env python3
"""Standard-library validation script for dot-agents.

Checks:
1. .agents/AGENTS.md line budget (<= 130 lines).
2. Skill discovery, kebab-case naming, frontmatter, and no nested SKILL.md.
3. Broken backticked slash commands and explicit .agents/ references in Markdown.
4. Python compilation (without creating __pycache__) and bash -n install.sh (if bash present).
"""

import json
import os
import py_compile
import re
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent
AGENTS_DIR = ROOT / ".agents"
SKILLS_DIR = AGENTS_DIR / "skills"


def check_agents_md():
    agents_md = AGENTS_DIR / "AGENTS.md"
    if not agents_md.exists():
        return False, [".agents/AGENTS.md does not exist"]

    lines = agents_md.read_text(encoding="utf-8").splitlines()
    if len(lines) > 130:
        return False, [f".agents/AGENTS.md has {len(lines)} lines (exceeds budget of 130)"]

    return True, []


def check_skills():
    errors = []
    if not SKILLS_DIR.exists():
        return False, [".agents/skills directory does not exist"]

    skill_dirs = [d for d in SKILLS_DIR.iterdir() if d.is_dir()]
    if len(skill_dirs) > 12:
        print(f"  Warning: Core skill count is {len(skill_dirs)} (> 12 recommended max).")

    kebab_pattern = re.compile(r"^[a-z0-9]+(-[a-z0-9]+)*$")

    for s_dir in skill_dirs:
        dir_name = s_dir.name
        if not kebab_pattern.match(dir_name):
            errors.append(f"Skill directory '{dir_name}' is not valid kebab-case")

        skill_file = s_dir / "SKILL.md"
        if not skill_file.exists():
            errors.append(f"Missing SKILL.md in {s_dir.relative_to(ROOT)}")
            continue

        # Check line count
        lines = skill_file.read_text(encoding="utf-8").splitlines()
        if len(lines) > 150:
            errors.append(f"{skill_file.relative_to(ROOT)} has {len(lines)} lines (exceeds 150)")

        # Check frontmatter
        if len(lines) < 3 or lines[0].strip() != "---":
            errors.append(f"{skill_file.relative_to(ROOT)} missing opening '---' frontmatter")
            continue

        try:
            closing_idx = lines[1:].index("---") + 1
        except ValueError:
            errors.append(f"{skill_file.relative_to(ROOT)} missing closing '---' frontmatter")
            continue

        fm_lines = lines[1:closing_idx]
        fm = {}
        for line in fm_lines:
            line = line.strip()
            if not line or line.startswith("#"):
                continue
            if ":" in line:
                k, v = line.split(":", 1)
                fm[k.strip()] = v.strip().strip("\"'")

        name = fm.get("name")
        desc = fm.get("description")

        if not name:
            errors.append(f"{skill_file.relative_to(ROOT)} missing 'name' in frontmatter")
        elif name != dir_name:
            errors.append(f"{skill_file.relative_to(ROOT)} frontmatter name '{name}' does not match folder '{dir_name}'")

        if not desc:
            errors.append(f"{skill_file.relative_to(ROOT)} missing or empty 'description' in frontmatter")

        # Check for nested SKILL.md files
        all_skills_in_dir = list(s_dir.glob("**/SKILL.md"))
        if len(all_skills_in_dir) > 1:
            nested = [str(p.relative_to(s_dir)) for p in all_skills_in_dir if p != skill_file]
            errors.append(f"Nested SKILL.md files found in {dir_name}: {nested}")

    return len(errors) == 0, errors


def check_references():
    errors = []
    known_skills = {d.name for d in SKILLS_DIR.iterdir() if d.is_dir()} if SKILLS_DIR.exists() else set()
    known_skills.add("skills")  # allowlist for `/skills reload`

    slash_cmd_pattern = re.compile(r"`/([a-z][a-z0-9-]+)`")
    agents_ref_pattern = re.compile(r"\.agents/([a-zA-Z0-9_./-]+)")

    md_files = list(AGENTS_DIR.glob("**/*.md")) + list((ROOT / "bootstrap").glob("**/*.md"))

    for md in md_files:
        rel_md = md.relative_to(ROOT)
        text = md.read_text(encoding="utf-8")

        # 1. Backticked slash commands
        for m in slash_cmd_pattern.finditer(text):
            cmd = m.group(1)
            if cmd not in known_skills:
                errors.append(f"{rel_md}: Unknown slash command `/{cmd}`")

        # 2. Explicit .agents/<path> file references
        for m in agents_ref_pattern.finditer(text):
            ref = m.group(0)
            # Skip placeholders containing <, *, or ######
            if any(c in ref for c in ["<", "*", "######"]):
                continue

            clean_ref = ref.rstrip("`.,;:)\"\'")
            # If path ends with slash, treat as directory check
            target_path = ROOT / clean_ref
            if not target_path.exists():
                errors.append(f"{rel_md}: Referenced path does not exist '{clean_ref}'")

    return len(errors) == 0, errors


def check_scripts():
    errors = []
    os.environ["PYTHONDONTWRITEBYTECODE"] = "1"

    # Find all python files
    py_files = [p for p in ROOT.rglob("*.py") if ".git" not in p.parts]

    with tempfile.TemporaryDirectory() as tmp_dir:
        tmp_path = Path(tmp_dir)
        for py in py_files:
            rel_py = py.relative_to(ROOT)
            dest_pyc = tmp_path / f"{py.stem}.pyc"
            try:
                py_compile.compile(str(py), cfile=str(dest_pyc), doraise=True)
            except py_compile.PyCompileError as e:
                errors.append(f"Python syntax error in {rel_py}: {e}")

    # Check bash script if bash is on PATH
    bash_bin = shutil.which("bash")
    if bash_bin:
        install_sh = ROOT / "install.sh"
        if install_sh.exists():
            res = subprocess.run([bash_bin, "-n", "install.sh"], cwd=str(ROOT), capture_output=True, text=True)
            if res.returncode != 0:
                errors.append(f"Bash syntax error in install.sh: {res.stderr.strip()}")
    else:
        print("  Notice: bash not found on PATH; skipped 'bash -n install.sh'.")

    return len(errors) == 0, errors


def check_evals():
    evals_file = ROOT / "evals" / "triggers.json"
    if not evals_file.exists():
        return True, []

    errors = []
    try:
        data = json.loads(evals_file.read_text(encoding="utf-8"))
    except Exception as e:
        return False, [f"Failed to parse evals/triggers.json: {e}"]

    if not isinstance(data, list):
        return False, ["evals/triggers.json must contain a JSON array"]

    if len(data) < 20:
        errors.append(f"evals/triggers.json should contain at least 20 cases, found {len(data)}")

    known_skills = {d.name for d in SKILLS_DIR.iterdir() if d.is_dir()} if SKILLS_DIR.exists() else set()

    for i, item in enumerate(data):
        if not isinstance(item, dict):
            errors.append(f"Item #{i} in evals/triggers.json is not an object")
            continue
        prompt = item.get("prompt")
        expected = item.get("expected_skill")
        note = item.get("note")

        if not prompt or not isinstance(prompt, str):
            errors.append(f"Item #{i} missing non-empty 'prompt'")
        if not note or not isinstance(note, str):
            errors.append(f"Item #{i} missing non-empty 'note'")
        if expected is not None and expected not in known_skills:
            errors.append(f"Item #{i} has unknown expected_skill '{expected}' (known: {sorted(known_skills)})")

    return len(errors) == 0, errors


def main():
    print("Running dot-agents validation...")
    checks = [
        ("AGENTS.md line budget", check_agents_md),
        ("Skill discovery and structure", check_skills),
        ("Broken reference sweep", check_references),
        ("Script syntax integrity", check_scripts),
        ("Evaluation dataset integrity", check_evals),
    ]

    all_passed = True
    for label, fn in checks:
        passed, issues = fn()
        if passed:
            print(f"  ✓ {label}")
        else:
            all_passed = False
            print(f"  ✗ {label}:")
            for issue in issues:
                print(f"    - {issue}")

    if not all_passed:
        print("\nValidation FAILED.")
        return 1

    print("\nValidation PASSED successfully.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
