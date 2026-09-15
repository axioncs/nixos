{ ... }:

{
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    extraConfig.pipewire."92-samplerate" = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.allowed-rates" = [ 44100 48000 88200 96000 176400 192000 352800 384000 ];
      };
    };

    extraConfig.pipewire-pulse."92-low-latency" = {
      "context.properties" = [
        {
          name = "libpipewire-module-protocol-pulse";
          args = {
            "pulse.min.req" = "256/48000";
            "pulse.min.frag" = "256/48000";
            "pulse.min.quantum" = "256/48000";
          };
        }
      ];
    };

    wireplumber.extraConfig."51-fiio-ja11" = {
      "monitor.alsa.rules" = [
        {
          matches = [{ "node.name" = "~alsa_output.usb-FIIO_JadeAudio.*"; }];
          actions = {
            update-props = {
              "audio.allow-resampling" = false;
              "api.alsa.period-size" = 1024;
            };
          };
        }
      ];
    };
  };
}
