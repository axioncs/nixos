{ pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  boot.kernelParams = [ "amd_pstate=active" "clearcpuid=514" "quiet" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.kernelModules = [ "cfg80211" "ntsync" ];
  boot.plymouth.enable = true;
}
