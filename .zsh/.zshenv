# Default user (e.g. for agnoster theme)
export DEFAULT_USER=$(id -un)

# Language vars
export LC_ALL=en_US.UTF-8
export LC_TIME=C
export LC_COLLATE=C

# Editor vars
export VISUAL="vim"
export EDITOR="$VISUAL"

# pager stuff
if [ -x "$(command -v less)" ]; then
    export PAGER="less"
    export LESS="-Rx4"
fi
if [ -x "$(command -v most)" ]; then
    export PAGER="most"
fi

# path variables for executables and zsh completion
export PATH="$PATH:/usr/sbin:/sbin"
export fpath=("${HOME}/.oh-my-zsh/custom/completions" "/usr/share/zsh/vendor-completions" $fpath)
if [ -x "$(command -v gem)" ]; then
    export PATH="$(gem environment gempath):${PATH}"
fi
if [ -x "$(command -v brew)" ]; then
    eval "$(brew shellenv)"
fi
if [ -d "${HOME}/go/bin" ]; then
    export PATH="${HOME}/go/bin:$PATH:/usr/sbin:/sbin"
fi
if [ -d "${HOME}/.local/bin" ]; then
    export PATH="${HOME}/.local/bin:$PATH:/usr/sbin:/sbin"
fi

# gpg
export GPG_TTY=$(tty)

# Add my local cert to the NODE cert storage
if [ -x "$(command -v mkcert)" ]; then
    export NODE_EXTRA_CA_CERTS="$(mkcert -CAROOT)/rootCA.crt"
fi

# tmux vars
export TMUX_THEME='trans'
if [ ! -z $DISPLAY ]; then
    # in graphical environments
    export ZSH_TMUX_AUTOSTART=true
    export ZSH_TMUX_AUTOCONNECT=false
else
    # in terminal-only environments
    export ZSH_TMUX_AUTOSTART=true
    export ZSH_TMUX_AUTOCONNECT=true
fi

if [ ! -z "$FORCE_TMUX" ]; then
    export ZSH_TMUX_AUTOSTART=$FORCE_TMUX
fi

# Default value for the location param of the wttr function
export WTTR_LOCATION='Berlin'

# prevent ZSH from eating the space before pipe or ampersand characters
export ZLE_REMOVE_SUFFIX_CHARS=""

# enable truecolor in micro
export MICRO_TRUECOLOR=1

if [[ -n $(ls -A $ZDOTDIR/.zshenv.d/ 2>/dev/null) ]]; then
    for f in $ZDOTDIR/.zshenv.d/*; do
        source "$f"
    done
fi
