#!/usr/bin/env python3
"""Create the next-numbered ADR file from the skill template."""

import argparse
import re
import sys
from pathlib import Path


def main(argv=None):
    parser = argparse.ArgumentParser(
        description="Create the next-numbered ADR file from the skill template."
    )
    parser.add_argument("title", help="ADR title")
    args = parser.parse_args(argv)

    skill_dir = Path(__file__).resolve().parents[1]
    root = skill_dir.parents[2]
    adr_dir = root / "docs" / "00_adr"
    template = skill_dir / "assets" / "adr.template.md"

    if not template.exists():
        print(f"error: template not found: {template}", file=sys.stderr)
        return 2

    slug = re.sub(r"[^a-z0-9]+", "-", args.title.lower()).strip("-")
    numbers = []
    if adr_dir.exists():
        for path in adr_dir.glob("[0-9][0-9][0-9][0-9][0-9][0-9]-*.md"):
            match = re.match(r"^(\d{6})-", path.name)
            if match:
                numbers.append(int(match.group(1)))
    number = (max(numbers) + 1) if numbers else 1

    adr_dir.mkdir(parents=True, exist_ok=True)
    target = adr_dir / f"{number:06d}-{slug}.md"
    if target.exists():
        print(f"error: {target} already exists", file=sys.stderr)
        return 2

    content = template.read_text(encoding="utf-8").replace("{{TITLE}}", args.title)
    target.write_text(content, encoding="utf-8")
    print(target)
    return 0


if __name__ == "__main__":
    sys.exit(main())
