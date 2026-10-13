{ config, ... }:

{
  systemd.user.services.hermes-gateway = {
    Unit = {
      Description = "Hermes Agent Gateway";
      After = [ "network-online.target" ];
      Wants = [ "network-online.target" ];
      StartLimitIntervalSec = 300;
      StartLimitBurst = 5;
    };

    Service = {
      Type = "simple";
      ExecStart = "/run/current-system/sw/bin/hermes gateway run";
      ExecReload = "/run/current-system/sw/bin/kill -USR1 $MAINPID";
      WorkingDirectory = "%h/.hermes";
      Environment = [
        "HERMES_HOME=%h/.hermes"
        "HERMES_SUPERVISED_CHILD=1"
        "PATH=%h/.hermes/bin:%h/.local/bin:/etc/profiles/per-user/${config.home.username}/bin:/run/wrappers/bin:/run/current-system/sw/bin"
      ];
      Restart = "always";
      RestartSec = 5;
      RestartForceExitStatus = 75;
      SuccessExitStatus = 75;
      RestartPreventExitStatus = 78;
      KillMode = "mixed";
      TimeoutStopSec = 70;
    };

    Install.WantedBy = [ "default.target" ];
  };
}
