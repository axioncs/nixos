{
  description = "Axion's NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";

    noctalia.url = "github:noctalia-dev/noctalia/cachix";

    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      chaotic,
      ...
    }@inputs:

    let
      axioncs =
        (nixpkgs.lib.evalModules {
          modules = [ ./modules/axioncs/settings.nix ];
        }).config.axioncs;

      inherit (axioncs) desktop;
    in
    {
      formatter = nixpkgs.legacyPackages.${axioncs.system}.alejandra;

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit (axioncs) system;

        specialArgs = {
          inherit self inputs;
          inherit desktop;
        };

        modules = [
          ./modules/axioncs
          ./hosts/nixos/configuration.nix

          (./desktops + "/${desktop}/nixos.nix")

          home-manager.nixosModules.home-manager
          chaotic.nixosModules.default

          (
            { ... }:
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                overwriteBackup = true;
                extraSpecialArgs = {
                  inherit self inputs;
                  inherit desktop;
                };

                users.${axioncs.username} = import ./home/default.nix;
              };
            }
          )
        ];
      };
    };
}
