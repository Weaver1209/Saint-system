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
hl.bind("SUPER + SHIFT + LEFT", hl.dsp.window.move({ direction = "l" }))
hl.bind("SUPER + SHIFT + RIGHT", hl.dsp.window.move({ direction = "r" }))
hl.bind("SUPER + SHIFT + UP", hl.dsp.window.move({ direction = "u" }))
hl.bind("SUPER + SHIFT + DOWN", hl.dsp.window.move({ direction = "d" }))

-- Applications (SUPER + SHIFT + E, L, N)
hl.bind(
    "SUPER + SHIFT + E",
    hl.dsp.exec_cmd("nautilus"),
    { description = "Open Nautilus file manager" }
)

hl.bind(
    "SUPER + SHIFT + L",
    hl.dsp.exec_cmd("slack"),
    { description = "Open Slack" }
)

hl.bind(
    "SUPER + SHIFT + N",
    hl.dsp.exec_cmd("ghostty -e nvim"),
    { description = "Open Neovim" }
)

hl.bind(
    "SUPER + SHIFT + O",
    hl.dsp.exec_cmd("ghostty -e $HOME/.local/bin/omp"),
    { description = "Open Oh My Pi (OMP)" }
)
hl.bind(
    "SUPER + SHIFT + S",
    hl.dsp.exec_cmd("spotify"),
    { description = "Open Spotify" }
)

hl.bind(
    "SUPER + SHIFT + W",
    hl.dsp.exec_cmd("$HOME/.local/bin/kiku-launch-webapp https://web.whatsapp.com"),
    { description = "Open WhatsApp Web" }
)

hl.bind(
    "SUPER + SHIFT + Y",
    hl.dsp.exec_cmd("$HOME/.local/bin/kiku-launch-webapp https://www.youtube.com"),
    { description = "Open YouTube" }
)
-- Exit
hl.bind(
    "SUPER + SHIFT + M",
    hl.dsp.exec_cmd("hyprshutdown"),
    { description = "Exit Hyprland" }
)
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(
        "SUPER + " .. key,
        hl.dsp.focus({ workspace = i }),
        { description = "Switch to workspace " .. i }
    )

    hl.bind(
        "SUPER + SHIFT + " .. key,
        hl.dsp.window.move({ workspace = i }),
        { description = "Move window to workspace " .. i }
    )
end
-- Volume & Mute
hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/volume-control.sh up"),
    { locked = true, repeating = true, description = "Raise volume" }
)

hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/volume-control.sh down"),
    { locked = true, repeating = true, description = "Lower volume" }
)

hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/volume-control.sh mute"),
    { locked = true, description = "Toggle audio mute" }
)

hl.bind(
    "XF86AudioMicMute",
    hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/volume-control.sh mic-mute"),
    { locked = true, description = "Toggle microphone mute" }
)

-- Brightness
hl.bind(
    "XF86MonBrightnessUp",
    hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/brightness-control.sh up"),
    { locked = true, repeating = true, description = "Increase brightness" }
)

hl.bind(
    "XF86MonBrightnessDown",
    hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/brightness-control.sh down"),
    { locked = true, repeating = true, description = "Decrease brightness" }
)

-- Media Controls (playerctl)
hl.bind(
    "XF86AudioPlay",
    hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/media-control.sh play-pause"),
    { locked = true, description = "Play/pause media" }
)

hl.bind(
    "XF86AudioPause",
    hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/media-control.sh play-pause"),
    { locked = true, description = "Pause media" }
)

hl.bind(
    "XF86AudioNext",
    hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/media-control.sh next"),
    { locked = true, description = "Next track" }
)

hl.bind(
    "XF86AudioPrev",
    hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/media-control.sh prev"),
    { locked = true, description = "Previous track" }
)

hl.bind(
    "XF86AudioStop",
    hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/media-control.sh stop"),
    { locked = true, description = "Stop media playback" }
)

-- Screenshot (grim + slurp - 4 distinct actions)
hl.bind(
    "PRINT",
    hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/screenshot.sh full"),
    { description = "1. Fullscreen screenshot (save file & clipboard)" }
)

hl.bind(
    "CTRL + PRINT",
    hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/screenshot.sh full-clip"),
    { description = "2. Fullscreen screenshot (clipboard only)" }
)

hl.bind(
    "SHIFT + PRINT",
    hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/screenshot.sh region"),
    { description = "3. Region screenshot (save file & clipboard)" }
)

hl.bind(
    "ALT + PRINT",
    hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/screenshot.sh region-clip"),
    { description = "4. Region screenshot (clipboard only)" }
)
