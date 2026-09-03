{
  pkgs,
  config,
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

  home.username = config.axioncs.username;
  home.homeDirectory = "/home/${config.axioncs.username}";
  home.stateVersion = config.axioncs.stateVersion;

  home.packages = import ./packages.nix {
    inherit pkgs inputs;
    noctaliaPackage = config.axioncs.noctaliaPackage;
  };

  home.sessionVariables = {
    EDITOR = "hx";
    TERMINAL = "kitty";
  };

  programs.home-manager.enable = true;
}
