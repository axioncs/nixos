{ pkgs, ... }:

let
  proton = pkgs.proton-cachyos_x86_64_v3;
in
{
  home.file.".local/share/Steam/compatibilitytools.d/proton-cachyos-v3".source =
    proton.steamcompattool or proton;
}
