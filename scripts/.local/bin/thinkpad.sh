#!/bin/bash

action="$1"
value="$2"

terror() {
    echo "$@" 1>&2
    exit 1
}

case "$action" in
    vol)
        pactl set-sink-volume @DEFAULT_SINK@ "$value"
        ;;
    mute)
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        mute_state=0
        if pactl get-sink-mute @DEFAULT_SINK@ | grep -q "yes"; then
            mute_state=1
        fi
        echo "$mute_state" >| /sys/class/leds/platform\:\:mute/brightness
        ;;
    micmute)
        pactl set-source-mute @DEFAULT_SOURCE@ toggle
        mic_mute_state=0
        if pactl get-source-mute @DEFAULT_SOURCE@ | grep -q "yes"; then
            mic_mute_state=1
        fi
        echo "$mic_mute_state" >| /sys/class/leds/platform\:\:micmute/brightness
        ;;
    light)
        if ! [[ "$value" =~ '^[+-]' ]]; then
            terror "bad light number, i want something like '+4' or '-10'"
        fi
        read max_brightness < /sys/class/backlight/intel_backlight/max_brightness
        read brightness < /sys/class/backlight/intel_backlight/brightness
        new_brightness=$(( brightness + value ))
        new_brightness=$(( brightness > max_brightness ? max_brightness : brightness ))
        echo "$new_brightness" >| /sys/class/backlight/intel_backlight/brightness
        ;;
    *) terror "bad action: $@" ;;
esac
