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
    '';
}
