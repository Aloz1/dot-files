#!/bin/bash

# Polybar already running
pgrep -u $UID -x polybar && exit

declare -A pbar_instances
monitors=$(bspc query -M --names)

for m_id in $monitors; do
    m_name=$(bspc query -M -m $m_id --names)
    MONITOR=$m_name polybar top&
    pbar_instances[$m_id]=$!
    echo Started on $m_name, PID=${pbar_instances[$m_id]}
done

events="monitor_swap monitor_add monitor_remove"
bspc subscribe $events | while read -r event; do
    e_name=$(echo $event | cut -d' ' -f1)
    e_node_id=$(echo $event | cut -d' ' -f2)
    e_extra=$(echo $event | cut -d' ' -f3)

    case $e_name in
        monitor_add)
            m_name=$(bspc query -M -m $e_node_id --names)
            MONITOR=$m_name polybar top &
            pbar_instances[$e_node_id]=$?
            ;;
        monitor_remove)
            if [ ! -z "${pbar_instances[$e_node_id]}" ]; then
                echo removing
                kill ${pbar_instances[$e_node_id]}
                echo removed
                unset pbar_instances[$e_node_id]
                echo unset
            fi
            ;;
        monitor_swap)
            kill -SIGUSR1 "${pbar_instances[$e_node_id]}" "${pbar_instances[$e_extra]}"
            ;;
        *)
    esac

    pgrep -u $UID -x polybar || exit

done
