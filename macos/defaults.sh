#!/usr/bin/env bash
set -euo pipefail

confirm() {
  read -r -p "Apply macOS defaults (this will modify system settings)? [y/N] " ans
  [[ $ans == y || $ans == Y ]]
}

if [[ "${CI:-}" != "true" ]]; then
  confirm || { echo "Aborted."; exit 0; }
fi

echo "[macOS] Close System Settings & related apps first..."
osascript -e 'tell application "System Settings" to quit' 2>/dev/null || true
osascript -e 'tell application "System Preferences" to quit' 2>/dev/null || true

# General UI/UX
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Keyboard
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Finder
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Dock
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock show-recents -bool false

# Screenshot location
mkdir -p "$HOME/Screenshots"
defaults write com.apple.screencapture location "$HOME/Screenshots"

# Apply & restart affected services
killall Finder Dock SystemUIServer 2>/dev/null || true

echo "[macOS] Defaults applied."