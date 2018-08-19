#!/bin/sh

# Terminate already running instances
pkill -U $(id -u $USER) polybar

# Wait until the processes have been shutdonw
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
polybar top &
#polybar bar2 2>&1 > /dev/null &

echo "Polybar has been launched"
