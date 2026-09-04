{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    extraConfig = ''
      include themes/noctalia.conf
    '';

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 11;
    };

    settings = {
      cursor_shape = "beam";
      cursor_blink_interval = -1;
      cursor_trail = 100;
      remember_window_size = false;
      hide_window_decorations = true;
      background_opacity = 0.6;
      scrollback_lines = 2000;
      enable_audio_bell = false;
      copy_on_select = "clipboard";
      window_padding_width = "12 20 12 20";
      mouse_hide_wait = 3.0;
      allow_remote_control = true;
      confirm_os_window_close = 0;
      notify_on_cmd_finish = "unfocused";
    };

    keybindings = {
      "ctrl+c" = "copy_or_interrupt";
      "ctrl+v" = "paste_from_clipboard";
      "page_up" = "scroll_page_up";
      "page_down" = "scroll_page_down";
      "ctrl+plus" = "change_font_size all +1";
      "ctrl+equal" = "change_font_size all +1";
      "ctrl+kp_add" = "change_font_size all +1";
      "ctrl+minus" = "change_font_size all -1";
      "ctrl+underscore" = "change_font_size all -1";
      "ctrl+kp_subtract" = "change_font_size all -1";
    };
  };
}
