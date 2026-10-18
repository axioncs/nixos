{ config, lib, pkgs, ... }:

let
  cfg = config.programs.faugus-launcher;
  inherit (lib) mkOption mkEnableOption mkIf types optionalString;

  toStr = v: if builtins.isBool v then (if v then "True" else "False") else toString v;
  settingsJson = pkgs.writeText "faugus-settings.json"
    (builtins.toJSON (lib.mapAttrs (_: toStr) cfg.settings));
  presetsJson = pkgs.writeText "faugus-presets.json" (builtins.toJSON cfg.presets);

  cfgDir = "${config.xdg.configHome}/faugus-launcher";
  dataDir = "${config.xdg.dataHome}/faugus-launcher";
  jq = "${pkgs.jq}/bin/jq";
in
{
  options.programs.faugus-launcher = {
    enable = mkEnableOption "Faugus Launcher";

    runner = mkOption {
      type = types.str;
      default = "proton-cachyos-v3";
      description = "Directory name of the default Proton under compatibilitytools.d.";
    };

    settings = mkOption {
      type = with types; attrsOf (oneOf [ bool int str ]);
      default = { };
      description = "Keys merged into config.json. Bools are written as \"True\"/\"False\".";
    };

    presets = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "Launch-option presets written to presets.json.";
    };

    steamGridDbKeyFile = mkOption {
      type = types.nullOr types.path;
      default = null;
      description = "Runtime path holding the SteamGridDB API key (e.g. an agenix secret).";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.faugus-launcher ];

    programs.faugus-launcher.settings."default-runner" = cfg.runner;

    home.activation.faugusLauncher = config.lib.dag.entryAfter [ "writeBoundary" ] ''
      mkdir -p ${cfgDir} ${dataDir}
      [ -s ${cfgDir}/config.json ] || echo '{}' > ${cfgDir}/config.json

      tmp=$(mktemp)
      ${jq} -s '.[0] * .[1]' ${cfgDir}/config.json ${settingsJson} > "$tmp"
      ${optionalString (cfg.steamGridDbKeyFile != null) ''
        if [ -r ${cfg.steamGridDbKeyFile} ]; then
          ${jq} --rawfile k ${cfg.steamGridDbKeyFile} \
            '.["steamgriddb-api-key"] = ($k | rtrimstr("\n"))' "$tmp" > "$tmp.2" && mv "$tmp.2" "$tmp"
        fi
      ''}
      install -m600 "$tmp" ${cfgDir}/config.json
      rm -f "$tmp"

      install -m644 ${presetsJson} ${dataDir}/presets.json
    '';
  };
}
