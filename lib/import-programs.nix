{ lib, dir }:

let
  entries = builtins.readDir dir;
in
lib.flatten (
  lib.mapAttrsToList (
    name: type:
    if type == "regular" && lib.hasSuffix ".nix" name then
      [ (dir + "/${name}") ]
    else if type == "directory" && builtins.pathExists (dir + "/${name}/default.nix") then
      [ (dir + "/${name}/default.nix") ]
    else
      [ ]
  ) entries
)
