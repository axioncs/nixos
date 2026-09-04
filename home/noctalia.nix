{ inputs, ... }:
{
  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia = {
    enable = true;
    settings.theme.templates = {
      enable_builtin_templates = true;
      builtin_ids = [
        "cava"
        "hyprland"
        "helix"
        "btop"
        "gtk3"
        "gtk4"
        "kitty"
        "starship"
      ];
    };
  };
}
