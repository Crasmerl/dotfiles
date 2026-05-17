# Crasmerl - Dotfiles

Archivos de configuración personales para mi setup de Arch Linux con Hyprland. Siéntete libre de usarlos o coger inspiración.

Úsalos bajo tu propia responsabilidad.

![Captura de pantalla](./screenshot.png)

## Instalación

```bash
mkdir -p ~/dev/config
git clone https://github.com/Crasmerl/dotfiles.git ~/dev/config/dotfiles
cd ~/dev/config/dotfiles
./install.sh
```

El script de instalación crea los symlinks automáticamente y hace una copia de seguridad de las configuraciones existentes en `~/.dotfiles_backup/`.

## Requisitos

- zsh + oh-my-zsh
- Hyprland
- Waybar
- Kitty o Ghostty
- Neovim (NvChad)
- fastfetch
- eww
- wofi
- swaync
- btop
- thefuck
- zellij
- git

## Qué incluye

| Carpeta | Descripción |
|---|---|
| **hypr/** | Hyprland, hyprlock, hypridle, hyprpaper |
| **waybar/** | Barra de estado, configuración y estilos |
| **eww/** | Widgets (reproductor de música) y scripts |
| **nvim/** | Configuración de Neovim con NvChad y plugins |
| **kitty/** | Configuración y tema de Kitty |
| **ghostty/** | Configuración de Ghostty |
| **fastfetch/** | Info del sistema al abrir la terminal con logo personalizado |
| **zsh/** | Zshrc, aliases y temas para Linux y macOS |
| **btop/** | Monitor del sistema con tema Tokyo Night |
| **wofi/** | Lanzador de aplicaciones, configuración y estilos |
| **swaync/** | Estilos del centro de notificaciones |
| **thefuck/** | Configuración del corrector de comandos |
| **zellij/** | Layouts y configuración del multiplexor de terminal |
| **vscode/** | Ajustes y atajos de teclado de VSCode y Cursor |
| **git/** | Configuración global de git |
| **bin/** | Scripts de utilidad |
| **cursor/** | Acceso directo e icono del editor Cursor |
