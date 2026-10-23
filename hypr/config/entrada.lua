-- Teclado, touchpad, lápiz de la XP-Pen, gestos y ratón

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
