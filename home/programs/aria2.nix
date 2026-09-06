{ config, pkgs, ... }:

{
  xdg.configFile."aria2/aria2.conf".text = ''
    dir=${config.home.homeDirectory}/Downloads/aria2
    continue=true
    max-connection-per-server=16
    split=16
    min-split-size=5M
    file-allocation=falloc
    summary-interval=5
    max-overall-download-limit=0
    enable-rpc=true
    rpc-listen-all=true
    rpc-listen-port=6800
    rpc-allow-origin-all=true
    rpc-secret=yuiopi
  '';

  systemd.user.services.aria2 = {
    Unit = {
      Description = "aria2 RPC daemon";
      After = [ "network.target" ];
    };
    Service = {
      ExecStart = "${pkgs.aria2}/bin/aria2c --conf-path=${config.xdg.configHome}/aria2/aria2.conf";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "default.target" ];
  };
}
