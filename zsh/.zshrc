# ========== Zsh Configuration ==========
export ZDOTDIR="$HOME/.zsh"

# PATH setup (basic; further additions in custom/path.zsh)
export PATH="/usr/local/bin:/opt/homebrew/bin:$PATH"

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="" # Starship prompt is used instead
plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-completions)

source "$ZSH/oh-my-zsh.sh" 2>/dev/null || true

# Starship prompt
command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"

# Custom scripts
for f in "$HOME/.zsh/custom"/*.zsh; do
  [[ -r "$f" ]] && source "$f"
done

# Completion tweaks
autoload -Uz compinit && compinit -u

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS SHARE_HISTORY EXTENDED_HISTORY

# Aliases (defined in custom but a few quick ones here)
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Editor
export EDITOR="nvim"

# Node / pnpm (auto-load if available)
command -v pnpm >/dev/null 2>&1 && export PNPM_HOME="$HOME/Library/pnpm" && export PATH="$PNPM_HOME:$PATH"

# thefuck integration (separate file too)
command -v thefuck >/dev/null 2>&1 && eval "$(thefuck --alias)"

# End