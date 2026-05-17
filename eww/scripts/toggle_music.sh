#!/usr/bin/env bash

WIN="music"
VAR="music_open"
MS=260  # debe coincidir aprox con :duration "250ms"

is_open() {
  eww active-windows 2>/dev/null | tr -d '\r' | grep -Fxq "$WIN"
}

# Si no está abierta: abrir y mostrar
if ! is_open; then
  eww open "$WIN"
  eww update "$VAR"=true
  exit 0
fi

cur="$(eww get "$VAR" 2>/dev/null | tr -d '\r\n')"

if [ "$cur" = "true" ]; then
  # ocultar y cerrar DESPUÉS (en background)
  eww update "$VAR"=false

  # background: espera y cierra (con python para sleep decimal)
  (python3 - <<PY
import time
time.sleep($MS/1000)
PY
  eww close "$WIN") >/dev/null 2>&1 &

else
  # estaba abierto pero oculto: mostrar
  eww update "$VAR"=true
fi

