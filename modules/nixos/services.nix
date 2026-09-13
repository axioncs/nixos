{ pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
  };
  security.polkit.enablePkexecWrapper = true;

  hardware.enableRedistributableFirmware = true;
  hardware.bluetooth.enable = true;

  services.dbus = {
    enable = true;
    packages = with pkgs; [ bluez ];
  };

  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-rules-cachyos;
    settings = {
      x3d_mode = "off";
    };
  };

  services.logind.settings.Login = {
  HandleLidSwitch = "suspend";
  HandleLidSwitchDocked = "ignore";
  HandleLidSwitchExternalPower = "ignore";
  HandlePowerKey = "suspend";
  HandlePowerKeyLongPress = "poweroff";
};

  services.accounts-daemon.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;
  programs.seahorse.enable = true;
  services.flatpak.enable = true;
  services.power-profiles-daemon.enable = true;
  services.printing.enable = false;
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  services.upower.enable = true;
  services.udev.extraRules = ''
      SUBSYSTEM=="net", KERNEL=="wlan*", ACTION=="add", RUN+="${pkgs.iw}/bin/iw reg set US"

      # -- CachyOS-Settings: I/O scheduler assignment --
      ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="kyber"

      # -- CachyOS-Settings: audio power-save toggle (AC vs battery) --
      # Mitigates snd-hda-intel crackling: disable power-save on AC, re-enable on battery.
      SUBSYSTEM=="power_supply", ATTR{online}=="0", RUN+="${pkgs.bash}/bin/bash -c 'echo 1 > /sys/module/snd_hda_intel/parameters/power_save'"
      SUBSYSTEM=="power_supply", ATTR{online}=="1", RUN+="${pkgs.bash}/bin/bash -c 'echo 0 > /sys/module/snd_hda_intel/parameters/power_save'"
    '';
}
