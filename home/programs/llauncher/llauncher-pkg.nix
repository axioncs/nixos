{
  lib,
  stdenv,
  fetchurl,
  appimageTools,
}:

let
  pname = "llauncher";
  # --- managed by pkg-updates, do not reformat these two lines ---
  version = "0.3.2";
  sha256 = "sha256-VzY6Fv4UNXiuMJWC9eZGXYcBIeWFDGAtvxUgJtO+wTA=";
  # ----------------------------------------------------------------------

  src = fetchurl {
    url = "https://github.com/AugustLigh/LLauncher/releases/download/${version}/LLauncher_${version}_amd64.AppImage";
    inherit sha256;
  };

  appimageContents = appimageTools.extract { inherit pname version src; };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraPkgs = pkgs: with pkgs; [
    at-spi2-core
    libGL
    libglvnd
    mesa
    vulkan-loader
    libxrandr
    libxtst
    gtk3
    glib-networking
  ];

  extraInstallCommands = ''
    install -Dm444 ${appimageContents}/LLauncher.desktop -t $out/share/applications
    install -Dm444 ${appimageContents}/llauncher.png \
      $out/share/icons/hicolor/32x32/apps/llauncher.png

    substituteInPlace $out/share/applications/LLauncher.desktop \
      --replace-fail 'Exec=llauncher' 'Exec=${pname}'
  '';

  meta = with lib; {
    description = "Native Linux launcher for Arknights: Endfield (Tauri/Rust)";
    homepage = "https://github.com/AugustLigh/LLauncher";
    license = licenses.mit;
    platforms = [ "x86_64-linux" ];
    mainProgram = "llauncher";
  };
}
