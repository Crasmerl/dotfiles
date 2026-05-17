#!/usr/bin/env bash
set -euo pipefail

p="$("$HOME/.config/eww/scripts/player_active.sh")"
[ -z "${p}" ] && echo "Play" && exit 0

st="$(playerctl -p "$p" status 2>/dev/null || true)"
if [ "$st" = "Playing" ]; then
  echo "⏸"
else
  echo "▶"
fi

