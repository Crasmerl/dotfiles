-- Atajos de teclado
-- Programas que usan los atajos:
local terminal    = "kitty"
local fileManager = "kitty -e yazi"
local menu        = "wofi --show drun --style ~/.config/wofi/estilo-actual.css" -- estilo-actual: enlace que cambia colores-fondo
local browser     = "firefox"


-- Agrupados por categoría para la chuleta de Noctalia (keybind-cheatsheet):
-- encabezados "-- N. CATEGORÍA" y la descripción en { description = "..." }

local mainMod = "SUPER" -- tecla principal: Super (la de Windows)

-- 1. APLICACIONES
hl.bind(mainMod .. " + return",        hl.dsp.exec_cmd(terminal),    { description = "Abrir terminal (Kitty)" })
hl.bind(mainMod .. " + E",             hl.dsp.exec_cmd(fileManager), { description = "Abrir gestor de archivos" })
hl.bind(mainMod .. " + space",         hl.dsp.exec_cmd(menu),        { description = "Lanzador de apps (wofi)" })
hl.bind(mainMod .. " + SHIFT + E",     hl.dsp.exec_cmd("bemoji"),    { description = "Selector de emojis" })
hl.bind(mainMod .. " + I",             hl.dsp.exec_cmd("kitty --class claude-code -e claude"), { description = "Abrir Claude Code" })
hl.bind(mainMod .. " + B",             hl.dsp.exec_cmd(browser),     { description = "Abrir navegador" })

-- 2. VENTANAS
hl.bind(mainMod .. " + Q",             hl.dsp.window.close(),                     { description = "Cerrar ventana" })
hl.bind(mainMod .. " + V",             hl.dsp.window.float({ action = "toggle" }), { description = "Ventana flotante / mosaico" })
hl.bind(mainMod .. " + P",             hl.dsp.window.pseudo(),                    { description = "Modo pseudo (tamaño propio en mosaico)" })
hl.bind(mainMod .. " + J",             hl.dsp.layout("togglesplit"),              { description = "Cambiar división horizontal / vertical" })
hl.bind(mainMod .. " + left",          hl.dsp.focus({ direction = "l" }),         { description = "Ir a la ventana de la izquierda" })
hl.bind(mainMod .. " + right",         hl.dsp.focus({ direction = "r" }),         { description = "Ir a la ventana de la derecha" })
hl.bind(mainMod .. " + up",            hl.dsp.focus({ direction = "u" }),         { description = "Ir a la ventana de arriba" })
hl.bind(mainMod .. " + down",          hl.dsp.focus({ direction = "d" }),         { description = "Ir a la ventana de abajo" })
hl.bind(mainMod .. " + F",             hl.dsp.exec_cmd("~/.local/bin/ventanas-flotantes"), { description = "Todas flotantes / volver al mosaico" })
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.swap({ direction = "l" }),   { description = "Intercambiar con la de la izquierda" })
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.swap({ direction = "r" }),   { description = "Intercambiar con la de la derecha" })
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.swap({ direction = "u" }),   { description = "Intercambiar con la de arriba" })
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.swap({ direction = "d" }),   { description = "Intercambiar con la de abajo" })
hl.bind(mainMod .. " + minus",         hl.dsp.window.resize({ x = -100, y = 0, relative = true }), { description = "Estrechar ventana" })
hl.bind(mainMod .. " + plus",          hl.dsp.window.resize({ x = 100,  y = 0, relative = true }), { description = "Ensanchar ventana" })
hl.bind(mainMod .. " + SHIFT + minus", hl.dsp.window.resize({ x = 0, y = -100, relative = true }), { description = "Encoger ventana (alto)" })
hl.bind(mainMod .. " + SHIFT + plus",  hl.dsp.window.resize({ x = 0, y = 100,  relative = true }), { description = "Estirar ventana (alto)" })
hl.bind(mainMod .. " + Tab",           hl.dsp.exec_cmd("noctalia msg window-switcher"), { description = "Selector de ventanas" })
hl.bind(mainMod .. " + SHIFT + Tab",   hl.dsp.window.cycle_next({ next = false }), { description = "Ventana anterior", repeating = true })

-- 3. SISTEMA
hl.bind(mainMod .. " + M",             hl.dsp.exit(),                                 { description = "Salir de Hyprland" })
hl.bind(mainMod .. " + L",             hl.dsp.exec_cmd("noctalia msg session lock"), { description = "Bloquear pantalla" })

-- 4. CAPTURAS
hl.bind("PRINT",                       hl.dsp.exec_cmd("hyprshot -m output"), { description = "Captura de pantalla completa" })
hl.bind("SHIFT + PRINT",               hl.dsp.exec_cmd("hyprshot -m region"), { description = "Captura de una zona" })

-- 5. ESCRITORIOS
-- (dos bucles separados para que la chuleta los junte en una fila "1-0")
for i = 1, 10 do
    local tecla = i % 10 -- el escritorio 10 va en la tecla 0
    hl.bind(mainMod .. " + " .. tecla, hl.dsp.focus({ workspace = i }), { description = "Ir al escritorio " .. i })
end
for i = 1, 10 do
    local tecla = i % 10
    hl.bind(mainMod .. " + SHIFT + " .. tecla, hl.dsp.window.move({ workspace = i }), { description = "Mover ventana al escritorio " .. i })
end
hl.bind(mainMod .. " + S",             hl.dsp.workspace.toggle_special("magic"),               { description = "Mostrar / ocultar escritorio especial" })
hl.bind(mainMod .. " + SHIFT + S",     hl.dsp.window.move({ workspace = "special:magic" }),     { description = "Mandar ventana al escritorio especial" })
hl.bind(mainMod .. " + mouse_down",    hl.dsp.focus({ workspace = "e+1" }),                     { description = "Escritorio siguiente" })
hl.bind(mainMod .. " + mouse_up",      hl.dsp.focus({ workspace = "e-1" }),                     { description = "Escritorio anterior" })

-- 6. RATÓN
hl.bind(mainMod .. " + mouse:272",     hl.dsp.window.drag(),   { description = "Arrastrar para mover ventana", mouse = true })
hl.bind(mainMod .. " + mouse:273",     hl.dsp.window.resize(), { description = "Arrastrar para cambiar tamaño", mouse = true })

-- 7. SONIDO Y BRILLO
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),     { description = "Subir volumen",       locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),     { description = "Bajar volumen",       locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),    { description = "Silenciar sonido",    locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),  { description = "Silenciar micrófono", locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl s 10%+"),                          { description = "Subir brillo",        locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"),                          { description = "Bajar brillo",        locked = true, repeating = true })

-- 8. MÚSICA
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { description = "Siguiente canción",   locked = true })
-- Pause sin descripción a propósito: hace lo mismo que Play y así no sale repetido en la chuleta
-- (show_undescribed = false en Noctalia). Se deja porque algunos auriculares Bluetooth mandan Pause.
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { description = "Reproducir / pausar", locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { description = "Canción anterior",    locked = true })
