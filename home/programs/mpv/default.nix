{ config, pkgs, ... }:

{
  programs.mpv = {
    enable = true;

    config = {
      vo = "gpu-next";
      gpu-api = "vulkan";
      gpu-context = "waylandvk";
      vulkan-async-compute = "yes";
      vulkan-async-transfer = "yes";

      hwdec = "vaapi";
      hwdec-codecs = "all";
      vd-lavc-dr = "yes";

      video-sync = "audio";
      interpolation = "no";
      tscale = "oversample";

      dither-depth = "10";
      dither = "error-diffusion";
      error-diffusion = "sierra-lite";

      scale = "ewa_lanczossharp";
      cscale = "ewa_lanczossharp";
      dscale = "mitchell";
      scale-antiring = "0.6";
      cscale-antiring = "0.6";

      glsl-shaders = "~~/shaders/KrigBilateral.glsl";

      deband = "yes";
      deband-iterations = "3";
      deband-threshold = "35";
      deband-range = "16";
      deband-grain = "8";

      target-colorspace-hint = "yes";
      target-colorspace-hint-mode = "source-dynamic";
      target-trc = "auto";
      target-prim = "auto";
      target-peak = "400";
      target-contrast = "inf";
      target-gamut = "dci-p3";
      tone-mapping = "bt.2390";
      hdr-compute-peak = "yes";
      hdr-peak-percentile = "99.995";
      hdr-contrast-recovery = "0.30";
      tone-mapping-max-boost = "1.0";
      gamut-mapping-mode = "perceptual";

      sub-font = "Netflix Sans Medium";
      sub-bold = "no";
      sub-font-size = "35";
      sub-shadow-offset = "1";
      sub-color = "#FFFFFF";

      fullscreen = "yes";
      border = "no";
      osc = "no";
      osd-level = "0";
      save-position-on-quit = "no";
      keep-open = "yes";
      cursor-autohide = "1000";
    };

    profiles = {
      "4k" = {
        profile-desc = "4K UHD content";
        profile-cond = "(width >= 3840 and height >= 2160)";
        profile-restore = "copy";
        deband = "no";
        deband-iterations = "0";
      };
      anime = {
        profile-desc = "Anime content";
        profile-cond = "((width == 1920 and height == 1080) or (width == 1280 and height == 720)) and (estimated-vf-fps <= 30)";
        profile-restore = "copy";
        glsl-shaders-append = "~~/shaders/Anime4K_Restore_CNN_Soft_VL.glsl";
      };
      hfr = {
        profile-desc = "High frame rate content";
        profile-cond = "(estimated-vf-fps >= 55)";
        profile-restore = "copy";
        deband = "no";
        deband-iterations = "0";
      };
    };

    scripts = with pkgs.mpvScripts; [
      thumbfast
    ];

    scriptOpts = {
      modernx = {
        vid_scale = "no";
        scale_windowed = "1.5";
        scale_fullscreen = "1.5";
        scale_forced_window = "1.5";
      };

      discord = {
        key = "D";
        active = "no";
        client_id = "1328997690339758141";
        binary_path = "${config.home.homeDirectory}/nixos/home/programs/mpv/discord";
        socket_path = "/tmp/mpvsocket";
        use_static_socket_path = "yes";
        autohide_threshold = "0";
      };
    };
  };

  xdg.configFile = {
    "mpv/scripts/modernx.lua".source = ./scripts/modernx.lua;
    "mpv/scripts/discord.lua".source = ./scripts/discord.lua;

    "mpv/shaders/KrigBilateral.glsl".source = ./shaders/KrigBilateral.glsl;
    "mpv/shaders/Anime4K_Restore_CNN_Soft_VL.glsl".source = ./shaders/Anime4K_Restore_CNN_Soft_VL.glsl;

    "mpv/discord" = {
      source = ./discord;
      executable = true;
    };
  };

  home.file = {
    ".local/share/fonts/NetflixSans-Medium.ttf".source = ./fonts/NetflixSans-Medium.ttf;
    ".local/share/fonts/fluent-system-icons.ttf".source = ./fonts/fluent-system-icons.ttf;
  };

  fonts.fontconfig.enable = true;
}
