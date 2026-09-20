{ inputs, pkgs, ... }:

{
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
      netrc-file = "/etc/nix-secrets/netrc";
    };

    programs.nh = {
      enable = true;
      clean = {
        enable = true;
        dates = "daily";
        extraArgs = "--keep-since 3d --keep 3";
      };
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
