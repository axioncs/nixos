local V          = require("cfg/variables")
local mod        = V.mod  -- "SUPER"
local mod2       = V.mod2 -- "SUPER + ALT"

-- Layout cycling
local layout_idx = 1
for i, name in ipairs(V.layout_cycle) do
    if name == V.default_layout then
        layout_idx = i
        break
    end
end

hl.bind(mod2 .. " + W", function()
    layout_idx = (layout_idx % #V.layout_cycle) + 1
    local next_layout = V.layout_cycle[layout_idx]
    hl.config({ general = { layout = next_layout } })
    hl.notification.create({
        text    = "Layout: " .. next_layout,
        timeout = 2000,
    })
end)

-- Applications
hl.bind(mod .. " + T", hl.dsp.exec_cmd(V.terminal))
hl.bind(mod .. " + E", hl.dsp.exec_cmd(V.fileManager))
hl.bind(mod .. " + W", hl.dsp.exec_cmd(V.browser))
hl.bind(mod .. " + C", hl.dsp.exec_cmd(V.editor))
hl.bind(mod .. " + M", hl.dsp.exec_cmd("stremio-enhanced"))
hl.bind(mod .. " + H", hl.dsp.exec_cmd("hayase"))
hl.bind(mod2 .. " + G", hl.dsp.exec_cmd("faugus-launcher"))
hl.bind(mod2 .. " + A", hl.dsp.exec_cmd("llauncher"))

--  Hypr Scipts
hl.bind("CTRL + " .. mod .. " + A", hl.dsp.exec_cmd("~/.config/hypr/bin/hypr-lens"))
hl.bind("CTRL + " .. mod .. " + Z", hl.dsp.exec_cmd("~/.config/hypr/bin/hypr-ocr"))

--  Aria AI Assistant
hl.bind(mod .. " + A", hl.dsp.workspace.toggle_special("aria"))

--  Special workspaces (scratchpads)
hl.bind(mod .. " + D", hl.dsp.workspace.toggle_special("discord"))
hl.bind(mod .. " + SHIFT + D", hl.dsp.workspace.toggle_special("whatsapp"))
hl.bind(mod2 .. " + D", hl.dsp.workspace.toggle_special("equibop"))
hl.bind(mod .. " + S", hl.dsp.workspace.toggle_special("spotify"))
hl.bind(mod .. " + SHIFT + S", hl.dsp.workspace.toggle_special("vpn"))
hl.bind(mod .. " + G", hl.dsp.workspace.toggle_special("steam"))
hl.bind("CTRL + SHIFT + Escape", hl.dsp.workspace.toggle_special("btop"))
hl.bind(mod .. " + SHIFT + Q", hl.dsp.workspace.toggle_special("qbittorrent"))

--  Noctalia binds
hl.bind("ALT + space", hl.dsp.exec_cmd("noctalia msg panel-toggle launcher"))
hl.bind(mod .. " + I", hl.dsp.exec_cmd("noctalia msg settings-toggle"))
hl.bind(mod .. " + SHIFT + X", hl.dsp.exec_cmd("noctalia msg session lock"))
hl.bind(mod2 .. " + X", hl.dsp.exec_cmd("noctalia msg panel-toggle session"))
hl.bind(mod .. " + V", hl.dsp.exec_cmd("noctalia msg panel-toggle clipboard"))
hl.bind(mod .. " + R", hl.dsp.exec_cmd("noctalia msg config-reload"))
hl.bind(mod .. " + space", hl.dsp.exec_cmd("noctalia msg panel-toggle control-center"))
hl.bind(mod .. " + SHIFT + A", hl.dsp.exec_cmd("noctalia msg panel-toggle control-center system"))
hl.bind(mod .. " + SHIFT + W", hl.dsp.exec_cmd("noctalia msg panel-toggle noctalia/wallhaven:browser"))
hl.bind(mod .. " + N", hl.dsp.exec_cmd("noctalia msg panel-toggle control-center notifications"))
hl.bind(mod2 .. " + V", hl.dsp.exec_cmd("noctalia msg panel-toggle control-center audio"))

--  Brightness
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("noctalia msg brightness-up"), { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("noctalia msg brightness-down"), { locked = true })

--  Media controls
hl.bind(mod .. " + CTRL + Space", hl.dsp.exec_cmd("noctalia msg media toggle"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("noctalia msg media toggle"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("noctalia msg media toggle"), { locked = true })
hl.bind(mod .. " + CTRL + Equal", hl.dsp.exec_cmd("noctalia msg media next"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("noctalia msg media next"), { locked = true })
hl.bind(mod .. " + CTRL + Minus", hl.dsp.exec_cmd("noctalia msg media previous"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("noctalia msg media previous"), { locked = true })
hl.bind("XF86AudioStop", hl.dsp.exec_cmd("noctalia msg media stop"), { locked = true })

-- Volume
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("SUPER + SHIFT + M", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd(
        "wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume -l " ..
        (V.volume_max / 100) .. " @DEFAULT_AUDIO_SINK@ " .. V.volume_step .. "%+"
    ),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd(
        "wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume @DEFAULT_AUDIO_SINK@ " .. V.volume_step .. "%-"
    ),
    { locked = true, repeating = true }
)

--  Window: close
hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod2 .. " + Q", hl.dsp.window.kill())
hl.bind(mod .. " + mouse:274", hl.dsp.window.close(), { mouse = true })

--  Workspace: switch
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mod2 .. " + mouse_down", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind(mod2 .. " + mouse_up", hl.dsp.window.move({ workspace = "e-1" }))

for i = 1, 9 do
    hl.bind(mod .. " + " .. i, hl.dsp.focus({ workspace = i }))
    hl.bind(mod2 .. " + " .. i, hl.dsp.window.move({ workspace = i }))
end

--  Window: float / fullscreen / group
hl.bind(mod2 .. " + space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mod2 .. " + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(mod .. " + SHIFT + C", hl.dsp.group.toggle())

--  Mouse drag / resize
hl.bind(mod .. " + Z", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + X", hl.dsp.window.resize(), { mouse = true })

-- Window actions
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(mod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + down", hl.dsp.focus({ direction = "down" }))
hl.bind(mod .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mod .. " + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mod .. " + SHIFT + down", hl.dsp.window.move({ direction = "down" }))

--  Layout-specific utility binds
hl.bind(mod2 .. " + P", hl.dsp.window.pseudo())           -- dwindle: pseudo-tile
hl.bind(mod2 .. " + T", hl.dsp.layout("togglesplit"))     -- dwindle: flip split
hl.bind(mod2 .. " + M", hl.dsp.layout("swapmaster"))      -- master: swap with master
hl.bind(mod2 .. " + down", hl.dsp.layout("cyclenext"))    -- monocle: next window
hl.bind(mod2 .. " + up", hl.dsp.layout("cyclenext prev")) -- monocle: prev window

--  Screenshots
hl.bind("Print", hl.dsp.exec_cmd("noctalia msg screenshot-fullscreen"))
hl.bind("CTRL + Print", hl.dsp.exec_cmd("noctalia msg screenshot-region"))

--  Exit / Power
hl.bind(mod .. " + SHIFT + E", hl.dsp.exit())

hl.bind(mod .. " + SHIFT + P", function()
    hl.timer(function()
        hl.dispatch(hl.dsp.dpms({ action = "disable" }))
    end, { timeout = 500, type = "oneshot" })
end)

--  Laptop lid events
pcall(function()
    hl.bind("switch:on:Lid Switch", hl.dsp.dpms({ action = "disable" }), { locked = true })
    hl.bind("switch:off:Lid Switch", hl.dsp.dpms({ action = "enable" }), { locked = true })
end)

--  Update dotfiles (git pull + re-symlink via install.fish --update)
hl.bind(mod .. " + SHIFT + U", hl.dsp.exec_cmd(
    "sh -c 'fish ~/.local/share/hyprdots/install.fish --update &'"
))

-- Alt+Tab (standard MRU)
hl.bind("ALT + Tab", hl.dsp.exec_cmd("snappy-switcher next --mod alt"))

-- Super+Tab (workspace-filtered)
hl.bind(mod .. " + TAB", hl.dsp.exec_cmd("snappy-switcher next --workspace --mod super"))
