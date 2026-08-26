hl.config({
    xwayland = {
        force_zero_scaling = true,
    },

    general = {
        gaps_in = 3,
        gaps_out = 2,
        border_size = 2,
        layout = "dwindle",
        resize_on_border = true,
        allow_tearing = false,
    },

    decoration = {
        rounding = 8,

        shadow = {
            enabled = false,
        },

        blur = {
            enabled = false,
        },
    },

    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        force_default_wallpaper = 0,
    },

    dwindle = {
        preserve_split = true,
    },
})
