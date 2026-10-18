{ config, osConfig, ... }:

{
  imports = [ ./module.nix ];

  programs.faugus-launcher = {
    enable = true;
    runner = "proton-cachyos-v3";
    steamGridDbKeyFile = osConfig.age.secrets.steamgriddb.path;

    settings = {
      "default-prefix" = "${config.home.homeDirectory}/Faugus";
      gamemode = true;
      mangohud = false;
      "wayland-driver" = false;
      "splash-window-enabled" = true;
      "automatic-updates" = true;
      "interface-mode" = "List";
      "steamgriddb-enabled" = true;
      "show-donate" = false;
    };

    presets = [
      "PROTON_ENABLE_WAYLAND=1"
      "gamescope -W 1920 -H 1200 -r 120 -f --adaptive-sync --"
      "PROTON_FSR4_UPGRADE=1 PROTON_FSR4_RDNA3_UPGRADE=1 gamescope -W 1920 -H 1200 -r 120 -f --adaptive-sync --"
      "${config.home.homeDirectory}/.local/bin/linuwux gamescope -W 1920 -H 1200 -r 120 -f --adaptive-sync --"
    ];
  };
}
