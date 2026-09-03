{
  pkgs,
  osConfig,
  lib,
  inputs,
  desktop,
  ...
}:

{
  imports = [
    ../desktops/shared/home.nix
    (../desktops + "/${desktop}/home")
    ./editors/zed.nix
    ./shell/fish.nix
  ]
  ++ import ../lib/import-programs.nix {
    inherit lib;
    dir = ./programs;
  };

  home.username = osConfig.axioncs.username;
  home.homeDirectory = "/home/${osConfig.axioncs.username}";
  home.stateVersion = osConfig.axioncs.stateVersion;

  home.packages = import ./packages.nix {
    inherit pkgs inputs;
    noctaliaPackage = osConfig.axioncs.noctaliaPackage;
  };

  home.sessionVariables = {
    EDITOR = "hx";
    TERMINAL = "kitty";
  };

  programs.home-manager.enable = true;
}
