{ ... }:
{
  programs.fastfetch = {
    enable = true;
  };
  xdg.configFile = {
    "fastfetch/config.jsonc".source = ./config.jsonc;
    "fastfetch/icons".source = ./icons;
  };
}
