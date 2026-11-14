local V = require("cfg/variables")

-- Curves
local curves = {
    snap  = { { 0.16, 1.0 }, { 0.3, 1.0 } },   -- fast decel
    pop   = { { 0.3, 1.05 }, { 0.55, 1.0 } },  -- light bounce
    glide = { { 0.13, 1.0 }, { 0.25, 1.0 } },  -- tight ease-out
    drift = { { 0.35, 0.0 }, { 0.25, 1.0 } },  -- ease-in-out
}
for name, points in pairs(curves) do
    hl.curve(name, { type = "bezier", points = points })
end

hl.config({ animations = { enabled = true } })

local w  = V.anim_windows_speed
local ws = V.anim_workspace_speed
local l  = V.anim_layer_speed
local f  = V.anim_fade_speed

-- { leaf, enabled, speed, bezier, style }
local anims = {
    -- Windows
    { "windowsIn",           true,  w,        "pop",   "popin 95%" },
    { "windowsOut",          true,  w * 1.15, "snap",  "popin 95%" },
    { "windows",             true,  w,        "glide" },

    -- Workspaces
    { "workspaces",          true,  ws,        "glide", "slidevert" },
    { "workspacesIn",        true,  ws,        "glide", "slidevert" },
    { "workspacesOut",       true,  ws * 1.1,  "snap",  "slidevert" },
    { "specialWorkspaceIn",  true,  ws,        "glide", "slidevert" },
    { "specialWorkspaceOut", true,  ws * 1.2,  "snap",  "slidevert" },

    -- Layers
    { "layersIn",            false, l,        "drift", "slide" },
    { "layersOut",           false, l * 1.1,  "snap",  "fade" },
    { "fadeLayersIn",        true,  l,        "glide" },
    { "fadeLayersOut",       true,  l * 1.15, "snap" },

    -- Fade
    { "fade",                true,  f,        "glide" },
    { "fadeIn",              true,  f,        "glide" },
    { "fadeOut",             true,  f * 1.15, "snap" },

    -- Border
    { "border",              true,  6.0,      "glide" },
}

for _, a in ipairs(anims) do
    hl.animation({ leaf = a[1], enabled = a[2], speed = a[3], bezier = a[4], style = a[5] })
end
