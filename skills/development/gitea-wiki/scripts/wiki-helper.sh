#!/bin/bash
# Gitea Wiki Helper - handles base64 encoding/decoding for wiki content

set -e

COMMAND="${1:-help}"
shift || true

case "$COMMAND" in
  decode)
    # Decode base64 content from stdin or argument
    if [ -n "$1" ]; then
      echo "$1" | base64 -d
    else
      base64 -d
    fi
    ;;

  encode)
    # Encode content to base64 from stdin or file
    if [ -n "$1" ] && [ -f "$1" ]; then
      base64 < "$1"
    else
      base64
    fi
    ;;

  read)
    # Read wiki page and decode: wiki-helper.sh read <owner> <repo> <pageName>
    OWNER="$1"
    REPO="$2"
    PAGE="$3"

    if [ -z "$OWNER" ] || [ -z "$REPO" ] || [ -z "$PAGE" ]; then
      echo "Usage: wiki-helper.sh read <owner> <repo> <pageName>" >&2
      exit 1
    fi

    # This outputs instructions - actual MCP call done by Claude
    echo "Use mcp__gitea__get_wiki_page with owner=$OWNER, repo=$REPO, pageName=$PAGE"
    echo "Then pipe content_base64 to: echo '<content>' | base64 -d"
    ;;

  prepare)
    # Prepare content for wiki update: wiki-helper.sh prepare <file>
    FILE="$1"
    if [ -z "$FILE" ]; then
      echo "Usage: wiki-helper.sh prepare <file_or_stdin>" >&2
      echo "Reads content and outputs base64 for use with create/update_wiki_page" >&2
      exit 1
    fi

    if [ -f "$FILE" ]; then
      base64 < "$FILE" | tr -d '\n'
    else
      echo "$FILE" | base64 | tr -d '\n'
    fi
    ;;

  help|*)
    cat <<EOF
Gitea Wiki Helper - Handle base64 encoding/decoding for wiki content

Commands:
  decode [base64]     Decode base64 content (stdin or argument)
  encode [file]       Encode file/stdin to base64
  prepare <file>      Prepare file content as base64 (no newlines)
  help                Show this help

Examples:
  # Decode wiki content from MCP response
  echo "SGVsbG8gV29ybGQ=" | ./wiki-helper.sh decode

  # Prepare content for wiki update
  ./wiki-helper.sh prepare my-page.md

  # Encode stdin
  echo "# My Wiki Page" | ./wiki-helper.sh encode
EOF
    ;;
esac
