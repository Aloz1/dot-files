#!/bin/bash

inc=2

function getVol() {
    echo $(ponymix get-volume)
}

function isMuted() {
    ponymix is-muted
    echo $?
}

function listen {
    firstrun=0

    pactl subscribe 2>/dev/null | {
        while true; do
            {
                if [ $firstrun -eq 0 ]; then
                    firstrun=1
                else
                    read -r event || break
                    if ! echo "$event" | grep -e "on card" -e "on sink"; then
                        continue
                    fi
                fi
            } &>/dev/null
            output
        done
    }
}

function output() {
    vol=$(getVol)
    mute=$(isMuted)

    out="VOL "

    if [ "$mute" -ne 0 ]; then
        out+="$vol%"
    else
        out+="MUTE"
    fi

    echo $out
}

case "$1" in
    --up)
        ponymix increase $inc
        ;;

    --down)
        ponymix decrease $inc
        ;;

    --mutetog)
        ponymix toggle
        ;;

    --listen)
        output
        listen
        ;;

    *)
        output
        ;;
esac
