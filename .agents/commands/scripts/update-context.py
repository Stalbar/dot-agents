#!/usr/bin/env python3
#
# name: update-context
# purpose: update context.md date and optionally append daily memory log entry
# usage: update-context.py [--date YYYY-MM-DD] [--log "summary message"]
# example: python .agents/commands/scripts/update-context.py --log "Completed auth unit tests"
# created: 2026-08-18, updated with memory logging
# params: optional --date, optional --log; stdlib only

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

DAILY_HEADER = """# Daily Memory Log: {date}

"""


def main(argv=None):
    parser = argparse.ArgumentParser(
        description="Update context.md and optionally log daily memory entry."
    )
    parser.add_argument("--date", help="YYYY-MM-DD (default: today)")
    parser.add_argument("--log", help="Append an entry to today's memory log")
    args = parser.parse_args(argv)

    root = Path(__file__).resolve().parents[2]
    agents_dir = root / ".agents"
    ctx = agents_dir / "context.md"
    memory_dir = agents_dir / "memory"
    date = args.date or datetime.date.today().isoformat()

    # Update context.md
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

    # If log message provided, append to daily log in memory/
    if args.log:
        memory_dir.mkdir(parents=True, exist_ok=True)
        daily_file = memory_dir / f"{date}.md"
        if not daily_file.exists():
            daily_file.write_text(DAILY_HEADER.format(date=date), encoding="utf-8")
        
        now_time = datetime.datetime.now().strftime("%H:%M")
        with daily_file.open("a", encoding="utf-8") as f:
            f.write(f"\n### [{now_time}] Update\n- {args.log}\n")
        print(f"Logged to {daily_file}")

    print(ctx)
    return 0


if __name__ == "__main__":
    sys.exit(main())
