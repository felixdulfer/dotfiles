# Path additions
prepend_path() { [ -d "$1" ] && case ":$PATH:" in *":$1:"*) ;; *) PATH="$1:$PATH" ;; esac }
append_path() { [ -d "$1" ] && case ":$PATH:" in *":$1:"*) ;; *) PATH="$PATH:$1" ;; esac }

prepend_path "$HOME/.local/bin"
prepend_path "$HOME/bin"

export PATH