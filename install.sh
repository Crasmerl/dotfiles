#!/bin/bash

# Dotfiles installation script
# This script creates symbolic links from the dotfiles repo to the appropriate locations

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the directory where this script is located (the dotfiles repo root)
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Detect OS
OS="unknown"
case "$OSTYPE" in
  darwin*)  OS="mac" ;;
  linux*)   OS="linux" ;;
  *)        echo -e "${RED}Unsupported OS: $OSTYPE${NC}"; exit 1 ;;
esac

echo -e "${BLUE}🚀 Installing dotfiles for $OS...${NC}"
echo -e "${BLUE}Dotfiles directory: $DOTFILES_DIR${NC}"

# Function to create backup
backup_file() {
  local file="$1"
  if [[ -e "$file" && ! -L "$file" ]]; then
    local backup_dir="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$backup_dir"
    mv "$file" "$backup_dir/"
    echo -e "${YELLOW}  Backed up existing file to: $backup_dir/$(basename "$file")${NC}"
  fi
}

# Function to create symbolic link
create_symlink() {
  local src="$1"
  local dest="$2"
  local desc="$3"
  
  echo -e "${BLUE}Installing $desc...${NC}"
  
  # Create parent directory if it doesn't exist
  mkdir -p "$(dirname "$dest")"
  
  # Backup existing file/directory if it exists and is not a symlink
  backup_file "$dest"
  
  # Remove existing symlink or file
  rm -rf "$dest"
  
  # Create the symlink
  ln -sf "$src" "$dest"
  echo -e "${GREEN}  ✓ $desc installed${NC}"
}

# Function to copy files (for cases where symlinks aren't appropriate)
copy_file() {
  local src="$1"
  local dest="$2"
  local desc="$3"
  
  echo -e "${BLUE}Installing $desc...${NC}"
  
  # Create parent directory if it doesn't exist
  mkdir -p "$(dirname "$dest")"
  
  # Backup existing file
  backup_file "$dest"
  
  # Copy the file
  cp "$src" "$dest"
  echo -e "${GREEN}  ✓ $desc installed${NC}"
}

echo -e "${BLUE}📁 Creating ~/.config directory if it doesn't exist...${NC}"
mkdir -p "$HOME/.config"

# Install configs that go to ~/.config/
echo -e "\n${BLUE}🔧 Installing application configs to ~/.config/...${NC}"

# Hyprland (Linux only)
if [[ "$OS" == "linux" && -d "$DOTFILES_DIR/hypr" ]]; then
  create_symlink "$DOTFILES_DIR/hypr" "$HOME/.config/hypr" "Hyprland window manager config"
fi

# btop system monitor
if [[ -d "$DOTFILES_DIR/btop" ]]; then
  create_symlink "$DOTFILES_DIR/btop" "$HOME/.config/btop" "btop system monitor config"
fi

# Kitty terminal
if [[ -d "$DOTFILES_DIR/kitty" ]]; then
  create_symlink "$DOTFILES_DIR/kitty" "$HOME/.config/kitty" "Kitty terminal config"
fi

# Wofi launcher (Linux only)
if [[ "$OS" == "linux" && -d "$DOTFILES_DIR/wofi" ]]; then
  create_symlink "$DOTFILES_DIR/wofi" "$HOME/.config/wofi" "Wofi launcher config"
fi


# Neovim
if [[ -d "$DOTFILES_DIR/nvim" ]]; then
  create_symlink "$DOTFILES_DIR/nvim" "$HOME/.config/nvim" "Neovim config"
fi

# fastfetch
if [[ -d "$DOTFILES_DIR/fastfetch" ]]; then
  create_symlink "$DOTFILES_DIR/fastfetch" "$HOME/.config/fastfetch" "fastfetch config"
fi

# thefuck
if [[ -d "$DOTFILES_DIR/thefuck" ]]; then
  create_symlink "$DOTFILES_DIR/thefuck" "$HOME/.config/thefuck" "thefuck config"
fi

# yazi file manager
if [[ -d "$DOTFILES_DIR/yazi" ]]; then
  create_symlink "$DOTFILES_DIR/yazi" "$HOME/.config/yazi" "yazi config"
fi

# fish shell
if [[ -d "$DOTFILES_DIR/fish" ]]; then
  create_symlink "$DOTFILES_DIR/fish" "$HOME/.config/fish" "fish config"
fi

# starship prompt
if [[ -f "$DOTFILES_DIR/starship/starship.toml" ]]; then
  create_symlink "$DOTFILES_DIR/starship/starship.toml" "$HOME/.config/starship.toml" "starship config"
fi

# tmux
if [[ -f "$DOTFILES_DIR/tmux/tmux.conf" ]]; then
  create_symlink "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf" "tmux config"
fi

# Noctalia 5 (copia, no enlace). Lo cambiado desde la ventana de Ajustes
# va a ~/.local/state/noctalia/settings.toml (aquí settings-gui.toml)
if [[ "$OS" == "linux" && -d "$DOTFILES_DIR/noctalia-v5" ]]; then
  mkdir -p "$HOME/.config/noctalia" "$HOME/.local/state/noctalia"
  for f in config.toml templates.toml plantillas colores-apps iconos; do
    cp -rn "$DOTFILES_DIR/noctalia-v5/$f" "$HOME/.config/noctalia/"
  done
  cp -n "$DOTFILES_DIR/noctalia-v5/settings-gui.toml" "$HOME/.local/state/noctalia/settings.toml"
  echo -e "${GREEN}✓${NC} Noctalia 5 config copied"
fi

# Scripts propios (colores según el fondo, esquina activa, ventiladores, cambio 4/5)
if [[ "$OS" == "linux" ]]; then
  for s in colores-fondo esconder-ventanas modo-silencioso noctalia-cambiar; do
    [[ -f "$DOTFILES_DIR/bin/$s" ]] && create_symlink "$DOTFILES_DIR/bin/$s" "$HOME/.local/bin/$s" "$s"
  done
fi

echo -e "\n${GREEN}🎉 Dotfiles installation completed!${NC}"
echo -e "\n${BLUE}📋 Next steps:${NC}"
echo -e "  1. Restart your terminal (fish)"
echo -e "  2. If you installed Hyprland configs, restart your session"
echo -e "  3. Configure any application-specific settings as needed"

if [[ -d "$HOME/.dotfiles_backup" ]]; then
  echo -e "\n${YELLOW}📦 Backed up files are stored in: ~/.dotfiles_backup${NC}"
fi

echo -e "\n${GREEN}✨ Happy coding!${NC}"
