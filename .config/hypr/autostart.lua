-- Autostart

hl.on("hyprland.start", function()
    -- Core system services
    hl.exec_cmd("hypridle")
    hl.exec_cmd("~/.config/hypr/scripts/screen-rotate.sh")
    hl.exec_cmd("env GDK_SCALE=1 waybar")
    hl.exec_cmd("sleep 2 && cd ~/.config/ags && ags run app.tsx")
    hl.exec_cmd("dunst")
    hl.exec_cmd("~/.config/hypr/scripts/swww-init.sh")
    hl.exec_cmd("nm-applet --indicator")
    hl.exec_cmd("blueman-applet")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
    hl.exec_cmd("easyeffects --gapplication-service")
    hl.exec_cmd("~/.config/dunst/scripts/spotify-dbus-monitor.sh")

    -- Clipboard manager
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")

    -- DBus/systemd environment
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

    -- User applications
    hl.exec_cmd("sleep 3 && kitty")
    hl.exec_cmd("sleep 3 && hyprctl dispatch swapwindow l")
    hl.exec_cmd("pactl set-default-sink alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Speaker__sink")
end)
