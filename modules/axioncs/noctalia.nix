{
  lib,
  inputs,
  pkgs,
  ...
}:

{
  options.axioncs.noctaliaPackage = lib.mkOption {
    type = lib.types.package;
    description = "Noctalia package from the noctalia flake input";
  };

  config.axioncs.noctaliaPackage = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
}
