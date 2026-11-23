#!/usr/bin/env bash
set -euo pipefail

usage() {
    echo "Usage: $0 <target-repo> [--force|-f] [--all-pointers] [--local-ignore] [--dry-run]"
    exit 1
}

if [ $# -lt 1 ]; then
    usage
fi

TARGET_REPO="$1"
shift

FORCE=false
ALL_POINTERS=false
LOCAL_IGNORE=false
DRY_RUN=false

while [ $# -gt 0 ]; do
    case "$1" in
        --force|-f) FORCE=true ;;
        --all-pointers) ALL_POINTERS=true ;;
        --local-ignore) LOCAL_IGNORE=true ;;
        --dry-run) DRY_RUN=true ;;
        *) echo "Unknown option: $1" >&2; usage ;;
    esac
    shift
done

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
if [ "$DRY_RUN" = true ]; then
    echo "[DRY-RUN MODE] No files will be modified or deleted."
fi

PROTECTED_FILES="project_overview.md architecture.md coding_standards.md context.md USER.md"

SOURCE_AGENTS="$SCRIPT_DIR/.agents"
TARGET_AGENTS="$TARGET_DIR/.agents"
TARGET_MANIFEST="$TARGET_AGENTS/.kit-manifest"

# Step A: Upgrade tracking via .kit-manifest
if [ -f "$TARGET_MANIFEST" ]; then
    while IFS= read -r old_rel || [ -n "$old_rel" ]; do
        old_rel="$(echo "$old_rel" | xargs)"
        [ -z "$old_rel" ] && continue
        case "$old_rel" in
            \#*) continue ;;
            .agents/*) old_rel="${old_rel#.agents/}" ;;
        esac

        src_check="$SOURCE_AGENTS/$old_rel"
        dst_check="$TARGET_AGENTS/$old_rel"

        if [ ! -f "$src_check" ] && [ ! -d "$src_check" ]; then
            base_name="$(basename "$old_rel")"
            is_protected=false
            case "$old_rel" in
                */*) ;; # subpath
                *)
                    if echo "$PROTECTED_FILES" | grep -qw "$base_name"; then
                        is_protected=true
                    fi
                    ;;
            esac

            if [ "$is_protected" = false ] && [ -e "$dst_check" ]; then
                if [ "$DRY_RUN" = true ]; then
                    echo "  [DRY-RUN REMOVE] Obsolete file: .agents/$old_rel"
                else
                    rm -f "$dst_check"
                    echo "  [REMOVE] Obsolete file: .agents/$old_rel"
                fi
            fi
        fi
    done < "$TARGET_MANIFEST"

    # Prune empty directories in target .agents/skills
    if [ -d "$TARGET_AGENTS/skills" ]; then
        find "$TARGET_AGENTS/skills" -depth -mindepth 1 -type d | while read -r d; do
            [ ! -d "$d" ] && continue
            if [ -z "$(ls -A "$d" 2>/dev/null)" ]; then
                rel_empty="${d#$TARGET_AGENTS/}"
                if [ "$DRY_RUN" = true ]; then
                    echo "  [DRY-RUN REMOVE] Empty folder: .agents/$rel_empty"
                else
                    if rmdir "$d" 2>/dev/null; then
                        echo "  [REMOVE] Empty folder: .agents/$rel_empty"
                    fi
                fi
            fi
        done
    fi
fi

# Step B: Copy .agents directory
if [ "$DRY_RUN" = false ]; then
    mkdir -p "$TARGET_AGENTS"
fi

manifest_tmp="$(mktemp 2>/dev/null || echo "$TARGET_DIR/.manifest_tmp")"
trap 'rm -f "$manifest_tmp"' EXIT

