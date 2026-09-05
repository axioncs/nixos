{ pkgs, ... }:
{
  home.packages = [ (pkgs.callPackage ./llauncher-pkg.nix { }) ];
}
