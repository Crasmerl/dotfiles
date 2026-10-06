#!/usr/bin/env bash
# Baja el volumen del fondo de vídeo (plugin mpvpaper de Noctalia) con un fundido
# cuando hay ventanas en el escritorio activo, y lo sube cuando está vacío
# (estilo Wallpaper Engine).
# El mute del plugin no se toca: si lo silencias desde Noctalia, sigue silenciado.

PLUGIN_SETTINGS="$HOME/.config/noctalia/plugins/mpvpaper/settings.json"
HYPR_SOCK="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

FADE_IN=1.2        # segundos que tarda en subir
FADE_OUT=0.6       # segundos que tarda en bajar
PASOS=30           # cuantos más pasos, más suave

# Socket de mpv y volumen máximo salen de los ajustes del plugin
# (el volumen es el de su barra; si no hay, 100)
mpv_sock() { jq -r '.mpvSocket // "/tmp/mpv-socket"' "$PLUGIN_SETTINGS" 2>/dev/null; }
vol_max()  { jq -r '.volume // 100 | floor' "$PLUGIN_SETTINGS" 2>/dev/null || echo 100; }

mpv_cmd() {
    echo "$1" | socat - "$(mpv_sock)" 2>/dev/null
}

volumen_actual() {
    mpv_cmd '{"command":["get_property","volume"]}' | jq -r '.data // 0 | floor'
}

fundido() {
    local destino=$1 duracion=$2
    local inicio; inicio=$(volumen_actual)
    local espera; espera=$(awk "BEGIN{print $duracion/$PASOS}")
    for i in $(seq 1 $PASOS); do
        local v=$(( inicio + (destino - inicio) * i / PASOS ))
        mpv_cmd "{\"command\":[\"set_property\",\"volume\",$v]}" >/dev/null
        sleep "$espera"
    done
}

FADE_PID=""
ULTIMO=""

fundido_en_marcha() { [ -n "$FADE_PID" ] && kill -0 "$FADE_PID" 2>/dev/null; }

update() {
    local ventanas objetivo destino
    ventanas=$(hyprctl activeworkspace -j | jq '.windows')
    if [ "$ventanas" -eq 0 ]; then objetivo=subir; else objetivo=bajar; fi

    if [ "$objetivo" = "$ULTIMO" ]; then
        # Mismo estado: solo corrige si el volumen se ha movido (vídeo nuevo,
        # Noctalia reiniciado, barra de volumen del plugin...)
        fundido_en_marcha && return
        if [ "$objetivo" = subir ]; then destino=$(vol_max); else destino=0; fi
        [ "$(volumen_actual)" = "$destino" ] && return
    fi
    ULTIMO=$objetivo

    # Si había un fundido a medias, se corta y el nuevo sigue desde ese volumen
    fundido_en_marcha && kill "$FADE_PID" 2>/dev/null
    if [ "$objetivo" = subir ]; then
        fundido "$(vol_max)" "$FADE_IN" &
    else
        fundido 0 "$FADE_OUT" &
    fi
    FADE_PID=$!
}

# Espera a que mpv responda (el plugin lo lanza al arrancar Noctalia)
for _ in $(seq 150); do
    mpv_cmd '{"command":["get_property","volume"]}' | grep -q success && break
    sleep 0.2
done

update
# Escucha los avisos de Hyprland. Si en 2 s no llega ninguno, revisa igualmente.
socat -U - UNIX-CONNECT:"$HYPR_SOCK" | while :; do
    if read -r -t 2 linea; then
        case "$linea" in
            openwindow*|closewindow*|movewindow*|workspace*|focusedmon*) update ;;
        esac
    elif [ $? -gt 128 ]; then
        update          # pasó el tiempo sin avisos
    else
        break           # Hyprland cerró la conexión
    fi
done
