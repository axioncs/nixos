local V = require("cfg/variables")

-- ── Bezier curves ────────────────────────────────────────────────────────────

-- snap: Fast initial movement, but with a subtle cushion at the end to prevent jarring stops
hl.curve("snap", { type = "bezier", points = { { 0.22, 1.0 }, { 0.36, 1.0 } } })

-- pop: Organic, high-end entry curve with a gentle, silky-smooth bounce
hl.curve("pop", { type = "bezier", points = { { 0.25, 1.15 }, { 0.5, 1.0 } } })

-- glide: The classic "buttery smooth" ease-out (easeOutQuint) for elegant transitions
hl.curve("glide", { type = "bezier", points = { { 0.23, 1.0 }, { 0.32, 1.0 } } })

-- drift: Natural, weighted ease-in-out that feels physical and intentional
hl.curve("drift", { type = "bezier", points = { { 0.35, 0.0 }, { 0.25, 1.0 } } })

-- ── Global switch ────────────────────────────────────────────────────────────
hl.config({ animations = { enabled = true } })

-- ── Windows ──────────────────────────────────────────────────────────────────
-- Open: Smoothly scales up from 88% with an elegant, soft elastic settle
hl.animation({
    leaf    = "windowsIn",
    enabled = true,
    speed   = V.anim_windows_speed,
    bezier  = "pop",
    style   = "popin 88%"
})

-- Close: Fades/scales out decisively but smoothly without feeling clipped
hl.animation({
    leaf    = "windowsOut",
    enabled = true,
    speed   = V.anim_windows_speed * 0.9,
    bezier  = "snap",
    style   = "popin 92%"
})

-- Move / resize: Fluid, liquid-like tracking that safely matches your input
hl.animation({
    leaf    = "windows",
    enabled = true,
    speed   = V.anim_windows_speed,
    bezier  = "glide"
})

-- ── Workspaces ───────────────────────────────────────────────────────────────
-- Vertical sliding (Up/Down) with a gorgeous, premium ease-out curve
hl.animation({
    leaf    = "workspaces",
    enabled = true,
    speed   = V.anim_workspace_speed,
    bezier  = "glide",
    style   = "slidevert"
})

hl.animation({
    leaf    = "workspacesIn",
    enabled = true,
    speed   = V.anim_workspace_speed,
    bezier  = "glide",
    style   = "slidevert"
})

hl.animation({
    leaf    = "workspacesOut",
    enabled = true,
    speed   = V.anim_workspace_speed * 0.95,
    bezier  = "snap",
    style   = "slidevert"
})

-- ── Special Workspaces (Scratchpad) ──────────────────────────────────────────
-- Drops down elegantly from the top edge; retreats upward quickly
hl.animation({
    leaf    = "specialWorkspaceIn",
    enabled = true,
    speed   = V.anim_workspace_speed,
    bezier  = "glide",
    style   = "slidevert"
})

hl.animation({
    leaf    = "specialWorkspaceOut",
    enabled = true,
    speed   = V.anim_workspace_speed * 0.85,
    bezier  = "snap",
    style   = "slidevert"
})

-- ── Layer-shell (panels, notifications, overlays) ────────────────────────────
hl.animation({
    leaf    = "layersIn",
    enabled = false,
    speed   = V.anim_layer_speed,
    bezier  = "drift",
    style   = "slide"
})

hl.animation({
    leaf    = "layersOut",
    enabled = false,
    speed   = V.anim_layer_speed * 0.9,
    bezier  = "snap",
    style   = "fade"
})

hl.animation({
    leaf    = "fadeLayersIn",
    enabled = true,
    speed   = V.anim_layer_speed,
    bezier  = "glide"
})

hl.animation({
    leaf    = "fadeLayersOut",
    enabled = true,
    speed   = V.anim_layer_speed * 0.9,
    bezier  = "snap"
})

-- ── Fade (focus change, opacity transitions) ─────────────────────────────────
hl.animation({
    leaf    = "fade",
    enabled = true,
    speed   = V.anim_fade_speed,
    bezier  = "glide"
})

hl.animation({
    leaf    = "fadeIn",
    enabled = true,
    speed   = V.anim_fade_speed,
    bezier  = "glide"
})

hl.animation({
    leaf    = "fadeOut",
    enabled = true,
    speed   = V.anim_fade_speed * 0.9,
    bezier  = "snap"
})

-- ── Borders ──────────────────────────────────────────────────────────────────
hl.animation({
    leaf = "border",
    enabled = true,
    speed = 4.5,
    bezier = "glide"
})
