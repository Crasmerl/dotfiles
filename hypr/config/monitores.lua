-- Monitores (eDP-1 portátil, HDMI-A-4 y la XP-Pen en HDMI-A-1)

hl.monitor({ output = "eDP-1",    mode = "1920x1080@60", position = "0x0",    scale = 1 })
hl.monitor({ output = "HDMI-A-4", mode = "1920x1080@60", position = "3840x0", scale = 1 })
-- XP-Pen PenDisplay: con "preferred" (solo da 62.81 Hz)
hl.monitor({ output = "HDMI-A-1", mode = "preferred",    position = "1920x0", scale = 1 })
