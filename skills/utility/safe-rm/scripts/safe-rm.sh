#!/usr/bin/env bash
set -euo pipefail

FORCE=false
TARGET=""

usage() {
    cat <<EOF
Usage: safe-rm [OPTIONS] <path>

Safe wrapper around rm -rf with protection for critical paths.

Options:
    -f, --force    Actually delete (default is dry-run)
    -h, --help     Show this help

Examples:
    safe-rm ./temp           # Dry-run, shows what would be deleted
    safe-rm --force ./temp   # Actually deletes ./temp
EOF
    exit 0
}

while [[ $# -gt 0 ]]; do
    case $1 in
        -f|--force)
            FORCE=true
            shift
            ;;
        -h|--help)
            usage
            ;;
        -*)
            echo "[ERROR] Unknown option: $1" >&2
            exit 2
            ;;
        *)
            TARGET="$1"
            shift
            ;;
    esac
done

if [[ -z "$TARGET" ]]; then
    echo "[ERROR] No path specified" >&2
    echo "Usage: safe-rm [--force] <path>" >&2
    exit 2
fi

if [[ ! -e "$TARGET" ]]; then
    echo "[ERROR] Path does not exist: $TARGET" >&2
    exit 2
fi

RESOLVED=$(cd "$(dirname "$TARGET")" 2>/dev/null && pwd)/$(basename "$TARGET")
RESOLVED=$(echo "$RESOLVED" | sed 's#//*#/#g' | sed 's#/$##')

HOME_DIR=$(eval echo ~)

PROTECTED_PATHS=(
    "/"
    "/bin"
    "/boot"
    "/dev"
    "/etc"
    "/lib"
    "/lib64"
    "/opt"
    "/proc"
    "/root"
    "/sbin"
    "/sys"
    "/usr"
    "/var"
    "/home"
    "/Users"
    "/Applications"
    "/System"
    "/Library"
    "$HOME_DIR"
    "$HOME_DIR/.ssh"
    "$HOME_DIR/.gnupg"
    "$HOME_DIR/.config"
    "$HOME_DIR/.local"
    "$HOME_DIR/.claude"
    "$HOME_DIR/.zshrc"
    "$HOME_DIR/.bashrc"
    "$HOME_DIR/.bash_profile"
    "$HOME_DIR/.profile"
)

is_protected() {
    local path="$1"

    for protected in "${PROTECTED_PATHS[@]}"; do
        if [[ "$path" == "$protected" ]]; then
            return 0
        fi
    done

    if [[ -d "$path/.git" ]] || [[ "$(basename "$path")" == ".git" ]]; then
        return 0
    fi

    local git_root
    if git_root=$(cd "$path" 2>/dev/null && git rev-parse --show-toplevel 2>/dev/null); then
        if [[ "$path" == "$git_root" ]]; then
            return 0
        fi
    fi

    return 1
}

if is_protected "$RESOLVED"; then
    echo "[BLOCKED] Protected path: $RESOLVED" >&2
    echo "Cannot delete protected paths even with --force" >&2
    exit 1
fi

if [[ "$FORCE" == true ]]; then
    rm -rf "$RESOLVED"
    echo "[DELETED] $RESOLVED"
    exit 0
else
    echo "[DRY-RUN] Would delete: $RESOLVED"
    if [[ -d "$RESOLVED" ]]; then
        count=$(find "$RESOLVED" -type f 2>/dev/null | wc -l | tr -d ' ')
        echo "[DRY-RUN] Contains $count files"
    fi
    echo "[DRY-RUN] Use --force to actually delete"
    exit 0
fi
