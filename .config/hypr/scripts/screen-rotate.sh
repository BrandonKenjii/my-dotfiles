#!/bin/bash
# filepath: ~/.config/hypr/scripts/screen-rotate.sh
# Auto-rotate screen based on accelerometer orientation via iio-sensor-proxy

MONITOR="eDP-1"

rotate_screen() {
    local scale
    scale=$(hyprctl monitors -j 2>/dev/null | jq -r ".[] | select(.name==\"$MONITOR\") | .scale // empty" 2>/dev/null)
    scale=${scale:-1.5}

    case "$1" in
        "normal")
            hyprctl keyword monitor "$MONITOR,preferred,auto,$scale,transform,0"
            ;;
        "left-up")
            hyprctl keyword monitor "$MONITOR,preferred,auto,$scale,transform,1"
            ;;
        "bottom-up")
            hyprctl keyword monitor "$MONITOR,preferred,auto,$scale,transform,2"
            ;;
        "right-up")
            hyprctl keyword monitor "$MONITOR,preferred,auto,$scale,transform,3"
            ;;
    esac
}

# Kill any existing instances (not ourselves)
for pid in $(pgrep -f "screen-rotate.sh"); do
    [ "$pid" != "$$" ] && kill "$pid" 2>/dev/null
done
pkill -f "monitor-sensor" 2>/dev/null

# stdbuf -oL forces line-buffered output even when stdout is a pipe,
# fixing the buffering issue that prevents the while loop from seeing events.
stdbuf -oL monitor-sensor --accel 2>&1 | while read -r line; do
    case "$line" in
        *"Accelerometer orientation changed: normal"*)
            rotate_screen "normal"
            ;;
        *"Accelerometer orientation changed: left-up"*)
            rotate_screen "left-up"
            ;;
        *"Accelerometer orientation changed: bottom-up"*)
            rotate_screen "bottom-up"
            ;;
        *"Accelerometer orientation changed: right-up"*)
            rotate_screen "right-up"
            ;;
    esac
done
