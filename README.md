# Crasmerl - Dotfiles

Archivos de configuración personales para mi setup de CachyOS (Arch) con Hyprland y Noctalia. Los colores de todo (bordes, terminal, Neovim, wofi, tmux, Discord, Firefox…) cambian según el fondo de pantalla. Siéntete libre de usarlos o coger inspiración.

Úsalos bajo tu propia responsabilidad.

Todo esto empezó a partir de los dotfiles de **Luis Mendoza**: [luismendozamx/dotfiles](https://github.com/luismendozamx/dotfiles). ¡Gracias por la base!

> [!NOTE]
> **Versión de Noctalia: esta configuración es para Noctalia 5.x** (paquete `noctalia`, el que trae CachyOS por defecto en Hyprland). Está en `noctalia-v5/`.
>
> - La config de la **4.x** (`noctalia-shell` + `noctalia-qs`, basada en Quickshell/Qt) sigue en `noctalia-v4/` por si alguien la quiere, pero ya no la uso.
> - **Qt 6.12 rompe Noctalia 4.x**: Qt añade su propio `Color` en QML, que tapa el de Noctalia, y la barra se queda en negro. Por eso me pasé a la 5.
> - `bin/noctalia-cambiar 5|4` cambia entre las dos versiones (arranque, bloqueo de pantalla y esquina activa).

![Los colores cambian según el fondo](./capturas/colores-segun-fondo.webp)

## Capturas

| | |
|---|---|
| ![Escritorio rojo](./capturas/escritorio-rojo.png) | ![Escritorio Miku](./capturas/escritorio-miku.png) |
| ![Trabajando en rojo](./capturas/trabajando-rojo.png) | ![Trabajando en Miku](./capturas/trabajando-miku.png) |
| ![Escritorio claro](./capturas/escritorio-claro.png) | ![Lanzador](./capturas/lanzador.png) |

![Terminales: cava, cmatrix y fastfetch](./capturas/terminales.webp)

<details>
<summary>Así empezó todo (mayo 2026)</summary>

![Rice de mayo](./capturas/rice-mayo-2026.png)

</details>

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
- Noctalia **5.x** (ver aviso arriba)
- fish + Starship
- tmux
- eza, fzf
- Kitty
- Neovim (NvChad)
- fastfetch
- wofi
- btop
- thefuck

## Qué incluye

| Carpeta | Descripción |
|---|---|
| **hypr/** | Hyprland en Lua: `hyprland.lua` carga las partes de `config/` (monitores, programas, apariencia, entrada, atajos, reglas); `hyprland.conf` queda de copia, hypridle y fondo de vídeo con audio que baja cuando hay ventanas |
| **noctalia-v5/** | Noctalia 5: `config.toml`, plantillas de colores según el fondo, iconos y ajustes de la ventana de Ajustes (`settings-gui.toml`). Se copia, no se enlaza. En `keybind-cheatsheet/` está el parche del keymap (nombres de teclas y orden Super+Shift): tras actualizar el plugin, ejecutar `aplicar.sh` |
| **noctalia-v4/** | Config antigua de Noctalia 4.x (ya no se usa) |
| **fish/** | Shell fish con frases y avisos de personajes (Miku, Teto, Adachi Rei…) |
| **starship/** | Prompt estilo powerline |
| **tmux/** | Multiplexor de terminal (uso desde el iPad por SSH) |
| **nvim/** | Neovim con NvChad, tema propio *cenote* y colores según el fondo |
| **kitty/** | Kitty con estela del cursor, colores según el fondo y barra de chuletas abajo (`tab_bar.py`) que cambia al mantener Ctrl, Ctrl+Shift o Alt |
| **chuletas-teclado/** | Servicio (root) que avisa a kitty de qué tecla Ctrl/Shift/Alt está pulsada. Instalar: copiar el script a `/usr/local/bin/`, el `.service` a `/etc/systemd/system/` y `systemctl enable --now chuletas-teclado` |
| **fastfetch/** | Info del sistema al abrir la terminal con logo personalizado |
| **btop/** | Monitor del sistema con tema de Noctalia |
| **wofi/** | Lanzador de aplicaciones, configuración y estilos |
| **thefuck/** | Configuración del corrector de comandos |
| **yazi/** | Gestor de archivos en terminal |
| **bin/** | Scripts: `colores-fondo` (colores según el fondo), `esconder-ventanas` (esquina activa), `ventanas-flotantes` (SUPER+F), `modo-silencioso` (ventiladores), `noctalia-cambiar`. Funcionan con la config en Lua y con la antigua |
