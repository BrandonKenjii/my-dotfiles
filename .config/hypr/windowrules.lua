-- Window Rules
-- Docs: https://wiki.hypr.land/configuring/core/rules/window-rules/

-- Fullscreen windows should be fully opaque
hl.window_rule({ match = { fullscreen = true }, opacity = "1 override" })

-- Application workspace assignments
hl.window_rule({ match = { class = "^(code)$" },    workspace = "3 silent" })
hl.window_rule({ match = { class = "^(spotify)$" }, workspace = "4 silent" })
hl.window_rule({ match = { class = "^(steam)$" },   workspace = "5 silent" })
hl.window_rule({ match = { class = "^(steam)$" },   center = true })

-- Steam popups/dialogs - float on top of main window
-- Match non-empty Steam titles except the main "Steam" window
hl.window_rule({ match = { class = "^(steam)$", title = "^(?!Steam$).+$" }, float = true })
hl.window_rule({ match = { class = "^(steam)$", title = "^(?!Steam$).+$" }, center = true })

-- Steam no-focus on empty-title windows (tray popups)
hl.window_rule({ match = { class = "^(steam)$", title = "^()$" }, no_initial_focus = true })
hl.window_rule({ match = { class = "^(steam)$", title = "^()$" }, min_size = { 1, 1 } })

-- Steam games - fullscreen, no blur for performance
hl.window_rule({ match = { class = "^(steam_app_.*)$" }, fullscreen = true })
hl.window_rule({ match = { class = "^(steam_app_.*)$" }, center = true })
hl.window_rule({ match = { class = "^(steam_app_.*)$" }, float = true })
hl.window_rule({ match = { class = "^(steam_app_.*)$" }, monitor = "0" })
hl.window_rule({ match = { class = "^(steam_app_.*)$" }, immediate = true })
hl.window_rule({ match = { class = "^(steam_app_.*)$" }, no_blur = true })
hl.window_rule({ match = { class = "^(steam_app_.*)$" }, opacity = "1 override" })

-- Float utility windows
hl.window_rule({ match = { class = "^(pavucontrol)$" }, float = true })
hl.window_rule({ match = { class = "^(nm-connection-editor)$" }, float = true })
hl.window_rule({ match = { class = "^(blueman-manager)$" }, float = true })
hl.window_rule({ match = { class = "^(gnome-calculator)$" }, float = true })
hl.window_rule({ match = { class = "^(org.gnome.Calculator)$" }, float = true })
hl.window_rule({ match = { title = "^(Picture-in-Picture)$" }, float = true })
hl.window_rule({ match = { title = "^(Picture-in-Picture)$" }, pin = true })
hl.window_rule({ match = { title = "^(Open File)$" }, float = true })
hl.window_rule({ match = { title = "^(Save File)$" }, float = true })
hl.window_rule({ match = { title = "^(Confirm to replace files)$" }, float = true })
hl.window_rule({ match = { title = "^(File Operation Progress)$" }, float = true })
hl.window_rule({ match = { class = "^(xdg-desktop-portal-gtk)$" }, float = true })
hl.window_rule({ match = { class = "^(org.kde.polkit-kde-authentication-agent-1)$" }, float = true })
hl.window_rule({ match = { class = "^(polkit-gnome-authentication-agent-1)$" }, float = true })

-- Discord
hl.window_rule({ match = { class = "^(discord)$" }, opacity = "1 override" })

-- Minecraft - fully opaque, no blur
hl.window_rule({ match = { class = "^(Minecraft.*)$" }, opacity = "1 override" })
hl.window_rule({ match = { class = "^(Minecraft.*)$" }, no_blur = true })

-- Browser fixes
hl.window_rule({ match = { class = "^(zen)$" }, opacity = "1 override" })
hl.window_rule({ match = { class = "^(zen)$", title = "^(Library)$" }, float = true })
hl.window_rule({ match = { class = "^(firefox)$", title = "^(Library)$" }, float = true })
hl.window_rule({ match = { class = "^(zen)$" }, idle_inhibit = "fullscreen" })
hl.window_rule({ match = { class = "^(firefox)$" }, idle_inhibit = "fullscreen" })

-- Image viewer
hl.window_rule({ match = { class = "^(imv)$" }, float = true })
hl.window_rule({ match = { class = "^(imv)$" }, size = { 1200, 800 } })
hl.window_rule({ match = { class = "^(imv)$" }, center = true })

-- Suppress maximize requests
hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })

-- Fix XWayland dragging issues (matches empty class/title on xwayland floating windows)
hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_initial_focus = true,
})

-- Layer rules for blur
hl.layer_rule({ match = { namespace = "^waybar$" }, blur = true })
hl.layer_rule({ match = { namespace = "^waybar$" }, blur_popups = true })
hl.layer_rule({ match = { namespace = "^waybar$" }, ignore_alpha = 0.0 })

hl.layer_rule({ match = { namespace = "^rofi$" }, blur = true })
hl.layer_rule({ match = { namespace = "^rofi$" }, blur_popups = true })
hl.layer_rule({ match = { namespace = "^rofi$" }, ignore_alpha = 0.0 })

hl.layer_rule({ match = { namespace = "^notifications$" }, blur = true })
hl.layer_rule({ match = { namespace = "^notifications$" }, blur_popups = true })
hl.layer_rule({ match = { namespace = "^notifications$" }, ignore_alpha = 0.0 })
