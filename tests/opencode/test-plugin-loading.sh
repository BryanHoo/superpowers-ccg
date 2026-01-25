#!/usr/bin/env bash
# Test: OpenCode-only config checks
# Verifies that opencode.json and required skills exist in the repo
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

echo "=== Test: OpenCode-only config checks ==="

# Test 0: Verify repo root has opencode.json
echo "Test 0: Checking opencode.json in repo root..."
if [ -f "$REPO_ROOT/opencode.json" ]; then
    echo "  [PASS] opencode.json exists in repo root"
else
    echo "  [FAIL] opencode.json not found in repo root: $REPO_ROOT/opencode.json"
    exit 1
fi

# Test 1: Verify using-superpowers skill exists in repo
echo "Test 1: Checking using-superpowers skill exists in repo..."
if [ -f "$REPO_ROOT/skills/using-superpowers/SKILL.md" ]; then
    echo "  [PASS] using-superpowers skill exists in repo"
else
    echo "  [FAIL] using-superpowers skill not found in repo: $REPO_ROOT/skills/using-superpowers/SKILL.md"
    exit 1
fi

# Test 2: Verify OpenCode skills path exists in repo
echo "Test 2: Checking OpenCode skills path exists in repo..."
if [ -f "$REPO_ROOT/.opencode/skills/using-superpowers/SKILL.md" ]; then
    echo "  [PASS] OpenCode skills path exists in repo"
else
    echo "  [FAIL] OpenCode skills path not found in repo: $REPO_ROOT/.opencode/skills/using-superpowers/SKILL.md"
    exit 1
fi

# Test 3: Compliance scan for forbidden strings in README and skills
echo "Test 3: Checking forbidden strings in README and skills..."
forbidden_strings=(
    "mcp__codex__codex"
    "mcp__gemini__gemini"
    "model: sonnet"
    "model: haiku"
)
scan_paths=(
    "$REPO_ROOT/README.md"
    "$REPO_ROOT/README-zh.md"
    "$REPO_ROOT/skills"
)
for forbidden in "${forbidden_strings[@]}"; do
    match=$(grep -R -n -m 1 "$forbidden" "${scan_paths[@]}" || true)
    if [ -n "$match" ]; then
        echo "  [FAIL] Forbidden string found: $forbidden"
        echo "         $match"
        exit 1
    fi
done

echo "  [PASS] No forbidden strings found"

# Test 4: Compliance scan for Claude Code references in README files
echo "Test 4: Checking Claude Code references in README files..."
forbidden_readme_strings=(
    "Claude Code"
    "claude --version"
    "/plugin"
    "claude mcp add"
    "tests/claude-code"
)
readme_files=(
    "$REPO_ROOT/README.md"
    "$REPO_ROOT/README-zh.md"
)
for forbidden in "${forbidden_readme_strings[@]}"; do
    for readme_file in "${readme_files[@]}"; do
        match=$(grep -n -m 1 "$forbidden" "$readme_file" || true)
        if [ -n "$match" ]; then
            echo "  [FAIL] Forbidden string found in README: $forbidden"
            echo "         $readme_file:$match"
            exit 1
        fi
    done
done

echo "  [PASS] No Claude Code references found in README files"

# Test 5: Compliance scan for superpowers-ccg references in commands
echo "Test 5: Checking commands for superpowers-ccg references..."
commands_scan_paths=(
    "$REPO_ROOT/commands"
)
match=$(grep -R -n -m 1 "superpowers-ccg:" "${commands_scan_paths[@]}" || true)
if [ -n "$match" ]; then
    echo "  [FAIL] Forbidden string found in commands: superpowers-ccg:"
    echo "         $match"
    exit 1
fi

echo "  [PASS] No superpowers-ccg references found in commands"

echo ""
echo "=== All OpenCode-only checks passed ==="
