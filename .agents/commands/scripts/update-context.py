#!/usr/bin/env python3
#
# name: update-context
# purpose: update the Last Updated date in .agents/context.md; create the file if missing
# usage: update-context.py [--date YYYY-MM-DD]
# example: python .agents/commands/scripts/update-context.py
# created: 2026-08-18, by init-agent subagent (kit starter)
# params: optional --date; stdlib only

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
        description="Update the Last Updated date in .agents/context.md."
    )
    parser.add_argument("--date", help="YYYY-MM-DD (default: today)")
    args = parser.parse_args(argv)

    root = Path(__file__).resolve().parents[2]
    ctx = root / ".agents" / "context.md"
    date = args.date or datetime.date.today().isoformat()

    if not ctx.exists():
        ctx.write_text(SKELETON.format(date=date), encoding="utf-8")
        print(ctx)
        return 0

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
    print(ctx)
    return 0


if __name__ == "__main__":
    sys.exit(main())
