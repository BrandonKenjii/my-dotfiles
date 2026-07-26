#!/bin/bash
# SWWW Wallpaper Initialization Script

# Start swww daemon if not running
if ! pgrep -x "swww-daemon" > /dev/null; then
    swww-daemon &
    # Wait for daemon socket to appear (up to 5 seconds)
    for i in $(seq 1 10); do
        if swww query &>/dev/null; then
            break
        fi
        sleep 0.5
    done
fi

# Read wallpaper from current theme
THEME_DIR="$HOME/.config/theme"
CURRENT_THEME=$(cat "$THEME_DIR/current" 2>/dev/null)
THEME_WALLPAPER=""
if [[ -n "$CURRENT_THEME" && -f "$THEME_DIR/themes/${CURRENT_THEME}.conf" ]]; then
    THEME_WALLPAPER=$(grep '^WALLPAPER=' "$THEME_DIR/themes/${CURRENT_THEME}.conf" | cut -d'"' -f2)
fi

# Use theme wallpaper (random from theme dir), argument override, or fallback
if [[ -n "$1" ]]; then
    WALLPAPER="$1"
elif [[ -n "$THEME_WALLPAPER" ]]; then
    # Pick random wallpaper from theme subdirectory
    THEME_WALLPAPER_DIR="$HOME/Pictures/Wallpapers/$(dirname "$THEME_WALLPAPER")"
    if [[ -d "$THEME_WALLPAPER_DIR" ]]; then
        WALLPAPER=$(find "$THEME_WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" \) | shuf -n 1)
    fi
    [[ -z "$WALLPAPER" ]] && WALLPAPER="$HOME/Pictures/Wallpapers/$THEME_WALLPAPER"
else
    # Fallback: random from all wallpapers
    WALLPAPER=$(find "$HOME/Pictures/Wallpapers" -maxdepth 2 -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" \) | shuf -n 1)
fi

# Check if file is a GIF - use simple transition to avoid stalling
if [[ "$WALLPAPER" == *.gif ]]; then
    swww img "$WALLPAPER" \
        --transition-type simple \
        --transition-duration 0.5
else
    swww img "$WALLPAPER" \
        --transition-type grow \
        --transition-pos center \
        --transition-duration 1 \
        --transition-fps 60
fi