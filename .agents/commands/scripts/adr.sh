#!/usr/bin/env bash
#
# name: adr
# purpose: create the next-numbered ADR file from the kit template
# usage: adr.sh <title>
# example: bash .agents/commands/scripts/adr.sh "horizontal scaling"
# created: 2026-08-18, by init-agent subagent (kit starter)
# params: title from $1

set -euo pipefail

TITLE="${1:-}"
if [ -z "$TITLE" ]; then
  echo "usage: adr.sh <title>" >&2
  exit 2
fi

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
DIR="$ROOT/docs/00_adr"
TEMPLATE="$ROOT/.agents/templates/adr.template.md"

if [ ! -f "$TEMPLATE" ]; then
  echo "error: template not found: $TEMPLATE" >&2
  exit 2
fi

mkdir -p "$DIR"

SLUG=$(printf '%s' "$TITLE" | tr '[:upper:]' '[:lower:]' | tr -cs 'a-z0-9' '-' | sed 's/^-*//; s/-*$//')

if [ -z "$SLUG" ]; then
  echo "error: title produces an empty slug" >&2
  exit 2
fi

LAST=$(find "$DIR" -maxdepth 1 -type f -name '[0-9][0-9][0-9][0-9][0-9][0-9]-*.md' \
  | sed 's/.*\///' | sort | tail -n 1 | cut -c1-6)
if [ -z "$LAST" ]; then
  NUM="000001"
else
  NUM=$(printf '%06d' "$((10#$LAST + 1))")
fi

FILE="$DIR/$NUM-$SLUG.md"
if [ -e "$FILE" ]; then
  echo "error: $FILE already exists" >&2
  exit 2
fi

# Escape sed replacement special characters so the title is inserted literally.
ESCAPED_TITLE=$(printf '%s' "$TITLE" | sed -e 's/\\/\\\\/g' -e 's/&/\\&/g' -e 's/\//\\\//g')
sed "s/{{TITLE}}/$ESCAPED_TITLE/" "$TEMPLATE" > "$FILE"
echo "$FILE"
