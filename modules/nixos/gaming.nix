{ pkgs, ... }:

{
  hardware.steam-hardware.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    extraCompatPackages = with pkgs; [ proton-cachyos ];
  };

  environment.systemPackages = with pkgs; [
    libusb1
    usbutils
    gamescope
  ];

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="0bb4", ATTR{idProduct}=="2c87", MODE="0666", GROUP="plugdev"
    SUBSYSTEM=="usb", ATTR{idVendor}=="28de", ATTR{idProduct}=="2101", MODE="0666", GROUP="plugdev"
    SUBSYSTEM=="usb", ATTR{idVendor}=="28de", ATTR{idProduct}=="2000", MODE="0666", GROUP="plugdev"
  '';

  hardware.xpadneo.enable = true;

  services.scx = {
    enable = true;
    scheduler = "scx_bpfland";
  };
}
