{ inputs, pkgs, ... }:

{
  nixpkgs.overlays = [
    (_final: prev: {
      nur = import inputs.nur {
        nurpkgs = prev;
        pkgs = prev;
      };
    })
  ];

  systemd.services.nix-daemon.path = [ pkgs.git ];

  nix.settings = {
      extra-substituters = [
        "https://noctalia.cachix.org"
        "https://cache.numtide.com"
      ];
      extra-trusted-public-keys = [
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
        "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
      ];
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 5d";
  };

  nix.extraOptions = ''
    !include /etc/nix-secrets/github-token.conf
   '';

  nixpkgs.config.allowUnfree = true;

  programs.nix-ld.enable = true;

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };
}
