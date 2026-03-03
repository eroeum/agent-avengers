#!/usr/bin/env bash
set -euo pipefail

CLAUDE_DIR="${HOME}/.claude"
AGENTS_DIR="${CLAUDE_DIR}/agents"
SKILLS_DIR="${CLAUDE_DIR}/skills"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SRC_CLAUDE="${SCRIPT_DIR}/.claude"
SRC_CONFIG="${SCRIPT_DIR}/config"

# ---------- helpers ----------
info()  { printf '\033[1;34m==> %s\033[0m\n' "$*"; }
ok()    { printf '\033[1;32m  + %s\033[0m\n' "$*"; }
warn()  { printf '\033[1;33m  ! %s\033[0m\n' "$*"; }

installed=0
skipped=0
updated=0

install_file() {
  local src="$1" dest="$2"
  local dest_dir
  dest_dir="$(dirname "$dest")"
  mkdir -p "$dest_dir"

  if [ ! -f "$dest" ]; then
    cp "$src" "$dest"
    ok "installed $(basename "$dest")"
    installed=$((installed + 1))
  elif cmp -s "$src" "$dest"; then
    skipped=$((skipped + 1))
  else
    cp "$src" "$dest"
    ok "updated  $(basename "$dest")"
    updated=$((updated + 1))
  fi
}

# ---------- preflight ----------
if [ ! -d "$SRC_CLAUDE" ]; then
  echo "Error: .claude directory not found at ${SRC_CLAUDE}" >&2
  echo "Run this script from the agent-avengers repo root." >&2
  exit 1
fi

info "Installing agent-avengers into ${CLAUDE_DIR}"

# ---------- agents ----------
info "Agents -> ${AGENTS_DIR}"
for src in "${SRC_CLAUDE}"/agents/*.md; do
  [ -f "$src" ] || continue
  install_file "$src" "${AGENTS_DIR}/$(basename "$src")"
done

# ---------- skills ----------
info "Skills -> ${SKILLS_DIR}"
for src in "${SRC_CLAUDE}"/skills/*/SKILL.md; do
  [ -f "$src" ] || continue
  skill_name="$(basename "$(dirname "$src")")"
  install_file "$src" "${SKILLS_DIR}/${skill_name}/SKILL.md"
done

# ---------- settings ----------
info "Settings -> ${CLAUDE_DIR}/settings.json"
if [ -f "${SRC_CONFIG}/settings.json" ]; then
  install_file "${SRC_CONFIG}/settings.json" "${CLAUDE_DIR}/settings.json"
fi

# ---------- tmux ----------
info "Tmux -> ~/.tmux.conf"
if [ -f "${SRC_CONFIG}/tmux.conf" ]; then
  install_file "${SRC_CONFIG}/tmux.conf" "${HOME}/.tmux.conf"
fi

# ---------- summary ----------
echo ""
info "Done"
printf '  installed %d | updated %d | unchanged %d\n' \
  "$installed" "$updated" "$skipped"
echo ""
echo "Agents and skills are now available globally in Claude Code."
echo "Run 'claude' in any project to use them."
