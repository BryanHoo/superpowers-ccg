#!/usr/bin/env bash
set -euo pipefail

temp_dir="$(mktemp -d)"
cleanup() {
  rm -rf "$temp_dir"
}
trap cleanup EXIT

export OPENCODE_CONFIG_DIR="$temp_dir"
export REPO_URL="$(pwd)"

bash ./install-opencode.sh

for dir in skills commands agents; do
  [ -d "$temp_dir/$dir" ]
done

src_repo="$temp_dir/sources/superpowers-ccg"

for agent in backend frontend coder code-reviewer; do
  [ -f "$temp_dir/agents/$agent.md" ]
  diff -q "$src_repo/agents/$agent.md" "$temp_dir/agents/$agent.md" > /dev/null
done
