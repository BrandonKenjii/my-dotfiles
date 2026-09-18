#!/bin/bash

# FortiClient VPN status for Waybar
# Usage: forticlient-vpn.sh          -> outputs JSON status for waybar
#        forticlient-vpn.sh toggle   -> disconnect, or open GUI to connect (click action)

# Toggle VPN connection on click
if [ "$1" = "toggle" ]; then
    if fortivpn status 2>/dev/null | grep -q "Connected"; then
        fortivpn disconnect
    else
        # Connecting requires an MFA passcode, so open the GUI for it
        forticlient gui
    fi
    exit 0
fi

status_output=$(fortivpn status 2>/dev/null)

if echo "$status_output" | grep -q "Connected"; then
    vpn_name=$(echo "$status_output" | sed -n 's/.*VPN name: //p')
    username=$(echo "$status_output" | sed -n 's/.*Username: //p')
    ip=$(echo "$status_output" | sed -n 's/.*IP: //p')
    duration=$(echo "$status_output" | sed -n 's/.*Duration: //p')

    tooltip="VPN: $vpn_name\nUser: $username\nIP: $ip\nDuration: $duration"
    echo "{\"text\": \"󰌾\", \"tooltip\": \"$tooltip\", \"class\": \"connected\", \"alt\": \"connected\"}"
else
    echo "{\"text\": \"󰌿\", \"tooltip\": \"VPN: Disconnected\", \"class\": \"disconnected\", \"alt\": \"disconnected\"}"
fi
