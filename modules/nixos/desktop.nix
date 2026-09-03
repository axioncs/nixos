{ pkgs, ... }:

{
  hardware.graphics.enable = true;

  programs.dconf.enable = true;

  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };
}
