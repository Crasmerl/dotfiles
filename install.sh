#!/bin/bash
# Instala los dotfiles: crea enlaces simbólicos desde este repo a ~/.config,
# ~/.tmux.conf y ~/.local/bin. Lo que ya exista (y no sea un enlace) se mueve
# antes a ~/.dotfiles_backup/<fecha>/.
# Noctalia 5 se copia (no se enlaza) y se adapta a tu usuario y a tu monitor.

set -e

ROJO='\033[0;31m'
VERDE='\033[0;32m'
AMARILLO='\033[1;33m'
AZUL='\033[0;34m'
NC='\033[0m'

if [[ "$OSTYPE" != linux* ]]; then
  echo -e "${ROJO}Estos dotfiles son solo para Linux (Hyprland).${NC}"
  exit 1
fi

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Una sola carpeta de copia de seguridad para toda la instalación
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"
HUBO_BACKUP=0

echo -e "${AZUL}🚀 Instalando dotfiles desde $DOTFILES_DIR${NC}"

# Mueve a la copia de seguridad lo que exista y no sea un enlace
copia_seguridad() {
  local destino="$1"
  if [[ -e "$destino" && ! -L "$destino" ]]; then
    mkdir -p "$BACKUP_DIR"
    mv "$destino" "$BACKUP_DIR/"
    HUBO_BACKUP=1
    echo -e "${AMARILLO}  Copia de seguridad: $BACKUP_DIR/$(basename "$destino")${NC}"
  fi
}

# enlazar <origen> <destino> <descripción>
enlazar() {
  local origen="$1" destino="$2" desc="$3"
  [[ -e "$origen" ]] || return 0
  mkdir -p "$(dirname "$destino")"
  copia_seguridad "$destino"
  rm -rf "$destino"
  ln -s "$origen" "$destino"
  echo -e "${VERDE}  ✓ $desc${NC}"
}

echo -e "\n${AZUL}🔧 Configuraciones en ~/.config${NC}"
for app in hypr btop kitty wofi nvim fastfetch thefuck yazi fish; do
  enlazar "$DOTFILES_DIR/$app" "$HOME/.config/$app" "$app"
done
enlazar "$DOTFILES_DIR/starship/starship.toml" "$HOME/.config/starship.toml" "starship"
enlazar "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf" "tmux"

# Scripts propios: todos los de bin/ (los atajos de Hyprland y Noctalia los llaman desde ~/.local/bin)
echo -e "\n${AZUL}📜 Scripts en ~/.local/bin${NC}"
for s in "$DOTFILES_DIR"/bin/*; do
  [[ -f "$s" ]] && enlazar "$s" "$HOME/.local/bin/$(basename "$s")" "$(basename "$s")"
done

# Noctalia 5 (copia, no enlace). Lo cambiado desde la ventana de Ajustes
# va a ~/.local/state/noctalia/settings.toml (aquí settings-gui.toml).
# Solo se copia lo que no exista, para no pisar tu config.
if [[ -d "$DOTFILES_DIR/noctalia-v5" ]]; then
  echo -e "\n${AZUL}🌙 Noctalia 5${NC}"
  NOC_CONF="$HOME/.config/noctalia"
  NOC_STATE="$HOME/.local/state/noctalia"
  mkdir -p "$NOC_CONF" "$NOC_STATE"
  copiados=()
  for f in config.toml templates.toml plantillas colores-apps iconos; do
    if [[ ! -e "$NOC_CONF/$f" ]]; then
      cp -r "$DOTFILES_DIR/noctalia-v5/$f" "$NOC_CONF/"
      copiados+=("$NOC_CONF/$f")
    fi
  done
  if [[ ! -e "$NOC_STATE/settings.toml" ]]; then
    cp "$DOTFILES_DIR/noctalia-v5/settings-gui.toml" "$NOC_STATE/settings.toml"
    copiados+=("$NOC_STATE/settings.toml")
  fi

  if (( ${#copiados[@]} )); then
    # Adapta lo recién copiado: rutas de mi usuario → tu $HOME, y mi monitor → el tuyo
    monitor=""
    command -v hyprctl >/dev/null && command -v jq >/dev/null &&
      monitor=$(hyprctl monitors -j 2>/dev/null | jq -r '.[0].name // empty')
    adaptar() { find "${copiados[@]}" -type f \( -name '*.toml' -o -name '*.json' \) -exec sed -i "$1" {} +; }
    adaptar "s|/home/crasmerl|$HOME|g"
    if [[ -n "$monitor" && "$monitor" != "eDP-1" ]]; then
      adaptar "s|eDP-1|$monitor|g"
      echo -e "${VERDE}  ✓ Monitor cambiado de eDP-1 a $monitor${NC}"
    elif [[ -z "$monitor" ]]; then
      echo -e "${AMARILLO}  No he podido detectar tu monitor (¿Hyprland no está abierto?): la config usa eDP-1${NC}"
    fi
    echo -e "${VERDE}  ✓ Copiado: ${copiados[*]##*/}${NC}"
  else
    echo -e "${AMARILLO}  Ya tenías config de Noctalia: no se ha tocado${NC}"
  fi
fi

echo -e "\n${VERDE}🎉 ¡Listo!${NC}"
echo -e "\n${AZUL}📋 Siguientes pasos:${NC}"
echo -e "  1. Revisa ${AMARILLO}hypr/config/monitores.lua${NC}: tiene mis monitores, pon los tuyos"
echo -e "  2. Pon tus fondos en ~/Imágenes/Fondos (o cambia la carpeta en los ajustes de Noctalia)"
echo -e "  3. Abre otra terminal (fish) y reinicia la sesión de Hyprland"
echo -e "  4. Opcional: chuletas-teclado (ver README)"

if (( HUBO_BACKUP )); then
  echo -e "\n${AMARILLO}📦 Lo que tenías antes está en: $BACKUP_DIR${NC}"
fi
