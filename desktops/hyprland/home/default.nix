{ lib, ... }:

let
  mods = [
    "variables" "display" "input" "layout" "animations" "blur"
    "misc" "autostart" "rules" "keybinds" "gestures"
  ];
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    configType = "lua";

    extraLuaFiles = lib.listToAttrs (map (m: {
      name = "cfg.${m}";
      value = { content = ../cfg + "/${m}.lua"; autoLoad = false; };
    }) mods);

    extraConfig = lib.concatMapStrings (m: ''require("cfg/${m}")'' + "\n") mods;
  };

  home.file.".config/hypr/bin/hypr-lens" = {
    source = ../cfg/bin/hypr-lens;
    executable = true;
  };
  home.file.".config/hypr/bin/hypr-ocr" = {
    source = ../cfg/bin/hypr-ocr;
    executable = true;
  };
}
