#!/usr/bin/env bash
set -euo pipefail

ZSH_DIR="${ZSH:-$HOME/.oh-my-zsh}"

if [[ ! -d "$ZSH_DIR" ]]; then
  echo "[oh-my-zsh] Installing Oh My Zsh..."
  RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "[oh-my-zsh] Already installed. Skipping."
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$ZSH_DIR/custom}"

declare -A plugins=(
  [zsh-autosuggestions]=https://github.com/zsh-users/zsh-autosuggestions.git
  [zsh-syntax-highlighting]=https://github.com/zsh-users/zsh-syntax-highlighting.git
  [zsh-completions]=https://github.com/zsh-users/zsh-completions.git
)

for name in "${!plugins[@]}"; do
  target="$ZSH_CUSTOM/plugins/$name"
  if [[ -d "$target/.git" ]]; then
    echo "[oh-my-zsh] Updating $name"
    git -C "$target" pull --ff-only || true
  else
    echo "[oh-my-zsh] Cloning $name"
    git clone --depth 1 "${plugins[$name]}" "$target"
  fi
done

echo "[oh-my-zsh] Done."
