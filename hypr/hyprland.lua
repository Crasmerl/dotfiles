-- Configuración de Hyprland en Lua (migrada desde hyprland.conf el 2026-10-23).
-- Este archivo solo carga las partes de config/. Hyprland carga cada una por separado:
-- si una tiene un error, sale en la barra roja (y en "hyprctl configerrors") con el
-- archivo y la línea, y las demás cargan igual (un fallo en las reglas no te deja sin atajos).
--
--   config/monitores.lua    pantallas (portátil, HDMI y la XP-Pen)
--   config/programas.lua    programas al arrancar y variables de entorno
--   config/apariencia.lua   huecos, bordes, sombras, desenfoque, layouts y animaciones
--   config/entrada.lua      teclado, touchpad, lápiz, gestos y ratón
--   config/atajos.lua       atajos de teclado (la chuleta de Noctalia los lee de aquí)
--   config/reglas.lua       reglas de ventana y de capa
--   colores-fondo.lua       borde con los colores del fondo (lo escribe ~/.local/bin/colores-fondo)
--
-- hyprland.conf se queda de copia: Hyprland usa este archivo si existe.
-- Referencia: /usr/share/hypr/hyprland.lua (ejemplo oficial) y https://wiki.hypr.land
-- Autocompletado en nvim: /usr/share/hypr/stubs/ (ver .luarc.json en esta carpeta)

-- Carga una parte. Si el archivo no existe, Hyprland no lo enseñaría (y pararía aquí):
-- se avisa con una notificación y se sigue con las demás.
local function cargar(nombre, opcional)
    if not pcall(require, nombre) and not opcional then
        hl.exec_cmd("notify-send -u critical 'Config de Hyprland' 'No se pudo cargar " .. nombre .. ".lua'")
    end
end

cargar("config/monitores")
cargar("config/programas")
cargar("config/apariencia")
cargar("config/entrada")
cargar("config/atajos")   -- la chuleta de Noctalia lee las categorías de aquí (hyprland_lua_config)
cargar("config/reglas")
cargar("colores-fondo", true) -- el último, para que su borde mande sobre el de apariencia.lua
