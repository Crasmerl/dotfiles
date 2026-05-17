#!/usr/bin/env bash
set -euo pipefail
action="${1:-toggle}"
p="$("$HOME/.config/eww/scripts/player_active.sh")"
[ -z "${p}" ] && exit 0

case "$action" in
  toggle) playerctl -p "$p" play-pause ;;
  next)   playerctl -p "$p" next ;;
  prev)   playerctl -p "$p" previous ;;
  *) exit 1 ;;
esac

