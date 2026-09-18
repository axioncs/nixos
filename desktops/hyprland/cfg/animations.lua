local V = require("cfg/variables")

-- ── Bezier curves ────────────────────────────────────────────────────────────

-- snap: Fast, minimal-overshoot deceleration — the workhorse curve
hl.curve("snap", { type = "bezier", points = { { 0.16, 1.0 }, { 0.3, 1.0 } } })

-- pop: Quick entry with a light, controlled bounce (reduced overshoot vs before)
hl.curve("pop", { type = "bezier", points = { { 0.3, 1.05 }, { 0.55, 1.0 } } })

-- glide: Tight ease-out, still smooth but no lingering tail
hl.curve("glide", { type = "bezier", points = { { 0.13, 1.0 }, { 0.25, 1.0 } } })

-- drift: Physical ease-in-out, kept for layer transitions
hl.curve("drift", { type = "bezier", points = { { 0.35, 0.0 }, { 0.25, 1.0 } } })

-- ── Global switch ────────────────────────────────────────────────────────────
hl.config({ animations = { enabled = true } })

-- ── Windows ──────────────────────────────────────────────────────────────────
-- Open: quick scale-up from 95% — small distance, fast settle, light pop
hl.animation({
    leaf    = "windowsIn",
    enabled = true,
    speed   = V.anim_windows_speed,
    bezier  = "pop",
    style   = "popin 95%"
})

-- Close: fast, decisive
hl.animation({
    leaf    = "windowsOut",
    enabled = true,
    speed   = V.anim_windows_speed * 1.15,
    bezier  = "snap",
    style   = "popin 95%"
})

-- Move / resize: near-instant tracking — this is the one you feel most
hl.animation({
    leaf    = "windows",
    enabled = true,
    speed   = V.anim_windows_speed,
    bezier  = "glide"
})

-- ── Workspaces ───────────────────────────────────────────────────────────────
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
    speed   = V.anim_workspace_speed * 1.1,
    bezier  = "snap",
    style   = "slidevert"
})

-- ── Special Workspaces (Scratchpad) ──────────────────────────────────────────
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
    speed   = V.anim_workspace_speed * 1.2,
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
    speed   = V.anim_layer_speed * 1.1,
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
    speed   = V.anim_layer_speed * 1.15,
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
    speed   = V.anim_fade_speed * 1.15,
    bezier  = "snap"
})

-- ── Borders ──────────────────────────────────────────────────────────────────
hl.animation({
    leaf    = "border",
    enabled = true,
    speed   = 6.0,
    bezier  = "glide"
})
