local V = require("cfg/variables")

-- Helpers
local function float(match, size)
    hl.window_rule({ match = match, float = true, center = true, size = size })
end

local function bottom_right(rule)
    rule.move = { "monitor_w - window_w - 10", "monitor_h - window_h - 10" }
    hl.window_rule(rule)
end

-- Workspaces
for i = 1, 5 do
    hl.workspace_rule({ workspace = tostring(i), monitor = "eDP-1", persistent = true })
end

-- Layers
hl.layer_rule({
    name         = "noctalia",
    match        = { namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd)$" },
    no_anim      = true,
    ignore_alpha = 0.5,
    blur         = true,
    blur_popups  = true,
})

-- Special workspaces (scratchpads)
local scratchpads = {
    discord = { class = "^(discord)$",         cmd = "discordptb", float = true },
    equibop = { class = "^(equibop)$",         cmd = "equibop",    float = true },
    spotify = { class = "^(Spotify|spotify)$", cmd = "spotify" },
    steam   = { class = "^(Steam|steam)$",     cmd = "steam" },
    btop    = { cmd = "kitty -e btop" },
    aria    = { cmd = V.aria },
    vpn     = { cmd = V.vpn },
}

for name, s in pairs(scratchpads) do
    if s.class then
        hl.window_rule({
            match     = { class = s.class },
            workspace = "special:" .. name,
            float     = s.float,
            size      = s.float and V.scratchpad_discord_size or nil,
        })
    end
end

-- Launch app when a special workspace is created empty
hl.on("workspace.created", function(ws)
    local name = ws.name:match("^special:(.+)$")
    local s = name and scratchpads[name]
    if s and ws.is_empty then
        hl.exec_cmd(s.cmd)
    end
end)

-- Opacity
hl.window_rule({
    match   = { class = ".*" },
    opacity = string.format("%.2f override %.2f override", V.opacity_focused, V.opacity_unfocused),
})

-- Opaque apps (must stay after the global rule)
hl.window_rule({
    match   = { class = "^(mpv|stremio-enhanced|hayase|steam_proton|steam_app_.*|gamescope|Waydroid)$" },
    opacity = "1.0 override 1.0 override",
})

-- Floating windows
float({ class = "^(twintaillauncher)$" }, { 1200, 750 })
float({ title = "^(Pick game to add|Open File|Location|Open Files|Open Folder|Open|Save|Save As|Export|Import|Choose File|Rename|Select what to share)$|File Upload" }, { 1000, 600 })
float({ class = "^hyprland-share-picker$" }, { 1000, 600 })
float({ class = "^(DesktopEditors|imv)$" })

-- Picture-in-Picture
hl.window_rule({
    match = { title = "^(Picture-in-Picture|Picture in picture)$" },
    float = true,
    size  = { 320, 200 },
    pin   = true,
})
bottom_right({ match = { title = "^(Picture-in-Picture|Picture in picture)$" } })

-- Steam (order matters: float all, then re-tile main window)
hl.window_rule({ match = { class = "steam" }, float = true })
hl.window_rule({ match = { class = "steam", title = "^[Ss]team$" }, float = false })
hl.window_rule({ match = { class = "steam", title = "^Steam Big Picture Mode$" }, fullscreen = true })

-- Steam toasts
bottom_right({
    match            = { class = "steam", title = "^notificationtoasts_\\d+_desktop$" },
    float            = true,
    no_focus         = true,
    no_initial_focus = true,
    workspace        = "unset",
    suppress_event   = "activate activatefocus",
})

-- Fullscreen
hl.window_rule({ match = { class = "^(Waydroid|gamescope)$" }, fullscreen = true })

-- Maximized
local maximized = "^(stremio-enhanced|hayase|steam_proton|harbor)$"

hl.window_rule({ match = { class = maximized, float = false }, maximize = true })
hl.window_rule({
    match          = { class = maximized, float = true },
    center         = true,
    suppress_event = "fullscreen maximize",
})
