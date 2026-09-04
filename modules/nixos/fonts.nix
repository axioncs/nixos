{ pkgs, ... }:

{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      adwaita-fonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      jetbrains-mono
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [ "Adwaita Sans" "Noto Sans Bengali" "Noto Sans" ];
        serif     = [ "Noto Serif" "Noto Serif Bengali" "Adwaita Serif" ];
        monospace = [ "JetBrains Mono" ];
      };
    };
  };

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
