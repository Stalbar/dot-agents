#!/usr/bin/env python3
#
# name: completion-report
# purpose: create a completion report for a change plan from the kit template
# usage: completion-report.py <change-plan-ref>
# example: python .agents/commands/scripts/completion-report.py 000012
# created: 2026-08-18, by init-agent subagent (kit starter)
# params: change-plan-ref = 6-digit number or path; stdlib only

import argparse
import re
import sys
from pathlib import Path


def main(argv=None):
    parser = argparse.ArgumentParser(
        description="Create a completion report for a change plan."
    )
    parser.add_argument(
        "change_plan_ref",
        help="6-digit number or path of the change plan in docs/02_change_plans/",
    )
    args = parser.parse_args(argv)

    root = Path(__file__).resolve().parents[2]
    cp_dir = root / "docs" / "02_change_plans"
    template = root / ".agents" / "templates" / "completion-report.template.md"

    if not template.exists():
        print(f"error: template not found: {template}", file=sys.stderr)
        return 2

    ref = args.change_plan_ref
    if re.fullmatch(r"\d{6}", ref):
        candidates = [
            p for p in sorted(cp_dir.glob(ref + "-*.md"))
            if not p.stem.endswith("-report")
        ]
        if not candidates:
            print(f"error: no change plan found for number {ref}", file=sys.stderr)
            return 2
        plan = candidates[0]
    else:
        plan = Path(ref)
        if not plan.is_absolute():
            plan = root / plan
        if not plan.exists():
            print(f"error: change plan not found: {plan}", file=sys.stderr)
            return 2

    report = cp_dir / (plan.stem + "-report.md")
    if report.exists():
        print(f"error: {report} already exists", file=sys.stderr)
        return 2

    content = template.read_text(encoding="utf-8").replace(
        "{{CHANGE_PLAN_REF}}", plan.name
    )
    report.write_text(content, encoding="utf-8")
    print(report)
    return 0


if __name__ == "__main__":
    sys.exit(main())
