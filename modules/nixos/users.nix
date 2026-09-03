{ config, pkgs, ... }:

{
  users.groups.i2c = { };

  users.users.${config.axioncs.username} = {
    isNormalUser = true;
    description = config.axioncs.username;
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "input"
      "plugdev"
      "i2c"
      "bluetooth"
    ];
  };

  programs.fish.enable = true;
}
