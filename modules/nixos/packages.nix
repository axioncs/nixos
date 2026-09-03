{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    curl
    jq
    rsync
    unzip
    unrar
    pavucontrol
    wlr-randr
    wl-clipboard
    cliphist
    dex
    resvg
    xdg-user-dirs
  ];
}
