{ config, ... }:

{
  imports = [
    ../../modules/nixos/audio.nix
    ../../modules/nixos/boot.nix
    ../../modules/nixos/filesystems.nix
    ../../modules/nixos/nix.nix
    ../../modules/nixos/networking.nix
    ../../modules/nixos/locale.nix
    ../../modules/nixos/users.nix
    ../../modules/nixos/packages.nix
    ../../modules/nixos/desktop.nix
    ../../modules/nixos/greeter.nix
    ../../modules/nixos/fonts.nix
    ../../modules/nixos/services.nix
    ../../modules/nixos/xdg.nix
    ../../modules/nixos/environment.nix
    ../../modules/nixos/gaming.nix
  ];

  networking.hostName = config.axioncs.hostname;
  system.stateVersion = config.axioncs.stateVersion;

  programs.luatools-moon.enable = true;
}
