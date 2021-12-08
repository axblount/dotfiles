#!/bin/bash

trap "exit 0" SIGSTOP

function bat_color() {
    if (( $1 > 75 )); then
        echo -n "#00FF00"
    elif (( $1 > 33 )); then
        echo -n "#FFFF00"
    else
        echo -n "#FF0000"
    fi
}

echo '{ "version": 1, "click_events": true }'

echo '['

(while true; do
    # networking
    netiface=$(ip addr | awk '/state UP/ {print $2}')
    netiface=${netiface%:} # remove trailing colon
    ssid=$(iw dev $netiface info | awk '/ssid/ {print $2}')
    # sound
    read volume <<<$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Eo '[0123456789]+%')
    mute=$(pactl get-sink-mute @DEFAULT_SINK@ | cut -d' ' -f2)
    # battery
    read bat0 < /sys/class/power_supply/BAT0/capacity
    read bat1 < /sys/class/power_supply/BAT1/capacity
    read charging < /sys/class/power_supply/AC/online

    cat <<-JSON
    [
        {
            "name": "id_net",
            "full_text": "${netiface:-DOWN}${netiface:+: }${ssid:-no network}",
            $(if [ -z "$netiface" -o -z "$ssid" ]; then
                echo '"color": "#FF0000",'
            fi)
        },
        {
            "name": "id_volume",
            "full_text": "v:$volume",
            $(if [ "$mute" = "yes" ]; then
                echo '"color": "#0000FF",'
            fi)
        },
        {
            "name": "id_bat0",
            "full_text": "$bat0%",
            "color": "$(bat_color $bat0)",
            $(if [ "$charging" = "1" ]; then
                echo '"border": "#fee23e",'
            fi)
        },
        {
            "name": "id_bat1",
            "full_text": "$bat1%",
            "color": "$(bat_color $bat1)",
            $(if [ "$charging" = "1" ]; then
                echo '"border": "#fee23e",'
            fi)
        },
        {
            "name": "id_time",
            "full_text": "$(date +'%Y-%m-%d %H:%M')",
        }
    ],
JSON
    sleep 1
done) &

while read line; do
    case "$line" in
        *"name"*"id_time"*) kitty --hold cal -Y & ;;
        *"name"*"id_volume"*) pavucontrol & ;;
    esac
done
