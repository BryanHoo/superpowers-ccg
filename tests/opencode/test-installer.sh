#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

echo "=== Test: Installer scripts exist ==="

if [ ! -f "$REPO_ROOT/install-opencode.sh" ]; then
  echo "  [FAIL] install-opencode.sh missing"
  exit 1
fi

# Syntax check (does not execute)
bash -n "$REPO_ROOT/install-opencode.sh"

echo "  [PASS] install-opencode.sh exists and parses"
