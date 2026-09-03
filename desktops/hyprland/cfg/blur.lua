local V = require("cfg/variables")

hl.config({
    decoration = {
        blur = {
            enabled            = V.blur_enabled,
            xray               = V.blur_xray,
            special            = V.blur_special_ws,
            ignore_opacity     = true,
            new_optimizations  = true,
            popups             = V.blur_popups,
            popups_ignorealpha = 0,
            input_methods      = V.blur_input_methods,
            size               = V.blur_size,
            passes             = V.blur_passes,
            noise              = 0.01,
            contrast           = 1.2,
            brightness         = 0.9,
            vibrancy           = 0.4,
            vibrancy_darkness  = 0.4,
        },
    },
})
