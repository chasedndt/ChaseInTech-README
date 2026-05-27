#!/bin/bash
set -euo pipefail

# Only run in remote Claude Code on the web sessions
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(git -C "$(dirname "$0")/../.." rev-parse --show-toplevel 2>/dev/null || pwd)}"

echo "Setting up session environment for: $PROJECT_DIR"

# Ensure git is configured for the session
git config --global --get user.email >/dev/null 2>&1 || git config --global user.email "session@claude.code"
git config --global --get user.name >/dev/null 2>&1 || git config --global user.name "Claude Code"

# Verify we're in the right repo
cd "$PROJECT_DIR"
echo "Repository: $(git remote get-url origin 2>/dev/null || echo 'local')"
echo "Branch: $(git branch --show-current)"
echo "Session environment ready."
