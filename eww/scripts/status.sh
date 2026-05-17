#!/usr/bin/env bash
set -euo pipefail
p="$("$HOME/.config/eww/scripts/player_active.sh")"
[ -z "${p}" ] && exit 0
playerctl -p "$p" status 2>/dev/null || true

