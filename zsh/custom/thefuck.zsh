# thefuck integration (separate so it can fail quietly)
if command -v thefuck >/dev/null 2>&1; then
  eval "$(thefuck --alias)"
fi