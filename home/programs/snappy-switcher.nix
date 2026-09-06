{ config, ... }:

{
  xdg.configFile."snappy-switcher/config.ini".text = ''
    [general]
    mode = overview
    follow_monitor = true
    show_workspace_badge = true
    sticky_mode = false
    ignore_pinned = false
    ignore_special = false

    [theme]
    name = noctalia.ini
    border_width = 1
    card_border_width = 2
    corner_radius = 15

    [layout]
    card_width = 145
    card_height = 135
    card_gap = 10
    padding = 10
    max_cols = 5
    icon_size = 57
    icon_radius = 15
    error_width = 480
    error_height = 160
    error_font_size = 13

    [icons]
    theme = Papirus
    fallback = hicolor
    show_letter_fallback = true

    [font]
    family = JetBrainsMono Nerd Font
    weight = Normal
    title_size = 10
    icon_letter_size = 24
  '';
}
