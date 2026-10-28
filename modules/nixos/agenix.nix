{ config, inputs, pkgs, ... }:

let
  user = config.axioncs.username;
  own = file: { inherit file; owner = user; mode = "0400"; };
in
{
  environment.systemPackages = [ inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default ];

  age.identityPaths = [ "/var/lib/agenix/id_ed25519" ];

  age.secrets = {
    nix-netrc = own ../../secrets/nix-netrc.age;
    nix-github-token = own ../../secrets/nix-github-token.age;
    aria2-rpc = own ../../secrets/aria2-rpc.age;
    steamgriddb = own ../../secrets/steamgriddb.age;
    navidrome-env.file = ../../secrets/navidrome-env.age;
  };
}
