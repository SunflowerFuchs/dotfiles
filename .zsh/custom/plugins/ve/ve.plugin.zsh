#!/bin/zsh

function ve {
    local keywords=('help' 'new' 'rm' 'list')
    local noParam=('help' 'list')
    local KEYWORD="$(echo -e "${1}" | sed 's/^-*//')"

    if [[ -z $VIRTUALENV_DIR ]]; then
        local VIRTUALENV_DIR="$HOME/.virtualenvs"
    else
        local VIRTUALENV_DIR=$(echo "$VIRTUALENV_DIR" | sed 's|/*$||')
    fi

    if ((keywords[(Ie)$KEYWORD])); then
        ((!noParam[(Ie)$KEYWORD])) && [[ $# -lt 2 ]] && echo "Missing parameter" && ve help && return 1
        echo # for prettier combination of commands
        case "$KEYWORD" in
            "help")
                echo "Parameters:"
                echo "    ve [command] env [params ...]"
                echo
                echo "Commands:"
                echo "    help      - Prints this help message"
                echo "    list      - Lists current virtual environments"
                echo "    new       - Creates a new virtual environment in your VIRTUALENV_DIR (with an optional description)"
                echo "    rm        - Deletes the given virtual environment from your VIRTUALENV_DIR"
                echo
                echo "If the environment variable VIRTUALENV_DIR is not set, it defaults to $HOME/.virtualenvs"
            ;;
            "list")
                echo "Current virtual environments:"
                for d in $VIRTUALENV_DIR/*/ ; do
                    echo -n $(echo "$d" | sed "s#$VIRTUALENV_DIR/##" | sed 's#/*$##')
                    if [[ -s "${d}.description" ]]; then
                        echo -n " - "
                        local desc=$(cat "${d}.description")
                        echo -n "$desc"
                    fi
                    echo # append the newline
                done
            ;;
            "new")
                [[ -d $VIRTUALENV_DIR/$2 ]] && echo "$2 already exists" && return 1
                [[ -f $VIRTUALENV_DIR/$2 ]] && echo "Couldn't create $2; There seems to be a file blocking it" && return 1
                echo "Creating virtualenv $2 ..."
                virtualenv $VIRTUALENV_DIR/$2
                [[ $# -gt 2 ]] && echo "$3" > $VIRTUALENV_DIR/$2/.description
            ;;
            "rm")
                [[ ! -d $VIRTUALENV_DIR/$2 || -L $VIRTUALENV_DIR/$2 ]] && echo "Can't delete $2; Not a regular directory" && return 1
                read "REPLY?Are you sure? [Y/N]"
                echo
                if [[ $REPLY =~ ^[Yy]$ ]]; then
                    echo "Deleting virtualenv $2 ..."
                    rm -rf $VIRTUALENV_DIR/$2
                else
                    echo "Cancelled"
                    return 1
                fi
            ;;
        esac
    else
        [[ $# -lt 1 ]] && echo "Missing parameter" && ve help && return 1
        [[ $# -gt 1 ]] && echo "Too many parameters" && ve help && return 1

        local VE=${1%/}

        [[ ! -d "$VIRTUALENV_DIR/" ]] && echo "No .virtualenvs directory in your home" && return 1
        [[ ! -d "$VIRTUALENV_DIR/$VE/" ]] && echo "Unknown virtualenv" && ve list && return 1

        source "$VIRTUALENV_DIR/$VE/bin/activate"
        echo "Env $VE activated"
    fi

    return 0 # catch-all return for all ok
}
