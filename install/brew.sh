#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname ""${BASH_SOURCE[0]}"")/.." && pwd)"

if ! command -v brew >/dev/null 2>&1; then
  echo "[brew] Homebrew not found. Installing..."
  NONINTERACTIVE=1 /bin/bash -c "
    $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Add to PATH (Apple Silicon or Intel)
  if [[ -d /opt/homebrew/bin ]]; then
    eval "
    $(/opt/homebrew/bin/brew shellenv)"
  elif [[ -d /usr/local/Homebrew/bin ]]; then
    eval "
    $(/usr/local/Homebrew/bin/brew shellenv)"
  fi
fi

echo "[brew] Updating taps..."
brew update

echo "[brew] Installing bundle from Brewfile..."
if [[ -f "$REPO_DIR/Brewfile" ]]; then
  brew bundle --file "$REPO_DIR/Brewfile"
else
  echo "Brewfile not found at $REPO_DIR/Brewfile" >&2
  exit 1
fi

echo "[brew] Cleaning up..."
brew cleanup

echo "[brew] Done.
