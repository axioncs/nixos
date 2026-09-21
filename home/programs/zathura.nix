{ pkgs, config, ... }:

let
  comicConfigDir = "${config.xdg.configHome}/zathura-comic";
  comicDataDir = "${config.xdg.dataHome}/zathura-comic";

  noctaliaRc = "${config.xdg.configHome}/zathura/noctaliarc";

  theme = ''
    set font "JetBrainsMono Nerd Font 11"
    include ${noctaliaRc}

    set default-bg "#000000"
    set statusbar-bg "#000000"
    set inputbar-bg "#000000"
    set render-loading-bg "#000000"
    set recolor-lightcolor "#000000"
    set recolor-keephue true
  '';
in
{
  # Base zathura
  programs.zathura = {
    enable = true;
    extraConfig = theme;
    options = {
      selection-clipboard = "clipboard";
      scroll-step = 80;
      zoom-min = 10;
      zoom-max = 1000;
      pages-per-row = 1;
      adjust-open = "best-fit";
      recolor = true;
    };
    mappings = {
      "<C-=>" = "zoom in";
      "<C-->" = "zoom out";
      r = "reload";
      R = "rotate";
      i = "recolor";
    };
  };

  # Comic
  xdg.configFile."zathura-comic/zathurarc".text = ''
    ${theme}
    set selection-clipboard clipboard
    set scroll-step 80
    set zoom-min 10
    set zoom-max 1000
    set adjust-open best-fit
    set recolor false

    # Manga layout
    set pages-per-row 2
    set first-page-column 1:1
    set page-right-to-left true
    set scroll-page-aware true
    set advance-pages-per-row true
    set continuous-hist-save true

    map <C-=> zoom in
    map <C--> zoom out
    map r reload
    map R rotate
    map i recolor
    map d set "pages-per-row 1"
    map D set "pages-per-row 2"
  '';

  home.packages = [
    (pkgs.writeShellScriptBin "zathura-comic" ''
      mkdir -p ${comicDataDir}
      exec ${pkgs.zathura}/bin/zathura \
        --config-dir=${comicConfigDir} \
        --data-dir=${comicDataDir} "$@"
    '')
  ];

  xdg.desktopEntries.zathura-comic = {
    name = "Zathura (Comic)";
    exec = "zathura-comic %f";
    terminal = false;
    noDisplay = true;
    mimeType = [
      "application/vnd.comicbook+zip"
      "application/vnd.comicbook-rar"
      "application/x-cbz"
      "application/x-cbr"
    ];
  };

  xdg.mimeApps.defaultApplications = {
    "application/vnd.comicbook+zip" = [ "zathura-comic.desktop" ];
    "application/vnd.comicbook-rar" = [ "zathura-comic.desktop" ];
    "application/x-cbz" = [ "zathura-comic.desktop" ];
    "application/x-cbr" = [ "zathura-comic.desktop" ];
  };
}
