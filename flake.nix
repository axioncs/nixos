{
  description = "Axion's NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    llm-agents.url = "github:numtide/llm-agents.nix";
    nixcord.url = "github:4evy/nixcord";

    harbor = {
      url = "github:axioncs/harbor-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    surfshark = {
      url = "github:axioncs/surfshark-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    twintaillauncher = {
      url = "github:axioncs/twintaillauncher-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    snappy-switcher = {
      url = "github:OpalAayan/snappy-switcher";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    amethyst-mod-manager = {
      url = "github:ChrisDKN/Amethyst-Mod-Manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    qylock = {
      url = "github:axioncs/qylock";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wl-shimeji = {
      url = "git+https://github.com/CluelessCatBurger/wl_shimeji?submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    default-shader-pack = {
      url = "github:iwalton3/default-shader-pack";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      lanzaboote,
      chaotic,
      qylock,
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
          lanzaboote.nixosModules.lanzaboote
          qylock.nixosModules.default

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
