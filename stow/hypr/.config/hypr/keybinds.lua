local terminal = "ghostty"
local browser = "google-chrome-stable"
local launcher = "rofi -show drun"

-- Terminal
hl.bind(
    "SUPER + RETURN",
    hl.dsp.exec_cmd(terminal),
    { description = "Open terminal" }
)

-- Browser
hl.bind(
    "SUPER + SHIFT + B",
    hl.dsp.exec_cmd(browser),
    { description = "Open browser" }
)

-- Launcher
hl.bind(
    "SUPER + SPACE",
    hl.dsp.exec_cmd(launcher),
    { description = "Open application launcher" }
)

-- Close window
hl.bind(
    "SUPER + W",
    hl.dsp.window.close(),
    { description = "Close active window" }
)

-- Toggle floating
hl.bind(
    "SUPER + V",
    hl.dsp.window.float(),
    { description = "Toggle floating" }
)

-- Fullscreen
hl.bind(
    "SUPER + F",
    hl.dsp.window.fullscreen(),
    { description = "Toggle fullscreen" }
)

-- Focus
hl.bind("SUPER + H", hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "r" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "d" }))

-- Move windows
hl.bind("SUPER + SHIFT + H", hl.dsp.window.move({ direction = "l" }))
hl.bind("SUPER + SHIFT + L", hl.dsp.window.move({ direction = "r" }))
hl.bind("SUPER + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
hl.bind("SUPER + SHIFT + J", hl.dsp.window.move({ direction = "d" }))

-- Exit
hl.bind(
    "SUPER + SHIFT + M",
    hl.dsp.exec_cmd("hyprshutdown"),
    { description = "Exit Hyprland" }
)
for i = 1, 9 do
    hl.bind(
        "SUPER + " .. i,
        hl.dsp.focus({ workspace = i }),
        { description = "Switch to workspace " .. i }
    )

    hl.bind(
        "SUPER + SHIFT + " .. i,
        hl.dsp.window.move({ workspace = i }),
        { description = "Move window to workspace " .. i }
    )
end
-- Volume
hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),
    { repeating = true }
)

hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { repeating = true }
)

hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
)
