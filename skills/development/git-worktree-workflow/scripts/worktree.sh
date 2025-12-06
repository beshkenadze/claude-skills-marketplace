#!/bin/bash
# Git Worktree Workflow Helper
# Manages worktree lifecycle: create, list, cleanup

set -e

COMMAND="${1:-help}"
shift || true

# Get the main repo directory name
get_repo_name() {
    basename "$(git rev-parse --show-toplevel)"
}

case "$COMMAND" in
    create)
        # Usage: worktree.sh create <worktree-name> <branch-name>
        WORKTREE_NAME="$1"
        BRANCH_NAME="$2"

        if [ -z "$WORKTREE_NAME" ] || [ -z "$BRANCH_NAME" ]; then
            echo "Usage: worktree.sh create <worktree-name> <branch-name>" >&2
            exit 1
        fi

        REPO_NAME=$(get_repo_name)
        WORKTREE_PATH="../$WORKTREE_NAME"

        echo "Creating worktree at $WORKTREE_PATH with branch $BRANCH_NAME..."
        git worktree add "$WORKTREE_PATH" -b "$BRANCH_NAME"

        # Symlink .claude settings if they exist
        if [ -d ".claude" ]; then
            echo "Symlinking .claude settings..."
            ln -s "../$REPO_NAME/.claude" "$WORKTREE_PATH/.claude"
        fi

        echo "Done. Worktree ready at $WORKTREE_PATH"
        git worktree list
        ;;

    list)
        git worktree list
        ;;

    cleanup)
        # Usage: worktree.sh cleanup <worktree-name> <branch-name>
        WORKTREE_NAME="$1"
        BRANCH_NAME="$2"

        if [ -z "$WORKTREE_NAME" ] || [ -z "$BRANCH_NAME" ]; then
            echo "Usage: worktree.sh cleanup <worktree-name> <branch-name>" >&2
            exit 1
        fi

        WORKTREE_PATH="../$WORKTREE_NAME"

        echo "Removing worktree at $WORKTREE_PATH..."
        git worktree remove "$WORKTREE_PATH"

        echo "Deleting branch $BRANCH_NAME..."
        git branch -d "$BRANCH_NAME"

        echo "Cleanup complete."
        git worktree list
        ;;

    cleanup-force)
        # Force cleanup (for unmerged branches)
        WORKTREE_NAME="$1"
        BRANCH_NAME="$2"

        if [ -z "$WORKTREE_NAME" ] || [ -z "$BRANCH_NAME" ]; then
            echo "Usage: worktree.sh cleanup-force <worktree-name> <branch-name>" >&2
            exit 1
        fi

        WORKTREE_PATH="../$WORKTREE_NAME"

        echo "Force removing worktree at $WORKTREE_PATH..."
        git worktree remove "$WORKTREE_PATH" --force 2>/dev/null || rm -rf "$WORKTREE_PATH"

        echo "Force deleting branch $BRANCH_NAME..."
        git branch -D "$BRANCH_NAME" 2>/dev/null || true

        echo "Cleanup complete."
        git worktree list
        ;;

    help|*)
        cat <<'EOF'
Git Worktree Workflow Helper

Commands:
  create <name> <branch>    Create worktree with new branch, symlink .claude
  list                      List all worktrees
  cleanup <name> <branch>   Remove worktree and delete merged branch
  cleanup-force <name> <branch>  Force remove (unmerged branches)
  help                      Show this help

Examples:
  # Create feature worktree
  ./worktree.sh create myapp-auth feature/oauth2

  # List worktrees
  ./worktree.sh list

  # Cleanup after merge
  ./worktree.sh cleanup myapp-auth feature/oauth2

  # Force cleanup (discards unmerged work)
  ./worktree.sh cleanup-force myapp-auth feature/oauth2
EOF
        ;;
esac
