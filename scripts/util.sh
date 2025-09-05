#!/usr/bin/env bash
set -euo pipefail

ESC="\033["
RESET="${ESC}0m"
BOLD="${ESC}1m"
GREEN="${ESC}32m"
YELLOW="${ESC}33m"
BLUE="${ESC}34m"
RED="${ESC}31m"

log() { printf "%b" "$1"; }
color_echo() { local color=$1; shift; printf "%b%s%b\n" "$color" "$*" "$RESET"; }

_title() { color_echo "$BOLD$BLUE" "== $* =="; }
_step() { color_echo "$BLUE" "→ $*"; }
_success() { color_echo "$GREEN" "✔ $*"; }
_warn() { color_echo "$YELLOW" "⚠ $*"; }
_error() { color_echo "$RED" "✖ $*"; }

export -f _title _step _success _warn _error

alias title=_title
alias step=_step
alias success=_success
alias warn=_warn
alias error=_error