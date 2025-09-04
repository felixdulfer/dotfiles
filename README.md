# Dotfiles

Automated setup for macOS including:

- Homebrew (install + bundle)
- Oh My Zsh (non-interactive install)
- Starship prompt (theme-less Oh My Zsh)
- Zsh plugins & extras (git, z, fzf, autosuggestions, syntax-highlighting, thefuck)
- Git config symlinks
- macOS defaults (optional)
- Idempotent bootstrap + unified update script

## Quick Start

```bash
# Recommended location
git clone https://github.com/felixdulfer/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Interactive bootstrap
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

Keep everything fresh:

```bash
./scripts/update.sh            # Update packages, plugins, relink
./scripts/update.sh --cleanup  # Also remove orphaned Homebrew deps
```

## Structure

```
.
├─ bootstrap.sh                # Entry point
├─ Brewfile                    # Homebrew bundle definitions
├─ install/
│  ├─ brew.sh                  # Installs Homebrew + bundle
│  └─ oh-my-zsh.sh             # Installs Oh My Zsh + plugins
├─ macos/
│  └─ defaults.sh              # macOS defaults (optional)
├─ scripts/
│  ├─ util.sh                  # Shared helpers
│  └─ update.sh                # Update workflow
├─ zsh/
│  ├─ .zshrc                   # Main zsh config (symlinked to $HOME)
│  └─ custom/
│     ├─ aliases.zsh
│     ├─ path.zsh
│     └─ thefuck.zsh
├─ starship/
│  └─ starship.toml            # Starship prompt configuration
├─ git/
│  └─ .gitconfig
├─ bin/
│  └─ link-dotfiles            # Symlink manager
├─ .gitignore
```

## What Bootstrap Does

1. Installs Homebrew if missing.
2. Installs all formulae/casks in `Brewfile`.
3. Installs Oh My Zsh (if not present) non-interactively (no theme).
4. Installs & configures Starship prompt.
5. Ensures zsh plugins (git, z, fzf, zsh-autosuggestions, zsh-syntax-highlighting, thefuck).
6. Symlinks managed files into `$HOME` (including starship config).
7. Optionally applies macOS defaults (`--macos`).
8. Safe & repeatable (asks before replacing unless `--yes`).

## Editing Starship Prompt

Edit `~/.config/starship.toml` (symlinked from `starship/starship.toml`). Apply changes by opening a new shell.

## Updating Brew Packages

Edit `Brewfile` then:

```bash
brew bundle --file="$HOME/.dotfiles/Brewfile"
```

Dump current installed set back into Brewfile:

```bash
brew bundle dump --file="$HOME/.dotfiles/Brewfile" --force
```

## Customize

- `Brewfile` → packages & apps
- `starship/starship.toml` → prompt look & modules
- `zsh/custom/*.zsh` → shell additions
- `macos/defaults.sh` → system tweaks
- `git/.gitconfig` → identity & git behavior

## Uninstall / Cleanup

Remove symlinks (check with `ls -l ~/.zshrc`, `ls -l ~/.config/starship.toml`) then delete `~/.dotfiles`. Homebrew & packages remain unless manually removed.

## Future Ideas (Not Implemented Yet)

- Secret management (age/sops)
- VS Code / Cursor settings sync
- Language version managers bootstrap (fnm / pyenv / asdf)

## License

MIT (adjust if needed).