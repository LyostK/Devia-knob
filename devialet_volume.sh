#!/usr/bin/env bash
#
# Devialet volume control script
# Usage:
#   ./devialet_volume.sh up        → increase volume
#   ./devialet_volume.sh down      → decrease volume
#   ./devialet_volume.sh 45        → set volume to 45%
#   ./devialet_volume.sh get       → show current volume
#
# EDIT THE SCRIPT WITH YOUR OWN DEVIALET_IP & SYSTEM_ID

# 🧩 Configuration: adjust these if your IP or systemId changes
DEVIALET_IP="XXX" 
SYSTEM_ID="XXX"
BASE_URL="http://${DEVIALET_IP}/ipcontrol/v1/systems/${SYSTEM_ID}/sources/current/soundControl"

# Function: display current volume
get_volume() {
    curl -s "${BASE_URL}/volume" | jq .
}

# Function: set a specific volume level (0–100)
set_volume() {
    local level="$1"
    if [[ "$level" =~ ^[0-9]+$ ]] && ((level >= 0 && level <= 100)); then
        curl -s -X POST -H "Content-Type: application/json" \
             -d "{\"volume\":${level}}" \
             "${BASE_URL}/volume" >/dev/null
        echo "✅ Volume set to ${level}%"
    else
        echo "❌ Invalid volume level (must be between 0 and 100)"
        exit 1
    fi
}

# Function: increase volume
volume_up() {
    curl -s -X POST "${BASE_URL}/volumeUp" >/dev/null
    echo "🔊 Volume increased"
}

# Function: decrease volume
volume_down() {
    curl -s -X POST "${BASE_URL}/volumeDown" >/dev/null
    echo "🔉 Volume decreased"
}

# Check if an argument was provided
if [[ -z "$1" ]]; then
    echo "Usage: $0 [up|down|get|<volume>]"
    exit 1
fi

# Handle the provided command
case "$1" in
    up) volume_up ;;
    down) volume_down ;;
    get) get_volume ;;
    ''|*[!0-9]*) echo "❌ Invalid argument: $1"; exit 1 ;;
    *) set_volume "$1" ;;
esac
