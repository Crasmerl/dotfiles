#!/usr/bin/env bash
set -euo pipefail

all="$(playerctl -l 2>/dev/null || true)"
[ -z "${all}" ] && exit 0

# plasma-browser-integration primero: tiene artUrl y metadata completa del navegador
priority="$(echo "$all" | grep '^plasma-browser-integration$' || true)"
rest="$(echo "$all" | grep -v '^plasma-browser-integration$' || true)"
players="$(printf '%s\n%s' "$priority" "$rest" | sed '/^$/d')"

# Si alguno está reproduciendo, usa ese (con prioridad al orden arriba)
while read -r p; do
  st="$(playerctl -p "$p" status 2>/dev/null || true)"
  if [ "$st" = "Playing" ]; then
    echo "$p"
    exit 0
  fi
done <<< "$players"

# Si no hay ninguno reproduciendo, usa el primero
echo "$players" | head -n1

