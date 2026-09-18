-- Look and Feel

hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 7,
        border_size = 2,
        col = {
            active_border   = { colors = { "rgba(8ec07cee)", "rgba(8ec07cee)" }, angle = 45 },
            inactive_border = "rgba(2a332daa)",
        },
        resize_on_border = true,
        extend_border_grab_area = 15,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding = 5,
        rounding_power = 2,
        active_opacity = 0.85,
        inactive_opacity = 0.8,

        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = 0xee1a1a1a, -- rgba(1a1a1aee)
        },

        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            new_optimizations = true,
            xray = false,
            ignore_opacity = false,
            vibrancy = 0.1696,
            popups = true,
        },
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        mouse_move_enables_dpms = true,
        key_press_enables_dpms = true,
        animate_manual_resizes = true,
        animate_mouse_windowdragging = true,
        enable_swallow = true,
        swallow_regex = "^(kitty)$",
        focus_on_activate = true,
        vrr = 1,
    },

    xwayland = {
        force_zero_scaling = true,
    },

    cursor = {
        no_hardware_cursors = false,
        enable_hyprcursor = true,
        hide_on_key_press = true,
    },
})

hl.config({
    dwindle = {
        preserve_split = true,
    },
})

hl.config({
    master = {
        new_status = "master",
    },
})