cd "$SOURCE_AGENTS"
# Note: Target-only custom skills in .agents/skills/ are naturally preserved since iteration only traverses source files.
find . -mindepth 1 | while read -r item; do
    rel_path="${item#./}"
    src_item="$SOURCE_AGENTS/$rel_path"
    dst_item="$TARGET_AGENTS/$rel_path"

    # Exclude .git directory and contents (allow .gitignore and dotfiles)
    case "$rel_path" in
        .git|.git/*) continue ;;
        *__pycache__*|*.pyc|*.pyo) continue ;;
        .kit-manifest) continue ;;
        *.local.*) continue ;;
    esac

    if [ -d "$src_item" ]; then
        if [ "$DRY_RUN" = false ]; then
            mkdir -p "$dst_item"
        fi
    else
        echo "$rel_path" >> "$manifest_tmp"

        filename="$(basename "$rel_path")"
        dirname="$(dirname "$rel_path")"

        # Check protected files in root of .agents
        if [ "$dirname" = "." ] && echo "$PROTECTED_FILES" | grep -qw "$filename"; then
            if [ -f "$dst_item" ] && [ "$FORCE" = false ]; then
                if [ "$DRY_RUN" = true ]; then
                    echo "  [DRY-RUN SKIP] Preserving existing: .agents/$rel_path"
                else
                    echo "  [SKIP] Preserving existing: .agents/$rel_path"
                fi
                continue
            fi
        fi

        if [ "$DRY_RUN" = true ]; then
            echo "  [DRY-RUN COPY] .agents/$rel_path"
        else
            mkdir -p "$(dirname "$dst_item")"
            cp -f "$src_item" "$dst_item"
        fi
    fi
done

# Write .kit-manifest
commit_sha="$(git -C "$SCRIPT_DIR" rev-parse --short HEAD 2>/dev/null || true)"
if [ "$DRY_RUN" = true ]; then
    count="$(wc -l < "$manifest_tmp" 2>/dev/null || echo "0")"
    echo "  [DRY-RUN WRITE] Manifest: .agents/.kit-manifest ($count entries)"
else
    {
        if [ -n "$commit_sha" ]; then
            echo "# commit: $commit_sha"
        fi
        sort "$manifest_tmp"
    } > "$TARGET_MANIFEST"
fi

# Step C: Copy bootstrap pointers
if [ "$ALL_POINTERS" = true ]; then
    bootstrap_files="AGENTS.md CLAUDE.md GEMINI.md"
else
    bootstrap_files="AGENTS.md"
fi

for bfile in $bootstrap_files; do
    src_file="$SCRIPT_DIR/bootstrap/$bfile"
    dst_file="$TARGET_DIR/$bfile"
    if [ -f "$src_file" ]; then
        if [ -f "$dst_file" ] && [ "$FORCE" = false ]; then
            if [ "$DRY_RUN" = true ]; then
                echo "  [DRY-RUN SKIP] Preserving existing root pointer: $bfile"
            else
                echo "  [SKIP] Preserving existing root pointer: $bfile"
            fi
        else
            if [ "$DRY_RUN" = true ]; then
                echo "  [DRY-RUN COPY] Root pointer: $bfile"
            else
                cp -f "$src_file" "$dst_file"
                echo "  [COPY] Installed root pointer: $bfile"
            fi
        fi
    fi
done

# Step D: Local ignore via info/exclude
if [ "$LOCAL_IGNORE" = true ]; then
    exclude_path="$(git -C "$TARGET_DIR" rev-parse --git-path info/exclude 2>/dev/null || true)"
    if [ -z "$exclude_path" ]; then
        if [ -d "$TARGET_DIR/.git" ]; then
            exclude_path="$TARGET_DIR/.git/info/exclude"
        fi
    elif [[ "$exclude_path" != /* ]]; then
        exclude_path="$TARGET_DIR/$exclude_path"
    fi

    if [ -z "$exclude_path" ]; then
        echo "Warning: Target repository is not a git repository; skipping --local-ignore." >&2
    else
        missing_entries=()
        for ign in ".agents/" "AGENTS.md" "CLAUDE.md" "GEMINI.md" "skills-lock.json"; do
            if [ -f "$exclude_path" ] && grep -Fxq "$ign" "$exclude_path" 2>/dev/null; then
                :
            else
                missing_entries+=("$ign")
            fi
        done

        if [ ${#missing_entries[@]} -gt 0 ]; then
            if [ "$DRY_RUN" = true ]; then
                for m in "${missing_entries[@]}"; do
                    echo "  [DRY-RUN EXCLUDE] Add to info/exclude: $m"
                done
            else
                mkdir -p "$(dirname "$exclude_path")"
                touch "$exclude_path"
                if ! grep -Fq "# dot-agents (local)" "$exclude_path" 2>/dev/null; then
                    echo "" >> "$exclude_path"
                    echo "# dot-agents (local)" >> "$exclude_path"
                fi
                for m in "${missing_entries[@]}"; do
                    echo "$m" >> "$exclude_path"
                    echo "  [EXCLUDE] Added to info/exclude: $m"
                done
            fi
        fi
    fi
fi

if [ "$DRY_RUN" = false ]; then
    echo ""
    echo "Installation successful! Next steps:"
    echo "1. cd \"$TARGET_DIR\""
    echo "2. Run /project-init to configure the governance kit for your stack."
fi
