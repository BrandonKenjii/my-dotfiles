#!/bin/bash

# Spotify status for Waybar (polling mode)

playerctl -p spotify metadata --format '{"text": "{{ artist }} - {{ title }}", "tooltip": "{{ album }}\n{{ artist }} - {{ title }}", "class": "{{ status }}", "alt": "{{ status }}"}' 2>/dev/null || echo '{"text": "", "tooltip": "Spotify not running", "class": "stopped", "alt": "stopped"}'
