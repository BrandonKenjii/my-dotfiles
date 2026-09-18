-- Keybindings

local S = require("settings")
local mainMod = S.mainMod

-- Application launchers
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(S.terminal))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(S.menu))
hl.bind(mainMod .. " + K", hl.dsp.exec_cmd(S.menu))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(S.fileManager))
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("code"))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("zen-browser"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("spotify-launcher"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("STEAM_FORCE_X11=1 GDK_SCALE=2 steam", { workspace = "5 silent" }))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("discord --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto", { workspace = "2 silent" }))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd("whatsapp"))

-- Window management
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
-- Waybar toggle
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle-waybar.sh"))
-- Print TUI
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("kitty --title Print --class print ~/.config/hypr/scripts/print.sh", {
    float = true,
    center = true,
    size = { "monitor_w * 0.62", "monitor_h * 0.74" },
}))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + H", hl.dsp.window.swap({ direction = "l" }))
hl.bind(mainMod .. " + L", hl.dsp.window.swap({ direction = "r" }))

-- Focus
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Workspaces
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + G", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + G", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Mouse window control
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Screenshots
hl.bind("Print", hl.dsp.exec_cmd("grim -g \"$(slurp)\" ~/Pictures/$(date +%Y-%m-%d_%H-%m-%s).png"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))

-- Wallpaper
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("~/.config/hypr/scripts/swww-random.sh"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("~/.config/hypr/scripts/swww-select.sh"))

-- Lock screen
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("hyprlock"))
hl.bind("switch:Lid Switch", hl.dsp.exec_cmd("hyprlock"), { locked = true })

-- Keybinds cheatsheet
hl.bind(mainMod .. " + slash", hl.dsp.exec_cmd("~/.config/rofi/scripts/keybinds.sh"))

-- Clipboard History
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy"))

-- System
hl.bind("SUPER + ALT + S", hl.dsp.exec_cmd("systemctl poweroff"))
hl.bind("SUPER + ALT + R", hl.dsp.exec_cmd("systemctl reboot"))

-- Media keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("~/.config/hypr/scripts/volume.sh up"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("~/.config/hypr/scripts/volume.sh down"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("~/.config/hypr/scripts/volume.sh mute"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("~/.config/hypr/scripts/volume.sh mic-mute"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("~/.config/hypr/scripts/brightness.sh up"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("~/.config/hypr/scripts/brightness.sh down"), { locked = true, repeating = true })

-- Playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Theme switcher
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("~/.config/theme/switch.sh"))

-- Close AGS popup
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd("~/.config/hypr/scripts/ags-escape.sh"))
