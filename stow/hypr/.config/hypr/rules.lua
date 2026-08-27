-- Window rules for Waybar TUI applications

-- Float impala (network TUI) below network icon
hl.window_rule({
    name  = "float-impala",
    match = { class = "omarchy-tui-net" },
    float = true,
    size  = "650 420",
    move  = "monitor_w-670 45",
})

-- Float bluetui (bluetooth TUI) below bluetooth icon
hl.window_rule({
    name  = "float-bluetui",
    match = { class = "omarchy-tui-bt" },
    float = true,
    size  = "650 420",
    move  = "monitor_w-730 45",
})

-- Float walt (wallpaper manager)
hl.window_rule({
    name   = "walt",
    match  = { class = "^walt$" },
    float  = true,
    size   = "900 600",
    center = true,
})

-- Float Proton VPN terminal
hl.window_rule({
    name   = "float-protonvpn",
    match  = { title = "^Proton VPN.*" },
    float  = true,
    size   = "650 420",
    center = true,
})

-- Workspace Assignments
-- Browser on Workspace 1
hl.window_rule({
    name      = "browser-workspace-1",
    match     = { class = "^(brave-origin|brave-browser|Brave-browser|firefox|google-chrome|chromium)$" },
    workspace = "1",
})

-- Terminal on Workspace 2
hl.window_rule({
    name      = "terminal-workspace-2",
    match     = { class = "^(com\\.mitchellh\\.ghostty|ghostty|kitty)$" },
    workspace = "2",
})

-- Slack on Workspace 10
hl.window_rule({
    name      = "slack-workspace-10",
    match     = { class = "^([Ss]lack)$" },
    workspace = "10",
})

