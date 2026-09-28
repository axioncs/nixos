{ pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  boot.kernelParams = [
    "amd_pstate=active"
    "clearcpuid=514"
    "quiet"
    "splash"
    "loglevel=3"
    "udev.log_priority=3"
    "rd.udev.log_level=3"
    "rd.systemd.show_status=false"
    "amdgpu.dcdebugmask=0x10"
  ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.kernelModules = [ "cfg80211" "ntsync" ];

  boot.initrd.systemd.enable = true;
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.initrd.verbose = false;
  boot.consoleLogLevel = 0;

  boot.plymouth.enable = true;
  boot.tmp.cleanOnBoot = true;
}
