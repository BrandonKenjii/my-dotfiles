#!/bin/bash
# Rofi wallpaper modi — live preview via FIFO → imv
#
# ROFI_RETV=0 : initial — list entries + seed preview
# ROFI_RETV=1 : Enter  — apply selection
# other       : selection changed (hover / arrow) — update preview

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
FIFO="/tmp/wallpaper-select-fifo"

if [[ -z "$ROFI_RETV" ]]; then
    ROFI_RETV=0
fi

if [[ "$ROFI_RETV" -eq 0 ]]; then
    # ---------- initial: list wallpapers ----------
    find "$WALLPAPER_DIR" -type f \
        \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" -o -name "*.gif" \) \
        -printf "%f\n" | sort

elif [[ "$ROFI_RETV" -eq 1 ]]; then
    # ---------- Enter pressed: return selection ----------
    [[ -n "$ROFI_INFO" ]] && echo "$ROFI_INFO"

elif [[ -n "$ROFI_INFO" && -p "$FIFO" ]]; then
    # ---------- selection changed: push to fifo ----------
    echo "$ROFI_INFO" > "$FIFO" 2>/dev/null
fi
