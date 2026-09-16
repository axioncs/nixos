{ pkgs, ... }:
{
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  services.displayManager.sddm.settings = {
    Theme = {
      CursorTheme = "Bibata-Modern-Ice";
      CursorSize = "20";
    };
  };

  programs.qylock = {
    enable = true;
    theme = "Lain";
  };

  environment.systemPackages = with pkgs; [
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
