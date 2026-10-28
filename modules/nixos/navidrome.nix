{ config, lib, ... }:

{
  services.navidrome = {
    enable = true;
    user = config.axioncs.username;
    group = "users";
    environmentFile = config.age.secrets.navidrome-env.path;
    settings = {
      MusicFolder = "/home/${config.axioncs.username}/Music";
      Address = "127.0.0.1";
      Port = 4533;
    };
  };

  systemd.services.navidrome.serviceConfig.ProtectHome = lib.mkForce "read-only";
}
