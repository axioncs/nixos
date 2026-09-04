{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    adwaita-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.jetbrains-mono
  ];

  programs.dconf.profiles.user.databases = [
      {
        settings."org/gnome/desktop/interface" = {
          font-name = "Sans 11";
          document-font-name = "Sans 11";
          monospace-font-name = "Sans 11";
        };
      }
    ];
}
