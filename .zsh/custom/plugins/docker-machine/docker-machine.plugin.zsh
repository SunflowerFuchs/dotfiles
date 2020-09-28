dm() {
    [ -f ~/.docker/machine/machine.conf ] && . ~/.docker/machine/machine.conf
    local DEFAULT_MACHINE="${DEFAULT_MACHINE:-default}"
    local MACHINE="${2:-${DEFAULT_MACHINE}}"

    # TODO: make --help a non-positional argument

    case $1 in
    '-h' | '--help' )
        case $2 in
            'create' )
                echo "Usage: dm create [NAME]"
                echo "Creates a new machine with the given name (if no name given, defaults to \"${DEFAULT_MACHINE}\")"
                echo
                echo "Config-File ~/.docker/machine/machine.conf can contain the following options:"
                echo "\tDEFAULT_MACHINE"
                echo "\tDISK_SIZE"
                echo "\tMEMORY_SIZE"
                echo "\tCPU_COUNT"
                ;;
            'start' )
                echo "Usage: dm start [NAME]"
                echo "Starts an already existing machine with the given name (if no name given, defaults to \"${DEFAULT_MACHINE}\")"
                echo "and switches the current environment to it (same as \"dm switch\")"
                ;;
            'stop' )
                echo "Usage: dm stop [NAME]"
                echo "Stops a currently running machine with the given name (if no name given, defaults to \"${DEFAULT_MACHINE}\")"
                ;;
            'switch' )
                echo "Usage: dm switch [NAME]"
                echo "Switches to a currently running machine with the given name (if no name given, switch back to host docker)"
                ;;
            *)
                echo "Usage: dm [OPTION]... COMMAND [ARG]..."
                echo "Shortcut-function for controlling docker-machine"
                echo
                echo "Commands:"
                echo "\tcreate\tcreate a new machine"
                echo "\tstart\tstart an existing machine and switch to it"
                echo "\tstop\tstop a running machine"
                echo "\tswitch\tswitch to a currently running machine"
                ;;
        esac
        ;;

    'create' )
        local DISK_SIZE="${DISK_SIZE:-15000}"
        local MEMORY_SIZE="${MEMORY_SIZE:-4096}"
        local CPU_COUNT="${CPU_COUNT:-2}"

        docker-machine create -d virtualbox --virtualbox-disk-size "${DISK_SIZE}" --virtualbox-memory "${MEMORY_SIZE}" --virtualbox-cpu-count "${CPU_COUNT}" "${MACHINE}"
        ;;

    'stop' )
        docker-machine stop "${MACHINE}"
        echo "$(docker-machine active 2>/dev/null)"
        if [[ "$(docker-machine active 2>/dev/null)" == "${MACHINE}" ]]; then
            dm switch
        fi
        ;;

    'start' )
        docker-machine start "${MACHINE}"
        dm switch "${MACHINE}"
        ;;

    'switch' )
        if [ -z "${2}" ]; then
            eval $(docker-machine env --unset)
            echo "Switched back to host docker"
        else
            eval $(docker-machine env "${MACHINE}")
            echo $DOCKER_HOST
        fi
        ;;
    '' )
        echo "Missing 'command' parameter"
        dm -h
        ;;
    * )
        echo "Unknown command '$1'"
        dm -h
        ;;
    esac
}
