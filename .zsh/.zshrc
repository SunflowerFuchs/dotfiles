# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    sudo
    wd
    fast-syntax-highlighting
    colorize
    zsh-completions
)

# dynamic plugin loading
[[ -x "$(command -v tmux)" ]] && plugins+=(tmux)
[[ -x "$(command -v pip)" ]] && plugins+=(pip)
[[ -x "$(command -v gulp)" ]] && plugins+=(gulp)
[[ -x "$(command -v virtualenv)" ]] && plugins+=(ve)
[[ -x "$(command -v docker)" ]] && plugins+=(docker)
[[ -x "$(command -v docker-compose)" ]] && plugins+=(docker-compose)
[[ -x "$(command -v docker-machine)" ]] && plugins+=(docker-machine)
[[ -x "$(command -v composer)" ]] && plugins+=(composer)
[[ -x "$(command -v git)" ]] && plugins+=(git-auto-fetch)
[ -x "$(command -v kubeadm)" -o -x "$(command -v minikube)" -o -x "$(command -v kubectl)" ] && plugins+=(k8)
[[ -d "/nix" ]] && plugins+=(nix-zsh-completions)

# ZSH theme
ZSH_THEME="spaceship"

# enable autoupdate
DISABLE_UPDATE_PROMPT=true

# load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# set HISTFILE
export HISTFILE="$ZDOTDIR/.zsh_history"
export HISTSIZE=5000000
export SAVEHIST=5000000

# User configuration
[[ -f $ZDOTDIR/.zsh_aliases ]] && source $ZDOTDIR/.zsh_aliases
[[ -f $ZDOTDIR/.zsh_functions ]] && source $ZDOTDIR/.zsh_functions

# zsh options (http://zsh.sourceforge.net/Doc/Release/Options.html)
setopt HIST_IGNORE_SPACE         # Don't write entries starting with a space into history
setopt HIST_NO_STORE             # Don't store the history command to the history
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt GLOB_DOTS                 # Files with leading dots are not hidden from globbing
setopt CSH_NULL_GLOB             # Delete globs that don't match (and only report error if all globs in command have no matches)
setopt GLOB_COMPLETE             # Don't explode globs when autocompleting, but show results instead
setopt KSH_GLOB                  # In pattern matching, enable qualifiers (e.g. "*(pattern)" or "?(pattern)")
setopt RM_STAR_SILENT            # Don't ask before executing `rm *`

unsetopt AUTO_CD                 # Don't cd into directories without an explicit cd
unsetopt CDABLE_VARS             # Don't try to resolve unknown cd expressions into directories
unsetopt AUTO_REMOVE_SLASH       # Don't remove slashes from typed commands when inserting spaces
unsetopt BANGHIST                # Don't use ! as history shortcuts

# load prompt config
[[ -f $ZDOTDIR/.spaceship-settings ]] && source "$ZDOTDIR/.spaceship-settings"

# config for fast-syntax-highlighting
if [[ -z $FAST_THEME_NAME ]] || [[ $FAST_THEME_NAME != "custom" ]]; then
    fast-theme -q custom
fi
export FAST_HIGHLIGHT[chroma-hub]=:chroma/main-chroma.ch%git
export FAST_HIGHLIGHT[git-cmsg-len]=120

# fzf completion and keybinds
[ -f $ZDOTDIR/.fzf.zsh ] && source $ZDOTDIR/.fzf.zsh

# tmuxinator completion
[ -f $HOME/.config/tmuxinator.zsh ] && source $HOME/.config/tmuxinator.zsh

# Gulp completion
if [ -x "$(command -v gulp)" ]; then
    source <(gulp --completion=zsh)
fi

# thefuck completion
if [ -x "$(command -v thefuck)" ]; then
    eval $(thefuck --alias)
fi

# mutagen-compose completion
if [ -x "$(command -v mutagen-compose)" ]; then
    compdef mutagen-compose=docker-compose
fi

# reload completion
autoload -U compinit && compinit

# show terminal startup messages
[ -f $ZDOTDIR/.zsh_message ] && source $ZDOTDIR/.zsh_message
