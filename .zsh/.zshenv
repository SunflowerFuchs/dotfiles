# Default user (e.g. for agnoster theme)
export DEFAULT_USER=$(id -un)

# Language vars
export LC_ALL=en_US.UTF-8
export LC_TIME=C
export LC_COLLATE=C

# Editor vars
export VISUAL="micro"
export EDITOR="$VISUAL"

# pager stuff
export PAGER="most"
export LESS="-Rx4"

# path variables for executables and zsh completion
export PATH="${HOME}/.gem/ruby/2.3.0/bin:$PATH"
export fpath=("${HOME}/.oh-my-zsh/custom/completions" "/usr/share/zsh/vendor-completions" $fpath)

# Add my local cert to the NODE cert storage
if [ -x "$(command -v mkcert)" ]; then
    export TEMPTEST=true
    export NODE_EXTRA_CA_CERTS="$(mkcert -CAROOT)/rootCA.crt"
fi

# tmux vars
if [ -x "$(command -v Xorg)" ]; then
    # in graphical environments
    [ -z "$ZSH_TMUX_AUTOSTART" ] && export ZSH_TMUX_AUTOSTART=true
    [ -z "$ZSH_TMUX_AUTOCONNECT" ] && export ZSH_TMUX_AUTOCONNECT=false
else
    # in terminal-only environments
    [ -z "$ZSH_TMUX_AUTOSTART" ] && export ZSH_TMUX_AUTOSTART=true
    [ -z "$ZSH_TMUX_AUTOCONNECT" ] && export ZSH_TMUX_AUTOCONNECT=true
fi

# prevent ZSH from eating the space before pipe or ampersand characters
ZLE_REMOVE_SUFFIX_CHARS=""

# enable truecolor in micro
export MICRO_TRUECOLOR=1

# export some color variables
export RED=$(tput setaf 1)
export BLUE=$(tput setaf 4)
export GREEN=$(tput setaf 2)
export YELLOW=$(tput setaf 3)
export NC=$(tput sgr0) # No Color

# source custom env files
[[ -n $(ls -A $ZDOTDIR/.zshenv.d/ 2>/dev/null) ]] && source $ZDOTDIR/.zshenv.d/*
