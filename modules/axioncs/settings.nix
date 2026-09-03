{ lib, ... }:

let
  desktops = import ../../lib/desktops.nix;
in
{
  options.axioncs = {
    username = lib.mkOption {
      type = lib.types.str;
      description = "Primary user account name.";
    };

    hostname = lib.mkOption {
      type = lib.types.str;
      description = "Networking hostname.";
    };

    stateVersion = lib.mkOption {
      type = lib.types.str;
      description = "NixOS / home-manager stateVersion";
    };

    system = lib.mkOption {
      type = lib.types.str;
      description = "Nixpkgs system string";
    };

    desktop = lib.mkOption {
      type = lib.types.enum desktops.names;
      description = "Active compositor / desktop session";
    };
  };

  config.axioncs = {
    username = "axioncs";
    hostname = "nixos";
    stateVersion = "26.05";
    system = "x86_64-linux";

    # Active compositor
    desktop = "hyprland";
  };
}
