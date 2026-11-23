#!/usr/bin/env bash
set -euo pipefail

usage() {
    echo "Usage: $0 <target-repo> [--force|-f]"
    exit 1
}

if [ $# -lt 1 ]; then
    usage
fi

TARGET_REPO="$1"
FORCE=false

if [ "${2:-}" = "--force" ] || [ "${2:-}" = "-f" ]; then
    FORCE=true
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$(cd "$TARGET_REPO" 2>/dev/null && pwd || true)"

if [ -z "$TARGET_DIR" ] || [ ! -d "$TARGET_DIR" ]; then
    echo "Error: Target repository directory does not exist: $TARGET_REPO" >&2
    exit 1
fi

if [ "$TARGET_DIR" = "$SCRIPT_DIR" ]; then
    echo "Error: Target repository cannot be the source dot-agents repository: $TARGET_REPO" >&2
    exit 1
fi

echo "Installing .agents kit into: $TARGET_DIR"

PROTECTED_FILES="project_overview.md architecture.md coding_standards.md context.md USER.md"

SOURCE_AGENTS="$SCRIPT_DIR/.agents"
TARGET_AGENTS="$TARGET_DIR/.agents"
mkdir -p "$TARGET_AGENTS"

# Note: Target-only custom skills in .agents/skills/ are naturally preserved since iteration only traverses source files.
# Copy .agents recursively while respecting protected files
cd "$SOURCE_AGENTS"
find . -mindepth 1 | while read -r item; do
    rel_path="${item#./}"
    src_item="$SOURCE_AGENTS/$rel_path"
    dst_item="$TARGET_AGENTS/$rel_path"

    # Exclude .git directory and contents (allow .gitignore and dotfiles)
    case "$rel_path" in
        .git|.git/*) continue ;;
        *__pycache__*|*.pyc|*.pyo) continue ;;
    esac

    if [ -d "$src_item" ]; then
        mkdir -p "$dst_item"
    else
        filename="$(basename "$rel_path")"
        dirname="$(dirname "$rel_path")"

        # Check protected files in root of .agents
        if [ "$dirname" = "." ] && echo "$PROTECTED_FILES" | grep -qw "$filename"; then
            if [ -f "$dst_item" ] && [ "$FORCE" = false ]; then
                echo "  [SKIP] Preserving existing: .agents/$rel_path"
                continue
            fi
        fi

        mkdir -p "$(dirname "$dst_item")"
        cp -f "$src_item" "$dst_item"
    fi
done

# Copy bootstrap files
for bfile in AGENTS.md CLAUDE.md GEMINI.md; do
    src_file="$SCRIPT_DIR/bootstrap/$bfile"
    dst_file="$TARGET_DIR/$bfile"
    if [ -f "$src_file" ]; then
        if [ -f "$dst_file" ] && [ "$FORCE" = false ]; then
            echo "  [SKIP] Preserving existing root pointer: $bfile"
        else
            cp -f "$src_file" "$dst_file"
            echo "  [COPY] Installed root pointer: $bfile"
        fi
    fi
done

echo ""
echo "Installation successful! Next steps:"
echo "1. cd "$TARGET_DIR""
echo "2. Run /project-init to configure the governance kit for your stack."
