-- Configuración de Hyprland en Lua (migrada desde hyprland.conf el 2026-10-23).
-- El hyprland.conf de antes se queda como copia: Hyprland usa este archivo si existe.
-- Referencia: /usr/share/hypr/hyprland.lua (ejemplo oficial) y https://wiki.hypr.land
-- Autocompletado en nvim: /usr/share/hypr/stubs/ (ver .luarc.json en esta carpeta)


----------------
--- MONITORES ---
----------------

hl.monitor({ output = "eDP-1",    mode = "1920x1080@60", position = "0x0",    scale = 1 })
hl.monitor({ output = "HDMI-A-4", mode = "1920x1080@60", position = "3840x0", scale = 1 })
-- XP-Pen PenDisplay: con "preferred" (solo da 62.81 Hz)
hl.monitor({ output = "HDMI-A-1", mode = "preferred",    position = "1920x0", scale = 1 })


-----------------
--- PROGRAMAS ---
-----------------

local terminal    = "kitty"
local fileManager = "kitty -e yazi"
local menu        = "wofi --show drun --style ~/.config/wofi/estilo-actual.css" -- estilo-actual: enlace que cambia colores-fondo
local browser     = "firefox"


-----------------
--- AL ARRANCAR ---
-----------------

hl.on("hyprland.start", function()
    hl.exec_cmd("~/.config/hypr/scripts/wallpaper-audio.sh") -- baja el audio del fondo de vídeo cuando hay ventanas
    hl.exec_cmd("noctalia")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("hyprsunset")
    hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
    hl.exec_cmd("xwaylandvideobridge")
end)
-- Quitados (referencia): mpvpaper (ahora el plugin de Noctalia), waycorner (Noctalia 5: [hot_corners]),
-- waybar/swaync (antes de Noctalia), eww (2026-10-03), nm-applet y blueman-applet (en Noctalia),
-- hyprswitch (se colgaba), cava de fondo con SUPER+C (2026-10-04)


----------------------------
--- VARIABLES DE ENTORNO ---
----------------------------

hl.env("XCURSOR_SIZE", "48")
hl.env("XCURSOR_THEME", "miku-cursor-linux")
hl.env("HYPRCURSOR_SIZE", "48")
hl.env("HYPRCURSOR_THEME", "miku-cursor-hyprcursor")


-----------------
--- APARIENCIA ---
-----------------

hl.config({
    general = {
        gaps_in     = 2,
        gaps_out    = 5,
        border_size = 2,
        col = {
            active_border   = { colors = { "rgba(00FFEAee)", "rgba(40E0CFee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },
        resize_on_border = false,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding         = 5,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = "rgba(1a1a1aee)",
        },
        blur = {
            enabled           = true,
            size              = 5,
            passes            = 2,
            new_optimizations = true,
            vibrancy          = 0.00451,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo   = true,
    },
})


-------------------
--- ANIMACIONES ---
-------------------

hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1.08} } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })
hl.curve("bounce",         { type = "bezier", points = { {0.22, 1.3},  {0.36, 1}    } })

hl.animation({ leaf = "global",           enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",           enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",          enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",        enabled = true, speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",       enabled = true, speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",           enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",          enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",             enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",           enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",         enabled = true, speed = 5,    bezier = "bounce",       style = "slide" })
hl.animation({ leaf = "layersOut",        enabled = true, speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",     enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut",    enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",       enabled = true, speed = 5,    bezier = "bounce",       style = "slide" })
hl.animation({ leaf = "workspacesIn",     enabled = true, speed = 5,    bezier = "bounce",       style = "slide" })
hl.animation({ leaf = "workspacesOut",    enabled = true, speed = 3,    bezier = "quick",        style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 5,    bezier = "bounce",       style = "slidevert" }) -- SUPER+S entra desde abajo


---------------
--- ENTRADA ---
---------------

hl.config({
    input = {
        kb_layout  = "es",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",
        follow_mouse = 1,
        sensitivity  = 0, -- -1.0 - 1.0, 0 = sin cambios
        touchpad = {
            natural_scroll = true,
        },
        tablet = {
            output = "HDMI-A-1", -- el lápiz de la XP-Pen solo en su pantalla
        },
    },
})

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})


---------------
--- ATAJOS ---
---------------
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


------------------------
--- REGLAS DE VENTANA ---
------------------------

-- Ventana de Claude Code (SUPER+I)
hl.window_rule({
    name   = "claude-code",
    match  = { class = "claude-code" },
    size   = { 1200, 800 },
    center = true,
})

-- Ignorar peticiones de maximizar de las apps
hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- Arreglo para arrastrar en XWayland
hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

hl.window_rule({
    name  = "xwayland-video-bridge-fixes",
    match = { class = "xwaylandvideobridge" },
    no_initial_focus = true,
    no_focus = true,
    no_anim  = true,
    no_blur  = true,
    max_size = { 1, 1 },
    opacity  = "0.0",
})

hl.window_rule({
    name    = "chatgpt",
    match   = { class = "chrome-dmnhimeelpmaahoojjaopiiljgmhogde-Default" },
    opacity = "0.88 0.80",
})

hl.window_rule({
    name    = "whatsapp-web",
    match   = { class = "chrome-hnpfjngllnobngcgfapefoaidbinmjnm-Default" },
    opacity = "0.88 0.80",
})

hl.window_rule({
    name    = "kitty-transparente",
    match   = { class = "kitty" },
    opacity = "0.88 0.80",
})

hl.window_rule({
    name  = "youtube-music-mini-player",
    match = { title = "YouTube Music - Mini Player" },
    float = true,
})

-- Borde rojo Teto en las flotantes (no cambia con el fondo)
hl.window_rule({
    name  = "borde-flotantes",
    match = { float = true },
    border_color = { colors = { "rgba(E8344Eee)", "rgba(FF7A8Aee)" }, angle = 45 },
})


---------------------
--- REGLAS DE CAPA ---
---------------------

hl.layer_rule({ match = { namespace = "^(wofi)$" }, blur = true, ignore_alpha = 0.1 })
hl.layer_rule({ match = { namespace = "^(swaync-control-center)$" }, animation = "slide right" })


----------------------------------
--- COLORES DEL BORDE SEGÚN EL FONDO ---
----------------------------------
-- ~/.local/bin/colores-fondo deja aquí el borde con los colores del fondo de Noctalia
-- (con background.png el archivo queda vacío = borde de siempre)
pcall(require, "colores-fondo")
