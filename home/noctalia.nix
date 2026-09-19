{ inputs, ... }:
{
  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia = {
    enable = true;

    settings = {
      bar.default = {
        background_opacity = 0.5;
        center = [ "workspaces" ];
        end = [ "media" "tray" "volume" "brightness" "battery" "session" ];
        font_scale = 0.92;
        margin_ends = 0;
        padding = 28;
        radius_bottom_left = 20;
        radius_bottom_right = 20;
        radius_top_left = 0;
        radius_top_right = 0;
        start = [ "launcher" "clock" "network_rx" "active_window" ];
        thickness = 38;
        widget_spacing = 14;
      };

      dock = {
        auto_hide = true;
        enabled = true;
        reserve_space = false;
      };

      lockscreen_widgets = {
        enabled = true;
        schema_version = 2;
        widget_order = [
          "lockscreen-login-box@eDP-1"
          "lockscreen-widget-0000000000000002"
          "lockscreen-widget-0000000000000004"
          "lockscreen-widget-0000000000000005"
          "lockscreen-widget-0000000000000006"
        ];

        grid = {
          cell_size = 16;
          major_interval = 4;
          visible = true;
        };

        widget = {
          "lockscreen-login-box@eDP-1" = {
            box_height = 70.0;
            box_width = 400.0;
            cx = 960.0;
            cy = 1051.0;
            output = "eDP-1";
            placement_height = 1200.0;
            placement_width = 1920.0;
            rotation = 0.0;
            type = "login_box";

            settings = {
              background_color = "#FCFCFC";
              background_opacity = 0.0;
              background_radius = 32.0;
              center_password_text = true;
              input_opacity = 0.0;
              input_radius = 32.0;
              layout = "compact";
              show_caps_lock = true;
              show_keyboard_layout = false;
              show_login_button = false;
              show_media = true;
              show_session_buttons = true;
              show_unlock_hint = false;
              show_weather = false;
            };
          };

          "lockscreen-widget-0000000000000002" = {
            box_height = 0.0;
            box_width = 0.0;
            cx = 109.26171875;
            cy = 38.859375;
            output = "eDP-1";
            placement_height = 1200.0;
            placement_width = 1920.0;
            rotation = 0.0;
            type = "label";

            settings = {
              background = false;
              color = "on_surface_variant";
              font_family = "JetBrainsMono Nerd Font";
              opacity = 0.5;
              title = "axioncs@nixos";
            };
          };

          "lockscreen-widget-0000000000000004" = {
            box_height = 160.0;
            box_width = 400.0;
            cx = 296.0;
            cy = 680.0;
            output = "eDP-1";
            placement_height = 1200.0;
            placement_width = 1920.0;
            rotation = 0.0;
            type = "media_player";

            settings = {
              background_color = "surface_variant";
              font_family = "Adwaita Sans";
              hide_when_no_media = true;
            };
          };

          "lockscreen-widget-0000000000000005" = {
            box_height = 124.44140625;
            box_width = 270.38671875;
            cx = 280.806640625;
            cy = 422.220703125;
            output = "eDP-1";
            placement_height = 1200.0;
            placement_width = 1920.0;
            rotation = -0.0;
            type = "clock";

            settings = {
              background = false;
              center_text = true;
              font_family = "";
              format = "{:%H:%M}";
              shadow = true;
              timezone = "";
            };
          };

          "lockscreen-widget-0000000000000006" = {
            box_height = 43.106082916259766;
            box_width = 256.51071166992188;
            cx = 280.0;
            cy = 504.0;
            output = "eDP-1";
            placement_height = 1200.0;
            placement_width = 1920.0;
            rotation = -0.0;
            type = "clock";

            settings = {
              background = false;
              center_text = true;
              format = "{:%a}, {:%b %d}";
              shadow = true;
            };
          };
        };
      };

      plugins.enabled = [ "noctalia/wallhaven" ];

      shell = {
        button_borders = false;
        card_borders = false;
        corner_radius_scale = 1.3;
        font_family = "Adwaita Sans";
        input_borders = false;
        polkit_agent = true;
        popup_borders = false;
        settings_window_translucent = true;
        telemetry_enabled = true;

        greeter_sync.auto_sync = false;

        panel = {
          borders = false;
          open_near_click_control_center = true;
          transparency_mode = "glass";
        };
      };

      theme = {
        community_palette = "Oxocarbon";
        mode = "dark";
        pure_black_dark = true;
        source = "wallpaper";
        wallpaper_scheme = "m3-fruit-salad";

        templates = {
          enable_builtin_templates = true;
          builtin_ids = [
            "btop"
            "cava"
            "gtk3"
            "gtk4"
            "helix"
            "hyprland"
            "kitty"
            "starship"
          ];
          enable_community_templates = true;
          community_ids = [
            "tauon"
            "zen-browser"
            "zed"
            "fastfetch"
            "snappy-switcher"
            "bat"
            "fzf"
            "yazi"
            "zathura"
          ];
        };
      };

      widget = {
        clock.format = "{:%H:%M} {:%a}, {:%b %d}";

        media = {
          hide_when_no_media = true;
          max_length = 300;
        };

        network_rx = {
          highlight_color = "on_surface";
          visualization = "none";
        };

        sysmon = {
          stat = "net_rx";
          visualization = "none";
        };

        tray = {
          drawer = true;
          match_adjacent_spacing = true;
          scale = 0.9;
        };

        volume.actions = {
          scroll_down = "volume-down 2";
          scroll_up = "volume-up 2";
        };

        workspaces = {
          active_pill_size = 2.0;
          pill_scale = 0.8;
          show_labels = false;
          urgent_color = "secondary";
        };
      };
    };
  };
}
