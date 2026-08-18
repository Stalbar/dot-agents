#!/usr/bin/env bash
#
# name: commit
# purpose: format a kit commit message, stage files, show the diff, commit on confirmation
# usage: commit.sh "<short-summary>"
# example: bash .agents/commands/scripts/commit.sh "Fix deprecation warnings"
# created: 2026-08-18, by init-agent subagent (kit starter)
# params: summary from $1

set -euo pipefail

SUMMARY="${1:-}"
if [ -z "$SUMMARY" ]; then
  echo "usage: commit.sh \"<short-summary>\"" >&2
  exit 2
fi

if [ "${#SUMMARY}" -gt 50 ]; then
  echo "error: summary longer than 50 characters" >&2
  exit 2
fi

if [ -z "$(git status --porcelain)" ]; then
  echo "nothing to commit" >&2
  exit 2
fi

git add -A

BODY=""
while IFS= read -r name; do
  NAME="$name"
  if [ "${#NAME}" -gt 72 ]; then
    NAME="${NAME:0:69}..."
  fi
  BODY="${BODY}- ${NAME}
"
done < <(git diff --cached --name-only | head -n 30)

MSG="${SUMMARY}

Detailed explanation of changes:
${BODY}
Benefits:
-

ADR:
Change plans:

-
"

echo "---- staged diff (stat) ----"
git diff --cached --stat
echo "---- commit message ----"
printf '%s' "$MSG"
echo "------------------------"

read -r -p "Commit? [y/N] " answer
case "$answer" in
  y|Y|yes)
    printf '%s' "$MSG" | git commit -F -
    ;;
  *)
    echo "aborted, nothing committed"
    exit 3
    ;;
esac
