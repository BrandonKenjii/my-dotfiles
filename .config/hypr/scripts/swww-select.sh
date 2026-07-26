#!/bin/bash
# SWWW Wallpaper Selector — simple rofi dmenu
# Type to filter, Enter to apply, Esc to cancel
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:/usr/local/bin:$PATH"

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

WALLPAPER_LIST=$(find "$WALLPAPER_DIR" -type f \
    \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" -o -name "*.gif" \) \
    -printf "%P\n" | sort)

if [[ -z "$WALLPAPER_LIST" ]]; then
    notify-send "Wallpaper Error" "No wallpapers found in $WALLPAPER_DIR" -u critical
    exit 1
fi

SELECTED=$(echo "$WALLPAPER_LIST" | rofi -dmenu -i -p " Wallpaper" -no-custom)

if [[ -n "$SELECTED" ]]; then
    # Ensure swww-daemon is running
    if ! pgrep -x "swww-daemon" > /dev/null; then
        swww-daemon &
        sleep 0.5
    fi

    swww img "$WALLPAPER_DIR/$SELECTED" \
        --transition-type grow \
        --transition-pos center \
        --transition-duration 1.5 \
        --transition-fps 60 \
        --transition-bezier 0.65,0,0.35,1

    notify-send "Wallpaper Set" "$SELECTED" -i "$WALLPAPER_DIR/$SELECTED" -t 3000
fi
