#!/usr/bin/env bash
set -euo pipefail
what="${1:-pos}"   # pos | len | posfmt | lenfmt | pct
p="$("$HOME/.config/eww/scripts/player_active.sh")"
[ -z "${p}" ] && { [ "$what" = "lenfmt" ] && echo "0:00" || echo 0; exit 0; }

case "$what" in
  pos)
    playerctl -p "$p" position 2>/dev/null | awk '{printf "%d\n", $1}' || echo 0
    ;;
  len)
    us="$(playerctl -p "$p" metadata mpris:length 2>/dev/null || true)"
    [ -z "${us}" ] && echo 0 && exit 0
    awk -v us="$us" 'BEGIN{printf "%d\n", us/1000000}'
    ;;
  pct)
    pos_sec=$(playerctl -p "$p" position 2>/dev/null || echo 0)
    us_len=$(playerctl -p "$p" metadata mpris:length 2>/dev/null || echo 0)
    awk -v ps="$pos_sec" -v ul="$us_len" 'BEGIN{
      if (ul <= 0) { print 0; exit }
      pct = ps / (ul/1000000) * 100
      if (pct > 100) pct = 100
      if (pct < 0)   pct = 0
      printf "%.4f\n", pct
    }'
    ;;
  posfmt)
    sec=$(playerctl -p "$p" position 2>/dev/null | awk '{printf "%d\n", $1}' || echo 0)
    if (( sec >= 3600 )); then
      printf "%d:%02d:%02d\n" $((sec / 3600)) $(( (sec % 3600) / 60 )) $((sec % 60))
    else
      printf "%d:%02d\n" $((sec / 60)) $((sec % 60))
    fi
    ;;
  lenfmt)
    us="$(playerctl -p "$p" metadata mpris:length 2>/dev/null || true)"
    [ -z "${us}" ] && echo "0:00" && exit 0
    sec=$(awk -v us="$us" 'BEGIN{printf "%d\n", us/1000000}')
    if (( sec >= 3600 )); then
      printf "%d:%02d:%02d\n" $((sec / 3600)) $(( (sec % 3600) / 60 )) $((sec % 60))
    else
      printf "%d:%02d\n" $((sec / 60)) $((sec % 60))
    fi
    ;;
esac
