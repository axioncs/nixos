{ pkgs, ... }:

{
  chaotic.mesa-git.enable = true;
  chaotic.mesa-git.fallbackSpecialisation = false;

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  programs.dconf.enable = true;

  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };
}
