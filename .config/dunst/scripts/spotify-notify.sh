#!/bin/bash
# Spotify notification handler - called by dunst when a Spotify notification arrives
# Downloads album art and re-sends the notification with the art attached.
# Only notifies on actual song changes, not on every metadata update.

CACHE_DIR="$HOME/.cache/dunst"
CACHE_FILE="$CACHE_DIR/spotify_last_song"
mkdir -p "$CACHE_DIR"

get_album_art() {
    local art_url=$(playerctl -p spotify metadata mpris:artUrl 2>/dev/null)
    local art_file="$CACHE_DIR/spotify_art.png"

    if [[ -z "$art_url" ]]; then
        echo ""
        return
    fi

    # Convert Spotify URL if needed
    if [[ "$art_url" == *"open.spotify.com"* ]]; then
        art_url="${art_url/open.spotify.com/i.scdn.co}"
    fi

    if curl -sL "$art_url" -o "$art_file" 2>/dev/null && [[ -s "$art_file" ]]; then
        echo "$art_file"
    else
        echo ""
    fi
}

artist=$(playerctl -p spotify metadata artist 2>/dev/null)
title=$(playerctl -p spotify metadata title 2>/dev/null)
album=$(playerctl -p spotify metadata album 2>/dev/null)

# Only notify on actual song change, not playback progress updates
current_song="${artist}|||${title}|||${album}"
last_song=""
[[ -f "$CACHE_FILE" ]] && last_song=$(cat "$CACHE_FILE")

if [[ "$current_song" == "$last_song" ]]; then
    exit 0
fi

# Record this song so we don't notify again for it
echo "$current_song" > "$CACHE_FILE"

# Build notification body
body=""
[[ -n "$artist" ]] && body+="by <b>$artist</b>"
[[ -n "$album" ]] && body+="\non <i>$album</i>"

# Get album art if available
art_file=$(get_album_art)
icon_arg=""
[[ -n "$art_file" ]] && icon_arg="-i $art_file"

[[ -n "$title" ]] && {
    # Use "spotify" (lowercase) as the app name so it doesn't re-trigger the
    # [spotify] dunst rule that matches appname=Spotify (case-sensitive)
    dunstify -a "spotify" \
        -u normal \
        -h string:x-dunst-stack-tag:spotify \
        $icon_arg \
        "$title" \
        "$body"
}
