#!/bin/sh
# Vuelve a aplicar el parche del keymap de Noctalia (kenn/keybind-cheatsheet).
# Hace falta tras actualizar el plugin o desactivarlo y activarlo (se regenera).
#  - panel.patch:   nombres cortos de teclas (Play, Prev, Rueda ↑/↓)
#  - service.patch: con hyprland.lua, "Super Shift" en ese orden (no "Shift Super")
# El Pause repetido se oculta con show_undescribed = false en config.toml de Noctalia.
cd "$(dirname "$0")" || exit 1
PLUGIN=~/.local/state/noctalia/plugins/materialized/community/keybind-cheatsheet

for f in panel service; do
    if patch --dry-run -R -s -f "$PLUGIN/$f.luau" < $f.patch >/dev/null 2>&1; then
        echo "$f: el parche ya estaba puesto"
    else
        patch "$PLUGIN/$f.luau" < $f.patch || exit 1
    fi
done
noctalia msg plugin kenn/keybind-cheatsheet:data all refresh >/dev/null 2>&1
echo "Listo. Abre otra vez el keymap para verlo."
