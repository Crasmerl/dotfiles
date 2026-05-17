#!/usr/bin/env bash

key="${1:-title}"
p="$("$HOME/.config/eww/scripts/player_active.sh" 2>/dev/null)"

[ -z "$p" ] && { echo ""; exit 0; }

case "$key" in
  title)
    primary='{{xesam:title}}'
    fallback='{{title}}'
    ;;
  artist)
    primary='{{xesam:artist}}'
    fallback='{{artist}}'
    ;;
  album)
    primary='{{xesam:album}}'
    fallback='{{album}}'
    ;;
  *)
    echo ""
    exit 0
    ;;
esac

out="$(playerctl -p "$p" metadata --format "$primary" 2>/dev/null || true)"

# xesam:artist a veces viene como ["A","B"]
out="$(printf "%s" "$out" | sed -e 's/^\[\(.*\)\]$/\1/' -e 's/"//g' | tr -d '\n\r')"

if [ -z "${out// }" ]; then
  out="$(playerctl -p "$p" metadata --format "$fallback" 2>/dev/null || true)"
  out="$(printf "%s" "$out" | sed -e 's/^\[\(.*\)\]$/\1/' -e 's/"//g' | tr -d '\n\r')"
fi
echo "$(date) key=$key player=$p out='$out'" >> /tmp/eww_meta_debug.log



printf "%s\n" "$out"

