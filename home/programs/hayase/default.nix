{ pkgs, ... }:
{
  home.packages = [ (pkgs.callPackage ./hayase-pkg.nix { }) ];
}
