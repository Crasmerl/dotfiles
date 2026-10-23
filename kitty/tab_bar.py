# Barra de pestañas con chuletas a la derecha (estilo zellij).
# Son dinámicas: al mantener Ctrl, Ctrl+Shift o Alt salen los atajos de esa tecla.
# Hyprland escribe la tecla pulsada en ESTADO (ver ~/.config/hypr/chuletas-kitty.conf).
import os
import sys

from kitty.boss import get_boss
from kitty.fast_data_types import Screen, add_timer, remove_timer, wcswidth
from kitty.tab_bar import DrawData, ExtraData, TabBarData, as_rgb, draw_tab_with_powerline
from kitty.utils import color_as_int

ESTADO = "/run/user/1000/kitty-mods"

# modo: (nombre que se muestra, [(tecla, qué hace)])
# si no caben todas, se quitan empezando por el final
CHULETAS = {
    "": ("", [("Ctrl", "terminal"), ("Ctrl⇧", "kitty"), ("Alt", "paneles y fish")]),
    "ctrl": ("CTRL", [
        ("C", "cancelar"),
        ("L", "limpiar"),
        ("R", "buscar historial"),
        ("D", "salir"),
        ("Z", "pausar"),
        ("A/E", "inicio/fin"),
        ("W", "borrar palabra"),
    ]),
    "ctrlshift": ("CTRL ⇧", [
        ("T", "pestaña"),
        ("Enter", "panel"),
        ("W", "cerrar panel"),
        ("Q", "cerrar pestaña"),
        ("←→", "cambiar pestaña"),
        ("C/V", "copiar/pegar"),
        ("H", "historial"),
        ("+/-", "zoom"),
    ]),
    "alt": ("ALT", [
        ("←↑↓→", "moverse"),
        ("C", "ir a carpeta"),
        ("S", "poner sudo"),
        ("E", "editar en nvim"),
        ("L", "ls"),
        ("H", "ayuda"),
    ]),
}

_modo = ""


def _leer_modo() -> str:
    try:
        with open(ESTADO) as f:
            modo = f.read().strip()
    except OSError:
        return ""
    return modo if modo in CHULETAS else ""


def _vigilar(timer_id) -> None:
    # Cada 0.1 s mira si cambió la tecla pulsada y, si cambió, redibuja la barra
    global _modo
    modo = _leer_modo()
    if modo != _modo:
        _modo = modo
        for tm in get_boss().all_tab_managers:
            tm.mark_tab_bar_dirty()


# Al recargar la config este archivo se vuelve a cargar: quitar el reloj anterior
if hasattr(sys, "_chuletas_timer"):
    remove_timer(sys._chuletas_timer)
sys._chuletas_timer = add_timer(_vigilar, 0.1, True)


def _hay_claude(tab: TabBarData) -> bool:
    # True si en el panel activo de la pestaña está corriendo Claude Code
    try:
        pestaña = get_boss().tab_for_id(tab.tab_id)
        procesos = pestaña.active_window.child.foreground_processes
    except Exception:
        return False
    return any(
        os.path.basename(arg) == "claude"
        for p in procesos
        for arg in p.get("cmdline", [])[:2]
    )


def _ancho(titulo, chuletas):
    ancho = wcswidth(f" {titulo} ") + 1 if titulo else 0
    return ancho + sum(wcswidth(f" {k} ") + wcswidth(f" {d} ") for k, d in chuletas)


def _dibujar_chuletas(draw_data: DrawData, screen: Screen) -> None:
    titulo, chuletas = CHULETAS[_modo]
    chuletas = list(chuletas)
    libre = screen.columns - screen.cursor.x - 2
    while chuletas and _ancho(titulo, chuletas) > libre:
        chuletas.pop()
    if not chuletas:
        return

    screen.cursor.x = screen.columns - _ancho(titulo, chuletas)
    tecla_fg = as_rgb(color_as_int(draw_data.active_fg))
    tecla_bg = as_rgb(color_as_int(draw_data.active_bg))
    texto_fg = as_rgb(color_as_int(draw_data.inactive_fg))
    texto_bg = as_rgb(color_as_int(draw_data.inactive_bg))
    fondo = as_rgb(color_as_int(draw_data.default_bg))

    if titulo:
        screen.cursor.fg, screen.cursor.bg, screen.cursor.bold = texto_fg, texto_bg, True
        screen.draw(f" {titulo} ")
        screen.cursor.bg = fondo
        screen.draw(" ")
    for tecla, texto in chuletas:
        screen.cursor.fg, screen.cursor.bg, screen.cursor.bold = tecla_fg, tecla_bg, True
        screen.draw(f" {tecla} ")
        screen.cursor.fg, screen.cursor.bg, screen.cursor.bold = texto_fg, fondo, False
        screen.draw(f" {texto} ")


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    # Con Claude abierto: sin chuletas, y si es la única pestaña, barra vacía
    claude = tab.is_active and _hay_claude(tab)
    if claude and index == 1 and is_last:
        return screen.cursor.x
    end = draw_tab_with_powerline(
        draw_data, screen, tab, before, max_title_length, index, is_last, extra_data
    )
    if is_last and not claude:
        _dibujar_chuletas(draw_data, screen)
    return end
