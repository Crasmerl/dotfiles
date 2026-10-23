-- Programas al arrancar y variables de entorno

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


hl.env("XCURSOR_SIZE", "48")
hl.env("XCURSOR_THEME", "miku-cursor-linux")
hl.env("HYPRCURSOR_SIZE", "48")
hl.env("HYPRCURSOR_THEME", "miku-cursor-hyprcursor")
