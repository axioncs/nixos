{ config, osConfig, pkgs, ... }:

let
  base = pkgs.writeText "aria2-base.conf" ''
    dir=${config.home.homeDirectory}/Downloads/aria2
    continue=true
    max-connection-per-server=16
    split=16
    min-split-size=5M
    file-allocation=falloc
    summary-interval=5
    max-overall-download-limit=0
    enable-rpc=true
    rpc-listen-all=false
    rpc-listen-port=6800
    rpc-allow-origin-all=true
  '';

  mkConf = pkgs.writeShellScript "aria2-mkconf" ''
    umask 077
    {
      cat ${base}
      printf 'rpc-secret=%s\n' "$(cat ${osConfig.age.secrets.aria2-rpc.path})"
    } > "$XDG_RUNTIME_DIR/aria2.conf"
  '';
in
{
  systemd.user.services.aria2 = {
    Unit = {
      Description = "aria2 RPC daemon";
      After = [ "network.target" ];
    };
    Service = {
      ExecStartPre = "${mkConf}";
      ExecStart = "${pkgs.aria2}/bin/aria2c --conf-path=%t/aria2.conf";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "default.target" ];
  };
}
