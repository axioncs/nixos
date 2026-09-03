local V                   = {}

-- Apps
V.terminal                = "kitty"
V.browser                 = "zen-browser"
V.editor                  = "zeditor"
V.fileManager             = "kitty -e fish -ic y"
V.vpn                     = "surfshark"
V.aria                    = "~/.hermes/hermes-agent/venv/bin/hermes desktop"

-- Mod key
V.mod                     = "SUPER"
V.mod2                    = "SUPER + ALT"

-- Layout
V.default_layout          = "scrolling"
V.layout_cycle            = { "scrolling", "dwindle", "monocle", "master" }

-- Gaps
V.gaps_in                 = 5
V.gaps_out                = 10

-- Window styling
V.opacity                 = 0.85
V.opacity_focused         = 0.85
V.opacity_unfocused       = 0.80
V.rounding                = 15

V.border_size             = 0
V.active_border_color     = "rgba(7fc8ffee)"
V.inactive_border_color   = "rgba(50505088)"

-- Blur
V.blur_enabled            = true
V.blur_xray               = false
V.blur_special_ws         = false
V.blur_popups             = true
V.blur_input_methods      = true
V.blur_size               = 6
V.blur_passes             = 4

-- Shadow
V.shadow_enabled          = false
V.shadow_range            = 4
V.shadow_power            = 3
V.shadow_color            = 0xee1a1a1a

-- Cursor
V.cursor_theme            = "Bibata-Modern-Ice"
V.cursor_size             = 20
V.cursor_hide_on_type     = true
V.cursor_inactive_secs    = 1

-- Animations
V.anim_windows_speed      = 3.5
V.anim_workspace_speed    = 3.8
V.anim_layer_speed        = 3.0
V.anim_fade_speed         = 2.5

-- Special workspaces
V.scratchpad_discord_size = { 1600, 900 } -- fixed px (matches your window rule)

-- Misc
V.volume_step             = 2 -- percent per media key press
V.volume_max              = 100

return V
