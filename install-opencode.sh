#!/usr/bin/env bash
set -euo pipefail

# OpenCode global config root.
OPENCODE_CONFIG_DIR_DEFAULT="$HOME/.config/opencode"
OPENCODE_CONFIG_DIR="${OPENCODE_CONFIG_DIR:-$OPENCODE_CONFIG_DIR_DEFAULT}"

# Repo source (can be overridden for testing or forks).
REPO_URL_DEFAULT="https://github.com/BryanHoo/superpowers-ccg.git"
REPO_URL="${REPO_URL:-$REPO_URL_DEFAULT}"

# Persistent local clone location.
SRC_DIR_DEFAULT="$OPENCODE_CONFIG_DIR/sources/superpowers-ccg"
SRC_DIR="${SRC_DIR:-$SRC_DIR_DEFAULT}"

TIMESTAMP="$(date +%Y%m%d-%H%M%S)"

usage() {
  cat <<'EOF'
Usage:
  bash ./install-opencode.sh

Environment overrides:
  OPENCODE_CONFIG_DIR  OpenCode config directory (default: ~/.config/opencode)
  REPO_URL             Git repo URL/path to clone (default: GitHub)
  SRC_DIR              Persistent clone directory (default: $OPENCODE_CONFIG_DIR/sources/superpowers-ccg)
EOF
}

die() {
  echo "ERROR: $*" >&2
  exit 1
}

need_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    die "missing required command: $1"
  fi
}

backup_path_if_exists() {
  local p="$1"

  # -L handles broken symlinks; -e handles normal paths.
  if [ -e "$p" ] || [ -L "$p" ]; then
    mv "$p" "${p}.bak-${TIMESTAMP}"
  fi
}

copy_dir_overwrite() {
  local src="$1"
  local dst="$2"

  [ -d "$src" ] || die "missing directory: $src"

  backup_path_if_exists "$dst"
  mkdir -p "$(dirname "$dst")"

  # Copy whole directory to destination path.
  cp -R "$src" "$dst"
}

copy_file_overwrite() {
  local src="$1"
  local dst="$2"

  [ -f "$src" ] || die "missing file: $src"

  backup_path_if_exists "$dst"
  mkdir -p "$(dirname "$dst")"
  cp "$src" "$dst"
}

main() {
  if [ "${1:-}" = "-h" ] || [ "${1:-}" = "--help" ]; then
    usage
    exit 0
  fi

  need_cmd git

  mkdir -p "$OPENCODE_CONFIG_DIR"
  mkdir -p "$(dirname "$SRC_DIR")"

  if [ -d "$SRC_DIR/.git" ]; then
    echo "Updating source repo: $SRC_DIR"
    git -C "$SRC_DIR" pull --ff-only
  else
    if [ -e "$SRC_DIR" ] || [ -L "$SRC_DIR" ]; then
      backup_path_if_exists "$SRC_DIR"
    fi

    echo "Cloning source repo: $REPO_URL -> $SRC_DIR"
    git clone "$REPO_URL" "$SRC_DIR"
  fi

  echo "Installing skills..."
  copy_dir_overwrite "$SRC_DIR/skills" "$OPENCODE_CONFIG_DIR/skills"

  echo "Installing commands..."
  mkdir -p "$OPENCODE_CONFIG_DIR/commands"
  for f in "$SRC_DIR"/commands/*.md; do
    [ -e "$f" ] || continue
    copy_file_overwrite "$f" "$OPENCODE_CONFIG_DIR/commands/$(basename "$f")"
  done

  echo "Installing agents..."
  copy_dir_overwrite "$SRC_DIR/agents" "$OPENCODE_CONFIG_DIR/agents"

  echo ""
  echo "Installed to: $OPENCODE_CONFIG_DIR"
  echo "Source repo:   $SRC_DIR"
  echo "Backups:       *.bak-${TIMESTAMP}"
  echo ""
  echo "Note: This installer does not create or install any hooks directory."
  echo "Next: restart OpenCode and try /superpowers-ccg-brainstorm or load a skill by name."
}

main "$@"
