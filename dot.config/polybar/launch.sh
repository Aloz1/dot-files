#!/bin/sh

# Terminate already running instances
pkill -U $(id -u $USER) polybar

# Wait until the processes have been shutdown
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
pkill polybar
while pgrep -x polybar >/cev/null; do sleep 0.5; done
for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar top&
done
echo "Polybar has been launched"
