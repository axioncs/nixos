local V = require("cfg/variables")

-- ── Environment variables ─────────────────────────────────────────────────────
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "gtk3")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", 1)
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("GDK_BACKEND", "wayland,x11")
hl.env("SDL_VIDEODRIVER", "wayland,x11,windows")
hl.env("_JAVA_AWT_WM_NONREPARENTING", "1")

-- Cursor theme (Xwayland + Hyprland native)
hl.env("XCURSOR_THEME", V.cursor_theme)
hl.env("XCURSOR_SIZE", tostring(V.cursor_size))
hl.env("HYPRCURSOR_THEME", V.cursor_theme)
hl.env("HYPRCURSOR_SIZE", tostring(V.cursor_size))
hl.env("GDK_SCALE", "1.5")

-- ── Cursor behaviour ─────────────────────────────────────────────────────────
hl.config({
    cursor = {
        hide_on_key_press = V.cursor_hide_on_type,
        inactive_timeout  = V.cursor_inactive_secs,
    },
})

-- ── Misc compositor settings ─────────────────────────────────────────────────
hl.config({
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
        focus_on_activate       = true,
        mouse_move_enables_dpms = true,
        key_press_enables_dpms  = true,
        enable_swallow = true,
        swallow_regex = "(kitty|Alacritty|foot|ghostty)",
        animate_manual_resizes = true,
        animate_mouse_windowdragging = true,
    },
})

hl.config({
  xwayland = {
    force_zero_scaling = true
  }
})
