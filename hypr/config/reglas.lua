-- Reglas de ventana y de capa

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


-- Reglas de capa
-- wofi: al abrir sube desde abajo pasando de transparente a normal; al cerrar, al revés
-- (el movimiento usa la velocidad de layersIn/layersOut y la transparencia la de
-- fadeLayersIn/fadeLayersOut, en apariencia.lua)
hl.layer_rule({ match = { namespace = "^(wofi)$" }, blur = true, ignore_alpha = 0.1, animation = "slide bottom" })
hl.layer_rule({ match = { namespace = "^(swaync-control-center)$" }, animation = "slide right" })
