{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.programs.luatools-moon;

  luatoolsSrc = pkgs.fetchFromGitHub {
    owner = "swwayps";
    repo = "luatools-moon";
    rev = "3c5e8e4529ded3f9ce6fd1c3ce65ad3220fb9176";
    hash = "sha256-fYYhf4thsNShI/jdFVAn6dB0YKqWgg4O58gw2W1LnfE=";
  };
in
{
  options.programs.luatools-moon = {
    enable = mkEnableOption "luatools-moon Steam plugin stack";

    autoUpdate = mkOption {
      type = types.bool;
      default = true;
      description = "Refresh slsteam-moon + Lumen runtime weekly. Plugin self-updates separately.";
    };
  };

  config = {
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
    ] ++ lib.optionals cfg.enable [
      steam-run
      jq
      gnutar
      unzip
      libnotify
    ];

    services.udev.extraRules = ''
      SUBSYSTEM=="usb", ATTR{idVendor}=="0bb4", ATTR{idProduct}=="2c87", MODE="0666", GROUP="plugdev"
      SUBSYSTEM=="usb", ATTR{idVendor}=="28de", ATTR{idProduct}=="2101", MODE="0666", GROUP="plugdev"
      SUBSYSTEM=="usb", ATTR{idVendor}=="28de", ATTR{idProduct}=="2000", MODE="0666", GROUP="plugdev"
    '';

    hardware.xpadneo.enable = true;

    services.scx = {
      enable = true;
      scheduler = "scx_rusty";
    };

    systemd.user = mkIf cfg.enable {
      services.luatools-moon-install = {
        description = "Install luatools-moon Steam plugin stack";
        wantedBy = [ "default.target" ];
        unitConfig.ConditionPathExists = "!%h/.local/share/SLSsteam";
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
        };
        script = ''${pkgs.bash} ${luatoolsSrc}/install.sh --nolaunch'';
      };

      services.luatools-moon-update = mkIf cfg.autoUpdate {
        description = "Refresh luatools-moon slsteam-moon + Lumen runtime";
        serviceConfig.Type = "oneshot";
        script = ''${pkgs.bash} ${luatoolsSrc}/install.sh --nolaunch --noplugin'';
      };

      timers.luatools-moon-update = mkIf cfg.autoUpdate {
        description = "Weekly luatools-moon runtime refresh";
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnCalendar = "weekly";
          Persistent = true;
        };
      };
    };
  };
}
