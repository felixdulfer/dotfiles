#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$REPO_DIR/scripts/util.sh"

title "System Update"

step "Updating Homebrew"
brew update && brew upgrade && brew cleanup || warn "brew update issues"

step "Updating Oh My Zsh + plugins"
if [[ -d "${ZSH:-$HOME/.oh-my-zsh}" ]]; then
  (cd "${ZSH:-$HOME/.oh-my-zsh}" && git pull --ff-only) || warn "oh-my-zsh update failed"
  for d in "${ZSH_CUSTOM:-${ZSH:-$HOME/.oh-my-zsh}/custom}"/plugins/*; do
    [[ -d "$d/.git" ]] || continue
    (cd "$d" && git pull --ff-only) || warn "plugin update failed: $d"
  done
fi

step "Updating global npm, yarn, pnpm packages (if installed)"
command -v npm >/dev/null 2>&1 && npm update -g || true
command -v yarn >/dev/null 2>&1 && yarn global upgrade || true
command -v pnpm >/dev/null 2>&1 && pnpm add -g pnpm@latest || true

step "Cleaning old logs / caches (light)"
rm -rf ~/Library/Caches/* 2>/dev/null || true

success "Update complete."