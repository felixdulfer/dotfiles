#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$REPO_DIR/scripts/util.sh"

YES=0
DRY_RUN=0
APPLY_MACOS=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --yes|-y) YES=1 ;;
    --dry-run) DRY_RUN=1 ;;
    --macos) APPLY_MACOS=1 ;;
    --help|-h)
      cat <<EOF
Usage: $0 [options]
  --yes,-y       Non-interactive (assume yes)
  --dry-run      Show actions only
  --macos        Apply macOS defaults
  --help         Show this help
EOF
      exit 0 ;;
    *) echo "Unknown arg: $1" >&2; exit 1 ;;
  esac
  shift
done

title "Dotfiles Bootstrap"

step "Ensuring Homebrew + packages"
if [[ $DRY_RUN -eq 0 ]]; then bash "$REPO_DIR/install/brew.sh"; else echo "(dry-run) brew.sh"; fi

step "Installing Oh My Zsh + plugins"
if [[ $DRY_RUN -eq 0 ]]; then bash "$REPO_DIR/install/oh-my-zsh.sh"; else echo "(dry-run) oh-my-zsh.sh"; fi

step "Linking dotfiles"
if [[ $DRY_RUN -eq 0 ]]; then bash "$REPO_DIR/bin/link-dotfiles" ${YES:+--yes}; else echo "(dry-run) link-dotfiles"; fi

if [[ $APPLY_MACOS -eq 1 ]]; then
  step "Applying macOS defaults"
  if [[ $DRY_RUN -eq 0 ]]; then bash "$REPO_DIR/macos/defaults.sh"; else echo "(dry-run) macos/defaults.sh"; fi
fi

success "Bootstrap complete."
echo "Open a new shell or run: exec zsh"