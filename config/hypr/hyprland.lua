-- Example available https://raw.githubusercontent.com/hyprwm/Hyprland/refs/heads/main/example/hyprland.lua

------------------
---- MONITORS ----
------------------
-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
  output   = "",
  mode     = "preferred",
  position = "auto",
  scale    = "auto",
})

---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal = "kitty"
local browser  = "firefox"
local menu     = "rofi -show drun"
local obsidian = 'kitty --title "Obsidian Nvim" --class "obsidian-nvim" -e nvim -c ":Obsidian workspace Second\\ Brain"'

-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function()
  -- Load hy3
  hl.exec_cmd('hyprctl plugin load "$HY3_PLUGIN"')

  -- Status Bar
  hl.exec_cmd("waybar")
  -- Wallpaper
  hl.exec_cmd("hyprpaper")
  -- Notification
  hl.exec_cmd("mako")
  --
  -- App
  hl.exec_cmd(terminal .. " --class kitty-startup")
  hl.exec_cmd(browser, { workspace = 2 })
  hl.exec_cmd("signal-desktop")
  hl.exec_cmd("rambox")
  hl.exec_cmd("obsidian")
  hl.exec_cmd(obsidian)
  hl.exec_cmd("pear-desktop")
end)

-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
  general = {
    gaps_in     = 3,
    gaps_out    = 5,
    border_size = 0,
    layout      = "hy3",
  },

  decoration = {
    rounding = 0,
    blur = {
      enabled = false
    },
    shadow = {
      enabled = false
    },
  },
  animations = {
    enabled = true,
  },
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Default springs
hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
  dwindle = {
    preserve_split = true,
  },
})

------------------
----  PLUGIN  ----
------------------

local hy3 = hl.plugin.hy3
hl.config({
  plugin = {
    hy3 = {
      autotile = {
        enable = true
      },
    },
  },
})

----------------
----  MISC  ----
----------------

hl.config({
  misc = {
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
  },
})


---------------
---- INPUT ----
---------------

hl.config({
  input = {
    kb_layout  = "us",
    kb_variant = "altgr-intl",
    touchpad   = {
      tap_to_click = true,
      natural_scroll = true,
      disable_while_typing = true,
    },
  },
})

---------------------
---- KEYBINDINGS ----
---------------------

-- Sets "Windows" key as main modifier
local mainMod = "SUPER"

-- Term
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
--
-- Browser
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))

-- Kill window
hl.bind(mainMod .. " + SHIFT + Q", hy3.kill_active())

-- Menu
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))

-- Apps
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd("rambox"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("pear-desktop"))
hl.bind(mainMod .. " + SHIFT + Z", hl.dsp.exec_cmd("keepassxc"))
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.exec_cmd(obsidian))

-- Lock
hl.bind(mainMod .. " + SLASH", hl.dsp.exec_cmd("hyprlock"))

-- Notifications
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("makoctl dismiss"))
hl.bind(mainMod .. " + SHIFT + SPACE", hl.dsp.exec_cmd("makoctl mode -t do-not-disturb"))

-- Volume
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer -i 3 -u"),
  { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer -d 3 -u"),
  { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pamixer -m"))

-- Media playback
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("XF86AudioStop", hl.dsp.exec_cmd("playerctl stop"))

-- Screenshot
hl.bind("PRINT", hl.dsp.exec_cmd("grimblast save area - | swappy -f -"))
hl.bind(mainMod .. " + PRINT",
  hl.dsp.exec_cmd(
    "grimblast save area -| tesseract stdin stdout | tr -s '[:space:]\0' ' ' | sed 's/^ *//;s/ *$//' | wl-copy"))

-- Change focus
hl.bind(mainMod .. " + H", hy3.move_focus("l"))
hl.bind(mainMod .. " + J", hy3.move_focus("d"))
hl.bind(mainMod .. " + K", hy3.move_focus("u"))
hl.bind(mainMod .. " + L", hy3.move_focus("r"))

-- Move windows
hl.bind(mainMod .. " + SHIFT + H", hy3.move_window("l"))
hl.bind(mainMod .. " + SHIFT + J", hy3.move_window("d"))
hl.bind(mainMod .. " + SHIFT + K", hy3.move_window("u"))
hl.bind(mainMod .. " + SHIFT + L", hy3.move_window("r"))

-- Split direction
hl.bind(mainMod .. " + V", hy3.make_group("v"))
hl.bind(mainMod .. " + C", hy3.make_group("h"))

-- Fullscreen
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())

-- Layout switching (i3-style)
-- Mix with rules when https://github.com/outfoxxed/hy3/issues/148 is solved
hl.bind(mainMod .. " + W", hy3.change_group("toggletab"))
hl.bind(mainMod .. " + E", hy3.change_group("opposite"))

-- Floating
hl.bind(mainMod .. " + SHIFT + BACKSPACE", hl.dsp.window.float())
hl.bind(mainMod .. " + BACKSPACE", hl.dsp.window.cycle_next())
-- Mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Workspace
for workspace = 1, 8 do
  hl.bind(mainMod .. " + " .. workspace, hl.dsp.focus({ workspace = workspace }))
  hl.bind(mainMod .. " + SHIFT + " .. workspace, hy3.move_to_workspace(workspace))
end
hl.bind(mainMod .. " + GRAVE", hl.dsp.focus({ workspace = 9 }))
hl.bind(mainMod .. " + SHIFT + GRAVE", hy3.move_to_workspace(9))
hl.bind(mainMod .. " + TAB", hl.dsp.focus({ workspace = 10 }))
hl.bind(mainMod .. " + SHIFT + TAB", hy3.move_to_workspace(10))

-- Monitors
hl.bind(mainMod .. " + Y", hl.dsp.workspace.move({ monitor = "+1" }))
hl.bind(mainMod .. " + O", hl.dsp.workspace.move({ monitor = "-1" }))

-- Hyprland
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("hyprctl reload"))

-- Resize
hl.bind(mainMod .. "+ R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
  hl.bind("l", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })
  hl.bind("h", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
  hl.bind("k", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })
  hl.bind("j", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
  hl.bind("escape", hl.dsp.submap("reset"))
end)

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

hl.window_rule({
  match = { class = "^(kitty-startup)$" },
  workspace = "1 silent"
})
hl.window_rule({
  match = { class = "^(rambox)$" },
  workspace = "4 silent"
})
hl.window_rule({
  match = { class = "^(signal)$" },
  workspace = "4 silent"
})
hl.window_rule({
  match = { class = "^(brave-browser)$" },
  workspace = "5 silent"
})
hl.window_rule({
  match = { class = "^(obsidian)$" },
  workspace = "8 silent"
})
hl.window_rule({
  match = { class = "^(obsidian-nvim)$" },
  workspace = "9 silent"
})
hl.window_rule({
  match = { class = "^(com.github.th_ch.youtube_music)$" },
  workspace = "10 silent"
})
