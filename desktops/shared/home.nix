{ osConfig, lib, ... }:

let
  noctalia = lib.getExe osConfig.axioncs.noctaliaPackage;
in
{
  home.sessionVariables = {
    ELECTRON_OZONE_PLATFORM_HINT = "auto";

    XCURSOR_SIZE = "20";
    XCURSOR_THEME = "Bibata-Modern-Ice";

    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_QPA_PLATFORMTHEME = "gtk3";
  };

  # Autostart Noctalia panel across supported Wayland compositors
  xdg.configFile."autostart/noctalia.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Noctalia
    Exec=${noctalia}
    X-GNOME-Autostart-enabled=true
    OnlyShowIn=Hyprland;Umbriel;MangoWC;sway;labwc;
  '';
}
