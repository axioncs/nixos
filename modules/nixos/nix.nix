{ config, pkgs, ... }:

{
  systemd.services.nix-daemon.path = [ pkgs.git ];

  nix.settings = {
      extra-substituters = [
        "https://cache.numtide.com"
        "https://hyprland.cachix.org"
      ];
      extra-trusted-public-keys = [
        "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
      trusted-users = [ "root" "@wheel" ];
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      netrc-file = config.age.secrets.nix-netrc.path;
  };

    programs.nh = {
      enable = true;
      clean = {
        enable = true;
        dates = "daily";
        extraArgs = "--keep-since 3d";
      };
    };

    nix.extraOptions = ''
      !include ${config.age.secrets.nix-github-token.path}
    '';

  nixpkgs.config.allowUnfree = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    libX11
    libXi
    libxkbcommon
  ];
  zramSwap = {
    enable = true;
    memoryPercent = 100;
    priority = 100;
  };
}
