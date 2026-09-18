#!/bin/bash

# Docker status for Waybar
# Usage: docker.sh          -> outputs JSON status for waybar
#        docker.sh toggle   -> start/stop the docker service (click action)

# Start/stop the Docker service on click (pkexec shows a graphical password prompt)
if [ "$1" = "toggle" ]; then
    if systemctl is-active --quiet docker; then
        pkexec systemctl stop docker
    else
        pkexec systemctl start docker
    fi
    exit 0
fi

icon="󰡨"

if systemctl is-active --quiet docker; then
    tooltip="Docker: running"
    # Container/image stats require access to the docker socket (docker group)
    if docker info >/dev/null 2>&1; then
        running=$(docker ps -q 2>/dev/null | wc -l)
        total=$(docker ps -aq 2>/dev/null | wc -l)
        images=$(docker images -q 2>/dev/null | wc -l)
        tooltip="Docker: running\nContainers: $running up / $total total\nImages: $images"
    fi
    echo "{\"text\": \"$icon\", \"tooltip\": \"$tooltip\", \"class\": \"running\", \"alt\": \"running\"}"
else
    echo "{\"text\": \"$icon\", \"tooltip\": \"Docker: stopped\nClick to start\", \"class\": \"stopped\", \"alt\": \"stopped\"}"
fi
