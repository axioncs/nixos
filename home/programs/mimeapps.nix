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

      "audio/mpeg" = [ "mpv.desktop" ];
      "audio/mp3" = [ "mpv.desktop" ];
      "audio/x-mp3" = [ "mpv.desktop" ];
      "audio/flac" = [ "mpv.desktop" ];
      "audio/x-flac" = [ "mpv.desktop" ];
      "audio/x-wav" = [ "mpv.desktop" ];
      "audio/wav" = [ "mpv.desktop" ];
      "audio/ogg" = [ "mpv.desktop" ];
      "audio/x-vorbis+ogg" = [ "mpv.desktop" ];
      "audio/x-opus+ogg" = [ "mpv.desktop" ];
      "audio/m4a" = [ "mpv.desktop" ];
      "audio/x-m4a" = [ "mpv.desktop" ];
      "audio/x-ape" = [ "mpv.desktop" ];
      "audio/tta" = [ "mpv.desktop" ];
      "application/xspf+xml" = [ "mpv.desktop" ];
      "audio/x-scpls" = [ "mpv.desktop" ];
      "audio/x-pls" = [ "mpv.desktop" ];
      "audio/m3u" = [ "mpv.desktop" ];

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
