{ config, pkgs, ... }:

{
  xdg.configFile."yt-dlp/config".text = ''
    --downloader aria2c
    --downloader-args "aria2c:-x 16 -k 1M --file-allocation=none"
    --continue
    --retries 10
    -f "bv*+ba/b"
    -S "res,codec:av1"
    --merge-output-format mkv
    --embed-metadata
    --write-subs
    --no-write-auto-subs
    --embed-subs
    --sub-langs "en.*"
    --convert-subs srt
    --compat-options no-keep-subs
    -o "~/Videos/yt-dlp/%(playlist_title|Videos)s/%(playlist_index&{} - |)s%(title)s [%(id)s].%(ext)s"
    --ignore-errors
    --download-archive ~/.config/yt-dlp/archive.txt
    --sponsorblock-remove all
  '';

  home.activation.ytDlpArchive = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "$HOME/.config/yt-dlp"
    touch "$HOME/.config/yt-dlp/archive.txt"
  '';
}
