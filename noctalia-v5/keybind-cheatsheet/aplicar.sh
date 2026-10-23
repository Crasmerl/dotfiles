#!/bin/sh
# Vuelve a aplicar el parche del keymap de Noctalia (kenn/keybind-cheatsheet).
# Hace falta tras actualizar el plugin o desactivarlo y activarlo (se regenera).
# Cambia nombres de teclas (Play, Prev, Rueda ↑/↓) y oculta el atajo de Pause repetido.
cd "$(dirname "$0")" || exit 1
PLUGIN=~/.local/state/noctalia/plugins/materialized/community/keybind-cheatsheet
DATOS=~/.local/state/noctalia/plugins/data/kenn/keybind-cheatsheet

if patch --dry-run -R -s -f "$PLUGIN/panel.luau" < panel.patch >/dev/null 2>&1; then
    echo "El parche ya estaba puesto"
else
    patch "$PLUGIN/panel.luau" < panel.patch || exit 1
fi
mkdir -p "$DATOS" && cp preferences.json "$DATOS/"
echo "Listo. Abre otra vez el keymap para verlo."
