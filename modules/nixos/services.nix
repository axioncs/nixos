{ pkgs, ... }:

{
  programs.uwsm.enable = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
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
  HandleLidSwitchExternalPower = "suspend";
  HandlePowerKey = "poweroff";
  HandlePowerKeyLongPress = "poweroff";
};

  services.accounts-daemon.enable = true;
  services.power-profiles-daemon.enable = true;
  services.printing.enable = false;
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  services.upower.enable = true;
}
