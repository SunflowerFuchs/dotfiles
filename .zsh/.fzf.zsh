# Setup fzf
# ---------
if [[ ! "$PATH" == */home/developer/Documents/projects/.private/dependencies/fzf/bin* ]]; then
  export PATH="$PATH:/home/developer/Documents/projects/.private/dependencies/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/developer/Documents/projects/.private/dependencies/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/developer/Documents/projects/.private/dependencies/fzf/shell/key-bindings.zsh"

