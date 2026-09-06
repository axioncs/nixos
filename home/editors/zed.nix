{ pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;

    userSettings = {
      agent = {
        default_model = {
          effort = "minimal";
          enable_thinking = true;
          model = "gemini-3.1-flash-lite";
          provider = "google";
        };
        favorite_models = [ ];
        model_parameters = [ ];
      };

      auto_install_extensions = {
        discord-presence = true;
      };

      autosave = "on_focus_change";
      buffer_font_size = 14.0;
      cli_default_open_behavior = "existing_window";

      icon_theme = {
        dark = "Bearded Icon Theme";
        light = "Zed (Default)";
        mode = "system";
      };

      lsp = {
        discord_presence = {
          initialization_options = {
            application_id = "1263505205522337886";
            base_icons_url = "https://raw.githubusercontent.com/xhyrom/zed-discord-presence/main/assets/icons/";
            details = "In {workspace}";
            git_integration = true;
            idle = {
              action = "change_activity";
              details = "In Zed";
              large_image = "{base_icons_url}/zed.png";
              large_text = "Zed";
              small_image = "{base_icons_url}/idle.png";
              small_text = "Idle";
              state = "Idling";
              timeout = 3000;
            };
            large_image = "{base_icons_url}/{language:lo}.png";
            large_text = "{language:u}";
            small_image = "{base_icons_url}/zed.png";
            small_text = "Zed";
            state = "Working on {filename}";
          };
        };
      };

      session.trust_all_worktrees = true;

      theme = {
        dark = "Noctalia Dark Transparent";
        light = "One Light";
        mode = "dark";
      };

      ui_font_size = 16;
      window_decorations = "client";
    };
  };
}
