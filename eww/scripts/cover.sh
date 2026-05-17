#!/usr/bin/env bash
set -euo pipefail

p="$("$HOME/.config/eww/scripts/player_active.sh")"
[ -z "${p}" ] && exit 0

url="$(playerctl -p "$p" metadata mpris:artUrl 2>/dev/null || true)"
out="$HOME/.cache/eww/cover.jpg"

# Si es file://, úsalo directo
if [[ "$url" == file://* ]]; then
  echo "${url#file://}"
  exit 0
fi

# Si es http(s), descárgalo
if [[ "$url" == http* ]]; then
  # Evita descargar si ya está igual
  if [ -f "$HOME/.cache/eww/cover.url" ] && grep -qx "$url" "$HOME/.cache/eww/cover.url"; then
    echo "$out"
    exit 0
  fi

  echo "$url" > "$HOME/.cache/eww/cover.url"
  curl -fsSL "$url" -o "$out" 2>/dev/null || true
  echo "$out"
  exit 0
fi

# Sin carátula
exit 0

