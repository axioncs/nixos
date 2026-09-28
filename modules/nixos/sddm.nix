{ pkgs, lib, config, ... }:
let
  hyprlandSession = pkgs.runCommand "hyprland-session-only" {
    passthru.providedSessions = [ "hyprland" ];
  } ''
    mkdir -p $out/share/wayland-sessions
    cp ${config.programs.hyprland.package}/share/wayland-sessions/hyprland.desktop \
       $out/share/wayland-sessions/
  '';
in
{
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.wayland.compositor = "kwin";
  services.displayManager.sessionPackages = lib.mkForce [ hyprlandSession ];

  services.displayManager.sddm.settings.Theme = {
    CursorTheme = "Bibata-Modern-Ice";
    CursorSize = "20";
  };

  programs.qylock = {
    enable = true;
    theme = "Lain";
  };

  environment.systemPackages = with pkgs; [
    bibata-cursors
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
  ];

  environment.etc."sddm.conf.d/virtualkeyboard.conf".text = ''
    [General]
    InputMethod=
  '';
}
