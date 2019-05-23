#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Wait until only two monitors are visible, abandon after 10 tries
tries=1
while [[ $( polybar -m | grep "DP-1-" | wc -l ) -ne 2 ]]; do
    tries=$(($tries+1))
    [[ tries -gt 10 ]] && exit 0
    sleep 1
done

# Launch secondary
/usr/local/bin/polybar -c $HOME/.config/polybar/config secondary &
