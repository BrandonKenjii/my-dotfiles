#!/bin/bash
# Toggle Do Not Disturb mode via dunst
# Waybar custom module — outputs JSON with current DND state

case "$1" in
    toggle)
        dunstctl set-paused toggle
        # Signal waybar to refresh this module
        pkill -SIGRTMIN+8 waybar 2>/dev/null || true
        exit 0
        ;;
esac

# Output current state for waybar
paused=$(dunstctl is-paused)

if [ "$paused" = "true" ]; then
    echo '{"text": "󰂛  DND", "alt": "dnd-on", "class": "dnd-on", "tooltip": "Do Not Disturb: ON\nClick to turn off"}'
else
    echo '{"text": "󰂚", "alt": "dnd-off", "class": "dnd-off", "tooltip": "Do Not Disturb: OFF\nClick to turn on"}'
fi
