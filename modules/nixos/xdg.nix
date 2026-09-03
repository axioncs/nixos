{
  pkgs,
  config,
  lib,
  ...
}:

let
  desktop = config.axioncs.desktop;
  isHyprland = desktop == "hyprland";

  gtkPortals = [
    pkgs.xdg-desktop-portal
    pkgs.xdg-desktop-portal-gtk
  ];

  hyprlandPortals = gtkPortals ++ [
    pkgs.xdg-desktop-portal-hyprland
  ];

  # Fallback portal for other wlroots-based compositors (like Mango/Umbriel)
  wlrPortals = gtkPortals ++ [
    pkgs.xdg-desktop-portal-wlr
  ];
in
{
  xdg.portal = {
    enable = true;

    config = {
      common =
        if isHyprland then
          {
            default = [ "hyprland" "gtk" ];
            "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
          }
        else
          {
            default = [ "wlr" "gtk" ];
          };
    };

    xdgOpenUsePortal = true;

    extraPortals =
      if isHyprland then
        hyprlandPortals
      else
        wlrPortals;
  };
}
