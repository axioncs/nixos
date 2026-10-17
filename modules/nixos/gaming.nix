{ pkgs, inputs, ... }:

let
  proton = pkgs.proton-cachyos_x86_64_v3;

  aula-s75pro = pkgs.writeShellScriptBin "aula-s75pro" ''
    export WINEPREFIX="$HOME/.local/share/aula-prefix"
    export GAMEID=0
    export PROTONPATH="${proton}"
    exec ${pkgs.umu-launcher}/bin/umu-run \
      "$WINEPREFIX/drive_c/Program Files (x86)/S75Pro/DeviceDriver.exe"
  '';
in
{
  hardware.steam-hardware.enable = true;
  programs.gamescope.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    extraCompatPackages = [ proton ];
  };

  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        renice = 0;
        ioprio = "off";
      };
      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = 0;
        amd_performance_level = "high";
      };
      custom = {
        start = "${pkgs.power-profiles-daemon}/bin/powerprofilesctl set performance";
        end   = "${pkgs.power-profiles-daemon}/bin/powerprofilesctl set balanced";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    libusb1
    usbutils
    mangohud
    umu-launcher
    protontricks
    winetricks
    vulkan-tools
    aula-s75pro
  ];

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="0bb4", ATTR{idProduct}=="2c87", MODE="0666", GROUP="plugdev"
    SUBSYSTEM=="usb", ATTR{idVendor}=="28de", ATTR{idProduct}=="2101", MODE="0666", GROUP="plugdev"
    SUBSYSTEM=="usb", ATTR{idVendor}=="28de", ATTR{idProduct}=="2000", MODE="0666", GROUP="plugdev"
  '';

  services.udev.packages = [
    (pkgs.writeTextFile {
      name = "aula-udev-rules";
      destination = "/lib/udev/rules.d/70-aula.rules";
      text = ''
        ACTION!="remove", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="0c45", ATTRS{idProduct}=="800a", TAG+="uaccess"
        ACTION!="remove", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="05ac", ATTRS{idProduct}=="024f", TAG+="uaccess"
      '';
    })
  ];

  hardware.xpadneo.enable = true;
}
