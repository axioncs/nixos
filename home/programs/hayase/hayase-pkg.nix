{
  lib,
  pkgs,
  ...
}:
pkgs.appimageTools.wrapAppImage rec {
  pname = "hayase";
  # --- managed by pkg-updates, do not reformat this line ---
  version = "6.4.86";
  # -----------------------------------------------------------------
  src = pkgs.appimageTools.extract {
    inherit pname version;
    src = pkgs.fetchurl {
      url = "https://api.hayase.watch/files/linux-hayase-${version}-linux.AppImage";
      hash = "sha256-Qdi5NO8G8JLUFNDJoCvnM/zZsDlEPn3/GnKAoAosG+0=";
    };
  };
  nativeBuildInputs = with pkgs; [
    makeWrapper
  ];
  extraInstallCommands =
    # bash
    ''
      mkdir -p "$out/share/applications"
      mkdir -p "$out/share/lib/hayase"
      cp -r ${src}/{locales,resources} "$out/share/lib/hayase"
      cp -r ${src}/usr/share/* "$out/share"
      cp "${src}/${pname}.desktop" "$out/share/applications/"
      wrapProgram $out/bin/hayase --add-flags "--ozone-platform=wayland"
      substituteInPlace $out/share/applications/${pname}.desktop --replace-fail 'Exec=AppRun' 'Exec=${meta.mainProgram}'
    '';
  meta = {
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    description = "Hayase - Torrent streaming made simple";
    homepage = "https://hayase.watch";
    changelog = "https://hayase.watch/changelog";
    license = lib.licenses.bsl11;
    mainProgram = "hayase";
  };
}
