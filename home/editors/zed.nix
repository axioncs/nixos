{ pkgs, ... }:

{
  programs.zed-editor = {
    enable = true;

    extensions = [ "discord-presence" ];

    mutableUserSettings = true;

    userSettings = {
      autosave = "on_focus_change";

      agent = {
        default_model = {
          provider = "google";
          model = "gemini-3.1-flash-lite";
          enable_thinking = true;
          effort = "minimal";
        };
        favorite_models = [ ];
        model_parameters = [ ];
      };

      window_decorations = "client";

      session = {
        trust_all_worktrees = true;
      };

      icon_theme = {
        mode = "system";
        light = "Zed (Default)";
        dark = "Zed (Default)";
      };

      cli_default_open_behavior = "existing_window";
      ui_font_size = 16;
      buffer_font_size = 15;

      theme = {
        mode = "dark";
        light = "One Light";
        dark = "Noctalia Dark Transparent";
      };

      lsp = {
        discord_presence = {
          initialization_options = {
            application_id = "1263505205522337886";
            base_icons_url = "https://raw.githubusercontent.com/xhyrom/zed-discord-presence/main/assets/icons/";
            state = "Working on {filename}";
            details = "In {workspace}";
            large_image = "{base_icons_url}/{language:lo}.png";
            large_text = "{language:u}";
            small_image = "{base_icons_url}/zed.png";
            small_text = "Zed";
            idle = {
              timeout = 3000;
              action = "change_activity";
              state = "Idling";
              details = "In Zed";
              large_image = "{base_icons_url}/zed.png";
              large_text = "Zed";
              small_image = "{base_icons_url}/idle.png";
              small_text = "Idle";
            };
            git_integration = true;
          };
        };
      };
    };
  };
}
