{ config, pkgs, ... }:

{
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
  };

  networking.wireless.iwd = {
    enable = true;
    settings = {
      Settings = {
        AutoConnect = true;
      };
    };
  };
  hardware.bluetooth.enable = true;
}
