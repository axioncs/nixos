{ config, pkgs, inputs, ... }:

let
  shaders = inputs.default-shader-pack + "/shaders";
in
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
      deband-iterations = "2";
      deband-threshold = "35";
      deband-range = "20";
      deband-grain = "5";

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
      sub-bold = "yes";
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
        profile-cond = "(width >= 3840 and height >= 2160) and (p[\"estimated-vf-fps\"] < 55)";
        profile-restore = "copy";
        deband = "no";
        deband-iterations = "0";
      };

      hfr = {
        profile-desc = "High frame rate content";
        profile-cond = "p[\"estimated-vf-fps\"] >= 55";
        profile-restore = "copy";
        deband = "no";
        deband-iterations = "0";
      };
    };

    scripts = with pkgs.mpvScripts; [
      thumbfast
      modernz
    ];

    scriptOpts = {
      modernz = {
        # Layout / theme
        layout = "default";
        icon_theme = "material";
        icon_style = "mixed";
        seekbar_height = "medium";
        nibbles_style = "gap";

        # Scaling
        vidscale = "auto";
        scalewindowed = "1.0";
        scalefullscreen = "1.0";

        # Colors — black/purple palette, semi-transparent OSC
        osc_color = "#12071F";
        seekbarfg_color = "#A970FF";
        seekbarbg_color = "#3A2A52";
        seekbar_cache_color = "#5B3E85";
        seek_handle_color = "#C9A6FF";
        seek_handle_border_color = "#A970FF";
        nibble_color = "#8B5CF6";
        nibble_current_color = "#E9D8FF";
        ab_loop_color = "#7C3AED";

        title_color = "#F3EBFF";
        chapter_title_color = "#D9C7FF";
        time_color = "#E4D4FF";
        cache_info_color = "#E4D4FF";

        side_buttons_color = "#E9D8FF";
        middle_buttons_color = "#E9D8FF";
        playpause_color = "#FFFFFF";
        held_element_color = "#7C3AED";
        hover_effect_color = "#A970FF";

        window_title_color = "#F3EBFF";
        window_controls_color = "#E9D8FF";
        windowcontrols_close_hover = "#F45C5B";
        windowcontrols_max_hover = "#C9A6FF";
        windowcontrols_min_hover = "#8B5CF6";

        thumbnail_box_color = "#150A24";
        thumbnail_box_outline = "#4C2E7A";

        # Semi-transparent OSC/window fade (lower = more transparent)
        osc_fade_strength = "80";
        fade_blur_strength = "60";
        window_fade_strength = "80";
        window_fade_blur_strength = "60";
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

  xdg.configFile."mpv/input.conf".text = ''
    CTRL+1 no-osd change-list glsl-shaders set "~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Restore_CNN_VL.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_VL.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl"; show-text "Anime4K: Mode A (HQ)"
    CTRL+2 no-osd change-list glsl-shaders set "~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Restore_CNN_Soft_VL.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_VL.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl"; show-text "Anime4K: Mode B (HQ)"
    CTRL+3 no-osd change-list glsl-shaders set "~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Upscale_Denoise_CNN_x2_VL.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl"; show-text "Anime4K: Mode C (HQ)"
    CTRL+4 no-osd change-list glsl-shaders set "~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Restore_CNN_VL.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_VL.glsl:~~/shaders/Anime4K_Restore_CNN_M.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl"; show-text "Anime4K: Mode A+A (HQ)"
    CTRL+5 no-osd change-list glsl-shaders set "~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Restore_CNN_Soft_VL.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_VL.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Restore_CNN_Soft_M.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl"; show-text "Anime4K: Mode B+B (HQ)"
    CTRL+6 no-osd change-list glsl-shaders set "~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Upscale_Denoise_CNN_x2_VL.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Restore_CNN_M.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl"; show-text "Anime4K: Mode C+A (HQ)"
    CTRL+0 no-osd change-list glsl-shaders clr ""; show-text "GLSL shaders cleared"
  '';

  xdg.configFile."mpv/scripts/discord.lua".source = ./scripts/discord.lua;

  xdg.configFile."mpv/shaders".source = shaders;

  xdg.configFile."mpv/discord" = {
    source = ./discord;
    executable = true;
  };

  home.file = {
    ".local/share/fonts/NetflixSans-Medium.ttf".source = ./fonts/NetflixSans-Medium.ttf;
  };

  fonts.fontconfig.enable = true;
}
