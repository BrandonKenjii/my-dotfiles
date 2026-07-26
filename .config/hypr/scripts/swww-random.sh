#!/bin/bash
# SWWW Wallpaper Randomizer
# Prefers current theme's wallpaper directory, falls back to all wallpapers

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
THEME_DIR="$HOME/.config/theme"

# Available transition types
TRANSITIONS=(
    "grow"
    "wave"
    "wipe"
    "center"
    "fade"
    "outer"
    "random"
)

# Get random transition
TRANSITION=${TRANSITIONS[$RANDOM % ${#TRANSITIONS[@]}]}

# Read current theme to prefer its wallpaper directory
CURRENT_THEME=$(cat "$THEME_DIR/current" 2>/dev/null)
if [[ -n "$CURRENT_THEME" ]]; then
    # Convert "Tokyo Night" -> "tokyo-night", "Catppuccin Mocha" -> "catppuccin", etc.
    THEME_SUBDIR=$(echo "$CURRENT_THEME" | tr '[:upper:]' '[:lower:]' | sed 's/ .*//')
    THEME_WALLPAPER_DIR="$WALLPAPER_DIR/$THEME_SUBDIR"
    if [[ -d "$THEME_WALLPAPER_DIR" ]]; then
        WALLPAPER=$(find "$THEME_WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" \) | shuf -n 1)
    fi
fi

# Fallback to all wallpapers
if [[ -z "$WALLPAPER" ]]; then
    WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" \) | shuf -n 1)
fi

if [ -z "$WALLPAPER" ]; then
    notify-send "Wallpaper Error" "No wallpapers found in $WALLPAPER_DIR" -u critical
    exit 1
fi

# Ensure swww-daemon is running
if ! pgrep -x "swww-daemon" > /dev/null; then
    swww-daemon &
    sleep 0.5
fi

# Set wallpaper with transition
swww img "$WALLPAPER" \
    --transition-type "$TRANSITION" \
    --transition-pos center \
    --transition-duration 1.5 \
    --transition-fps 60 \
    --transition-bezier 0.65,0,0.35,1

# Send notification
FILENAME=$(basename "$WALLPAPER")
notify-send "Wallpaper Changed" "$FILENAME" -i "$WALLPAPER" -t 3000
