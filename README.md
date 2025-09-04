# Dotfiles

Automated setup for macOS including:

- Homebrew (install + bundle)
- Oh My Zsh (non-interactive install, no theme)
- Starship prompt
- Zsh plugins & extras (git, z, fzf, autosuggestions, syntax-highlighting, thefuck)
- Docker, Cursor, VS Code
- Cloud & browser tooling (Google Cloud SDK, alternative Chromium builds, multi-channel Chrome)
- Git config symlinks
- macOS defaults (optional)
- Idempotent bootstrap + unified update script

## Quick Start

```bash
# Recommended location
git clone https://github.com/felixdulfer/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

./bootstrap.sh
```

To skip confirmations:

```bash
./bootstrap.sh --yes
```

Include macOS UI tweaks:

```bash
./bootstrap.sh --macos
```

Dry run (no changes):

```bash
./bootstrap.sh --dry-run
```

## Update / Maintenance

```bash
./scripts/update.sh            # Update packages, plugins, relink
./scripts/update.sh --cleanup  # Also remove orphaned Homebrew deps
```

## Structure

```
.
├─ bootstrap.sh
├─ Brewfile
├─ install/
│  ├─ brew.sh
│  └─ oh-my-zsh.sh
├─ macos/
│  └─ defaults.sh
├─ scripts/
│  ├─ util.sh
│  └─ update.sh
├─ zsh/
│  ├─ .zshrc
│  └─ custom/
│     ├─ aliases.zsh
│     ├─ path.zsh
│     └─ thefuck.zsh
├─ starship/
│  └─ starship.toml
├─ git/
│  └─ .gitconfig
├─ bin/
│  └─ link-dotfiles
└─ .gitignore
```

## What Bootstrap Does

1. Installs Homebrew if missing.
2. Installs formulae & casks from `Brewfile`.
3. Installs Oh My Zsh (no theme) & Starship.
4. Ensures plugins (git, z, fzf, autosuggestions, syntax-highlighting, thefuck).
5. Symlinks dotfiles + Starship config.
6. Optionally applies macOS defaults (`--macos`).
7. Safe (prompts unless `--yes`).

## Starship

Config lives at `starship/starship.toml` → symlinked to `~/.config/starship.toml`.
Reload with a new shell or:
```bash
eval "$(starship init zsh)"
```

## Brewfile Editing

Add/remove packages in `Brewfile` then run:
```bash
brew bundle --file "$HOME/.dotfiles/Brewfile"
```

## Uninstall

Remove symlinks (`~/.zshrc`, `~/.config/starship.toml`, etc.) then delete `~/.dotfiles`.

## License

MIT