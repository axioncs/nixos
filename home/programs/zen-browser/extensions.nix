{ inputs, pkgs, lib, ... }:

let
  firefox-addons =
    inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system};

    cat-catch = pkgs.stdenv.mkDerivation rec {
      pname = "cat-catch";
      version = "2.7.2";
      addonId = "xifangczy@gmail.com";

      src = pkgs.fetchurl {
        url = "https://addons.mozilla.org/firefox/downloads/file/4925981/cat_catch-2.7.2.xpi";
        hash = "sha256-GsdsE6nPJ5RB9yXrTUl3x0MGu9DLwt+9dvRVuyKDyz8=";
      };

      preferLocalBuild = true;
      passthru = { inherit addonId; };

      buildCommand = ''
        dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
        mkdir -p "$dst"
        install -v -m644 "$src" "$dst/${addonId}.xpi"
      '';

      meta.license = lib.licenses.gpl3Only;
    };

  shared = {
    extensions.packages = (with firefox-addons; [
      aria2-integration
      bitwarden
      dearrow
      return-youtube-dislikes
      single-file
      sponsorblock
      ublock-origin
      violentmonkey
      zotero-connector
    ]) ++ [ cat-catch ];
    presets.betterfox.enable = true;
  };
in
{
  programs.zen-browser.profiles = lib.genAttrs [ "default" "dark" ] (_: shared);
}
