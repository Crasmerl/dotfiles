# Crasmerl - Dotfiles

Archivos de configuración personales para mi setup de CachyOS (Arch) con Hyprland y Noctalia. Los colores de todo (bordes, terminal, Neovim, wofi, tmux, Discord, Firefox…) cambian según el fondo de pantalla. Siéntete libre de usarlos o coger inspiración.

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

- Hyprland
- Noctalia shell
- fish + Starship
- tmux
- eza, fzf
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

Opcionales (antiguos): zsh + oh-my-zsh, Waybar

## Qué incluye

| Carpeta | Descripción |
|---|---|
| **hypr/** | Hyprland, hyprlock, hypridle, hyprpaper |
| **noctalia/** | Barra Noctalia: ajustes, plantillas de colores según el fondo, iconos y plugin propio (se copia, no se enlaza) |
| **fish/** | Shell fish con frases y avisos de personajes (Miku, Teto, Adachi Rei…) |
| **starship/** | Prompt estilo powerline |
| **tmux/** | Multiplexor de terminal (uso desde el iPad por SSH) |
| **waybar/** | Barra de estado antigua, configuración y estilos |
| **eww/** | Widgets (reproductor de música) y scripts |
| **nvim/** | Neovim con NvChad, tema propio *cenote* y colores según el fondo |
| **kitty/** | Kitty con estela del cursor y colores según el fondo |
| **ghostty/** | Configuración de Ghostty |
| **fastfetch/** | Info del sistema al abrir la terminal con logo personalizado |
| **zsh/** | Zshrc, aliases y temas para Linux y macOS |
| **btop/** | Monitor del sistema con tema de Noctalia |
| **wofi/** | Lanzador de aplicaciones, configuración y estilos |
| **swaync/** | Estilos del centro de notificaciones |
| **thefuck/** | Configuración del corrector de comandos |
| **yazi/** | Gestor de archivos en terminal |
| **zellij/** | Layouts y configuración del multiplexor de terminal |
| **vscode/** | Ajustes y atajos de teclado de VSCode y Cursor |
| **git/** | Configuración global de git |
| **bin/** | Scripts de utilidad |
| **cursor/** | Acceso directo e icono del editor Cursor |
