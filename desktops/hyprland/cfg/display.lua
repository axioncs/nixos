hl.monitor({
    output              = "eDP-1",
    mode                = "2880x1800@120.001",
    position            = "0x0",
    scale               = 1.5,
    bitdepth            = 10,
    vrr                 = 1,
    cm                  = "srgb",
    supports_hdr        = 1,
    supports_wide_color = 1,
    sdrbrightness       = 1.0,
    sdrsaturation       = 1.0,
    sdr_max_luminance   = 400,
    sdr_min_luminance   = 0.0005,
    max_luminance       = 616,
    min_luminance       = 0.0005,
    max_avg_luminance   = 400,
})

hl.monitor({
    output       = "HDMI-A-1",
    mode         = "1920x1080@60",
    position     = "1920x0",
    scale        = 2.0,
    mirror       = "eDP-1",
})
