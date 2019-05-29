# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    tmux
    sudo
    wd
    pip
    composer
    gulp
    fast-syntax-highlighting
    ve
    colorize
)

# ZSH theme
ZSH_THEME="spaceship"

# load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# set HISTFILE
export HISTFILE="$ZDOTDIR/.zsh_history"
export HISTSIZE=50000
export SAVEHIST=50000

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

unsetopt AUTO_CD                 # Don't cd into directories without an explicit cd
unsetopt CDABLE_VARS             # Don't try to resolve unknown cd expressions into directories
unsetopt AUTO_REMOVE_SLASH       # Don't remove slashes from typed commands when inserting spaces
unsetopt BANGHIST                # Don't use ! as history shortcuts

# load prompt config
[[ -f $ZDOTDIR/.spaceship-settings ]] && source "$ZDOTDIR/.spaceship-settings"

# fzf completion and keybinds
[ -f $ZDOTDIR/.fzf.zsh ] && source $ZDOTDIR/.fzf.zsh

# tmuxinator completion
[ -f $HOME/.config/tmuxinator.zsh ] && source $HOME/.config/tmuxinator.zsh

# reload completions
autoload -U compinit && compinit

# Gulp completion
if [ -x "$(command -v gulp)" ]; then
    eval "$(gulp --completion=zsh)"
fi

# show terminal startup messages
[ -f $ZDOTDIR/.zsh_message ] && source $ZDOTDIR/.zsh_message
