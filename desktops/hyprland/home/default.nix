{ config, pkgs, inputs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    configType = "lua";

    extraLuaFiles = {
      "cfg.variables"  = { content = ../cfg/variables.lua;  autoLoad = false; };
      "cfg.display"    = { content = ../cfg/display.lua;    autoLoad = false; };
      "cfg.input"      = { content = ../cfg/input.lua;      autoLoad = false; };
      "cfg.layout"     = { content = ../cfg/layout.lua;     autoLoad = false; };
      "cfg.animations" = { content = ../cfg/animations.lua; autoLoad = false; };
      "cfg.blur"       = { content = ../cfg/blur.lua;       autoLoad = false; };
      "cfg.misc"       = { content = ../cfg/misc.lua;       autoLoad = false; };
      "cfg.autostart"  = { content = ../cfg/autostart.lua;  autoLoad = false; };
      "cfg.rules"      = { content = ../cfg/rules.lua;      autoLoad = false; };
      "cfg.keybinds"   = { content = ../cfg/keybinds.lua;   autoLoad = false; };
      "cfg.gestures"   = { content = ../cfg/gestures.lua;   autoLoad = false; };
    };

    extraConfig = ''
      require("cfg/variables")
      require("cfg/display")
      require("cfg/input")
      require("cfg/layout")
      require("cfg/animations")
      require("cfg/blur")
      require("cfg/misc")
      require("cfg/autostart")
      require("cfg/rules")
      require("cfg/keybinds")
      require("cfg/gestures")
    '';
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
