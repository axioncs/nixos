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
        "https://forkprince.cachix.org"
        "https://ev357.cachix.org"
      ];
      extra-trusted-public-keys = [
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
        "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
        "forkprince.cachix.org-1:9cN+fX492ZKlfd228xpYAC3T9gNKwS1sZvCqH8iAy1M="
        "ev357.cachix.org-1:bI65rULXWJ8IMM+tosc/Z+9W53nL6uj4+5FLXX6BN3Q="
      ];
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      netrc-file = "/etc/nix-secrets/netrc";
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
  nixpkgs.config.permittedInsecurePackages = [
    "electron-41.10.6"
  ];

  programs.nix-ld.enable = true;

  zramSwap = {
    enable = true;
    memoryPercent = 100;
    priority = 100;
  };
}
