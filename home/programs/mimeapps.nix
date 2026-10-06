{ ... }:

{
  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "text/html" = [ "zen-twilight.desktop" ];
      "x-scheme-handler/http" = [ "zen-twilight.desktop" ];
      "x-scheme-handler/https" = [ "zen-twilight.desktop" ];
      "x-scheme-handler/about" = [ "zen-twilight.desktop" ];
      "x-scheme-handler/unknown" = [ "zen-twilight.desktop" ];

      "application/pdf" = [ "org.pwmt.zathura.desktop" ];

      "video/mp4" = [ "mpv.desktop" ];
      "video/x-matroska" = [ "mpv.desktop" ];
      "video/webm" = [ "mpv.desktop" ];
      "video/mpeg" = [ "mpv.desktop" ];
      "video/quicktime" = [ "mpv.desktop" ];
      "video/x-msvideo" = [ "mpv.desktop" ];

      "audio/mpeg" = [ "tauonmb.desktop" ];
      "audio/mp3" = [ "tauonmb.desktop" ];
      "audio/x-mp3" = [ "tauonmb.desktop" ];
      "audio/flac" = [ "tauonmb.desktop" ];
      "audio/x-flac" = [ "tauonmb.desktop" ];
      "audio/x-wav" = [ "tauonmb.desktop" ];
      "audio/wav" = [ "tauonmb.desktop" ];
      "audio/ogg" = [ "tauonmb.desktop" ];
      "audio/x-vorbis+ogg" = [ "tauonmb.desktop" ];
      "audio/x-opus+ogg" = [ "tauonmb.desktop" ];
      "audio/m4a" = [ "tauonmb.desktop" ];
      "audio/x-m4a" = [ "tauonmb.desktop" ];
      "audio/x-ape" = [ "tauonmb.desktop" ];
      "audio/tta" = [ "tauonmb.desktop" ];
      "application/xspf+xml" = [ "tauonmb.desktop" ];
      "audio/x-scpls" = [ "tauonmb.desktop" ];
      "audio/x-pls" = [ "tauonmb.desktop" ];
      "audio/m3u" = [ "tauonmb.desktop" ];

      "image/png" = [ "imv-dir.desktop" ];
      "image/jpeg" = [ "imv-dir.desktop" ];
      "image/gif" = [ "imv-dir.desktop" ];
      "image/webp" = [ "imv-dir.desktop" ];
      "image/bmp" = [ "imv-dir.desktop" ];
      "image/svg+xml" = [ "imv-dir.desktop" ];

      "application/zip" = [ "org.gnome.Nautilus.desktop" ];
      "application/x-7z-compressed" = [ "org.gnome.Nautilus.desktop" ];
      "application/x-tar" = [ "org.gnome.Nautilus.desktop" ];
      "application/x-rar" = [ "org.gnome.Nautilus.desktop" ];

      "inode/directory" = [ "org.gnome.Nautilus.desktop" ];

      "text/plain" = [ "dev.zed.Zed.desktop" ];
    };
  };
}
