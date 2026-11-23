#!/usr/bin/env python3
"""Update context.md date and optionally append recent changes."""

import argparse
import datetime
import re
import sys
from pathlib import Path

SKELETON = """# Current Context

**Last Updated:** {date}

## Recent Changes

## Current State

## Known Issues

## Open Questions
"""


def main(argv=None):
    parser = argparse.ArgumentParser(
        description="Update context.md date and optionally append a change entry."
    )
    parser.add_argument("--date", help="YYYY-MM-DD (default: today)")
    parser.add_argument("--log", help="Append an entry under ## Recent Changes in context.md")
    args = parser.parse_args(argv)

    skill_dir = Path(__file__).resolve().parents[1]
    root = skill_dir.parents[2]
    agents_dir = root / ".agents"
    ctx = agents_dir / "context.md"
    date = args.date or datetime.date.today().isoformat()

    if not ctx.exists():
        ctx.write_text(SKELETON.format(date=date), encoding="utf-8")
    else:
        text = ctx.read_text(encoding="utf-8")
        updated, count = re.subn(
            r"\*\*Last Updated:\*\*.*",
            f"**Last Updated:** {date}",
            text,
            count=1,
        )
        if count == 0:
            updated = text + f"\n**Last Updated:** {date}\n"
        ctx.write_text(updated, encoding="utf-8")

    if args.log:
        text = ctx.read_text(encoding="utf-8")
        entry = f"- [{date}] {args.log}\n"
        if "## Recent Changes" in text:
            parts = text.split("## Recent Changes", 1)
            updated = parts[0] + "## Recent Changes\n" + entry + parts[1].lstrip("\n")
            ctx.write_text(updated, encoding="utf-8")
        else:
            ctx.write_text(text + f"\n## Recent Changes\n{entry}", encoding="utf-8")
        print(f"Logged entry to {ctx}")

    print(ctx)
    return 0


if __name__ == "__main__":
    sys.exit(main())
