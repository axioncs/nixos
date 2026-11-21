{ pkgs, ... }:

let
  protonCachy = pkgs.proton-cachyos-bin_x86_64_v3;
  protonGE = pkgs.proton-ge-bin_edge;
in
{
  home.file.".local/share/Steam/compatibilitytools.d/proton-cachyos-v3".source =
    protonCachy.steamcompattool or protonCachy;

  home.file.".local/share/Steam/compatibilitytools.d/proton-ge".source =
    protonGE.steamcompattool or protonGE;
}
