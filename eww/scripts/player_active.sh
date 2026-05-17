#!/usr/bin/env bash
set -euo pipefail

players="$(playerctl -l 2>/dev/null | grep -v '^plasma-browser-integration$' || true)"
[ -z "${players}" ] && exit 0

# Si alguno está reproduciendo, usa ese
while read -r p; do
  st="$(playerctl -p "$p" status 2>/dev/null || true)"
  if [ "$st" = "Playing" ]; then
    echo "$p"
    exit 0
  fi
done <<< "$players"

# Si no hay ninguno reproduciendo, usa el primero
echo "$players" | head -n1

