#!/usr/bin/env bash
set -euo pipefail
pct="${1:-0}"
p="$("$HOME/.config/eww/scripts/player_active.sh")"
[ -z "${p}" ] && exit 0
us_len=$(playerctl -p "$p" metadata mpris:length 2>/dev/null || echo 0)
[ "$us_len" = "0" ] && exit 0
sec=$(awk -v pct="$pct" -v ul="$us_len" 'BEGIN{printf "%.3f\n", pct/100 * ul/1000000}')
playerctl -p "$p" position "$sec" 2>/dev/null || true

