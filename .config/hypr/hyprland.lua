-- Hyprland config translated from ~/.config/hypr/hyprland.conf.
-- Hyprland 0.55+ uses Lua config at ~/.config/hypr/hyprland.lua.

local mod = "SUPER"
local terminal = "ghostty"
local browser = "helium-browser"
local file_manager = "nautilus"

local function bind(keys, dispatcher, flags)
  hl.bind(keys, dispatcher, flags)
end

local function exec(cmd)
  return hl.dsp.exec_cmd(cmd)
end

local function layout(msg)
  return hl.dsp.layout(msg)
end

-- Environment
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_STYLE_OVERRIDE", "kvantum")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("_JAVA_AWT_WM_NONREPARENTING", "1")
hl.env("SDL_VIDEODRIVER", "wayland,x11")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("DESKTOP_SESSION", "Hyprland")
hl.env("XCURSOR_THEME", "WhiteSur-cursors")
hl.env("XCURSOR_SIZE", "36")

-- Monitors
hl.monitor({ output = "HDMI-A-1", mode = "2560x1440@143.912", position = "0x0", scale = 1 })
hl.monitor({ output = "eDP-1", mode = "1920x1080@144.003", position = "2560x0", scale = 1 })
-- Niri had eDP-1 disabled in cfg/display.kdl. Uncomment this if you want the laptop panel off in Hyprland too.
-- hl.monitor({ output = "eDP-1", disabled = true })

-- Workspaces
hl.workspace_rule({ workspace = "2", monitor = "HDMI-A-1" })

hl.config({
  input = {
    kb_layout = "br",
    kb_variant = "abnt2",
    numlock_by_default = true,
    follow_mouse = 0,
    touchpad = {
      natural_scroll = true,
      tap_to_click = true,
    },
  },
  general = {
    -- gaps_in = 4,
    gaps_out = 4,
    border_size = 4,
    col = {
      active_border = "rgb(8ff0a4)",
      inactive_border = "rgb(303030)",
    },
    layout = "scrolling",
    allow_tearing = true,
    resize_on_border = true,
  },
  decoration = {
    rounding = 3,
    shadow = {
      enabled = true,
    },
  },
  scrolling = {
    column_width = 0.5,
    fullscreen_on_one_column = false,
    explicit_column_widths = "0.33333, 0.5, 0.66667, 1.0",
    focus_fit_method = 0,
    follow_focus = true,
  },
  misc = {
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
    focus_on_activate = true,
    vrr = 1,
  },
  xwayland = {
    force_zero_scaling = true,
  },
})

hl.device({
  name = "pointer",
  accel_profile = "flat",
  sensitivity = 0,
})

-- Animations
hl.config({ animations = { enabled = true } })
hl.curve("niriEaseOutQuad", { type = "bezier", points = { { 0.25, 0.46 }, { 0.45, 0.94 } } })
hl.curve("niriEaseOutCubic", { type = "bezier", points = { { 0.215, 0.61 }, { 0.355, 1 } } })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 2, bezier = "niriEaseOutQuad" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2, bezier = "niriEaseOutCubic" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 4, bezier = "niriEaseOutQuad" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 3, bezier = "niriEaseOutQuad" })
hl.animation({ leaf = "border", enabled = true, speed = 4, bezier = "niriEaseOutQuad" })
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "niriEaseOutQuad" })

-- Autostart
hl.on("hyprland.start", function()
  hl.exec_cmd(
  "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_DESKTOP XDG_SESSION_TYPE DESKTOP_SESSION QT_QPA_PLATFORM QT_QPA_PLATFORMTHEME GTK_THEME XCURSOR_THEME XCURSOR_SIZE")
  hl.exec_cmd("sh -c 'command -v xrandr >/dev/null 2>&1 && xrandr --output HDMI-A-1 --primary'")
  hl.exec_cmd("qs -c noctalia-shell")
  hl.exec_cmd("swayidle -w")
end)

-- Applications / Noctalia
bind(mod .. " + RETURN", exec(terminal))
bind(mod .. " + SPACE", exec("qs -c noctalia-shell ipc call launcher toggle"))
bind(mod .. " + B", exec(browser))
bind(mod .. " + ALT + L", exec("qs -c noctalia-shell ipc call lockScreen lock"))
bind(mod .. " + SHIFT + Q", exec("qs -c noctalia-shell ipc call sessionMenu toggle"))
bind(mod .. " + E", exec(file_manager))
bind(mod .. " + F1", exec("nirimod"))

-- Media and brightness
bind("XF86AudioRaiseVolume", exec("qs -c noctalia-shell ipc call volume increase"), { locked = true, repeating = true })
bind("XF86AudioLowerVolume", exec("qs -c noctalia-shell ipc call volume decrease"), { locked = true, repeating = true })
bind("XF86AudioMute", exec("qs -c noctalia-shell ipc call volume muteOutput"), { locked = true })
bind("XF86AudioMicMute", exec("qs -c noctalia-shell ipc call volume muteInput"), { locked = true })
bind("XF86AudioNext", exec("qs -c noctalia-shell ipc call media next"), { locked = true })
bind("XF86AudioPrev", exec("qs -c noctalia-shell ipc call media previous"), { locked = true })
bind("XF86AudioPlay", exec("qs -c noctalia-shell ipc call media playPause"), { locked = true })
bind("XF86AudioPause", exec("qs -c noctalia-shell ipc call media playPause"), { locked = true })
bind("XF86MonBrightnessUp", exec("qs -c noctalia-shell ipc call brightness increase"),
  { locked = true, repeating = true })
bind("XF86MonBrightnessDown", exec("qs -c noctalia-shell ipc call brightness decrease"),
  { locked = true, repeating = true })

-- Focus and movement
bind(mod .. " + Q", hl.dsp.window.close())
bind(mod .. " + LEFT", layout("focus l"))
bind(mod .. " + RIGHT", layout("focus r"))
bind(mod .. " + UP", hl.dsp.focus({ direction = "u" }))
bind(mod .. " + DOWN", hl.dsp.focus({ direction = "d" }))
bind(mod .. " + CTRL + LEFT", layout("movewindowto l"))
bind(mod .. " + CTRL + RIGHT", layout("movewindowto r"))
bind(mod .. " + CTRL + UP", layout("movewindowto u"))
bind(mod .. " + CTRL + DOWN", layout("movewindowto d"))
bind(mod .. " + HOME", layout("fit tobeg"))
bind(mod .. " + END", layout("fit toend"))
bind(mod .. " + SHIFT + LEFT", hl.dsp.focus({ monitor = "l" }))
bind(mod .. " + SHIFT + RIGHT", hl.dsp.focus({ monitor = "r" }))
bind(mod .. " + SHIFT + UP", hl.dsp.focus({ monitor = "u" }))
bind(mod .. " + SHIFT + DOWN", hl.dsp.focus({ monitor = "d" }))
bind(mod .. " + SHIFT + CTRL + LEFT", hl.dsp.window.move({ monitor = "l" }))
bind(mod .. " + SHIFT + CTRL + RIGHT", hl.dsp.window.move({ monitor = "r" }))
bind(mod .. " + SHIFT + CTRL + UP", hl.dsp.window.move({ monitor = "u" }))
bind(mod .. " + SHIFT + CTRL + DOWN", hl.dsp.window.move({ monitor = "d" }))
bind(mod .. " + SHIFT + G", hl.dsp.window.move({ monitor = "HDMI-A-1" }))

-- Workspaces
for i = 1, 9 do
  bind(mod .. " + " .. i, hl.dsp.focus({ workspace = tostring(i) }))
  bind(mod .. " + CTRL + " .. i, hl.dsp.window.move({ workspace = tostring(i) }))
end
bind(mod .. " + TAB", hl.dsp.focus({ workspace = "previous" }))
bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
bind(mod .. " + CTRL + mouse_down", layout("movecoltoworkspace e+1"))
bind(mod .. " + CTRL + mouse_up", layout("movecoltoworkspace e-1"))

-- Layout controls
bind(mod .. " + MINUS", layout("colresize -0.1"))
bind(mod .. " + EQUAL", layout("colresize +0.1"))
bind(mod .. " + SHIFT + MINUS", hl.dsp.window.resize({ x = 0, y = -80, relative = true }))
bind(mod .. " + SHIFT + EQUAL", hl.dsp.window.resize({ x = 0, y = 80, relative = true }))
bind(mod .. " + T", hl.dsp.window.float())
bind(mod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized" }))
bind(mod .. " + O", hl.dsp.focus({ workspace = "special:overview" }))
bind("CTRL + ALT + R", exec("hyprctl reload"))
bind("CTRL + ALT + DELETE", hl.dsp.exit())

-- Screenshots
bind(mod .. " + SHIFT + D",
  exec(
  [[mkdir -p ~/Pictures/Screenshots && grim -g "$(slurp)" -t ppm - | satty --filename - --fullscreen --copy-command wl-copy --output-filename "$HOME/Pictures/Screenshots/screenshot-$(date '+%Y%m%d-%H%M%S').png"]]))
bind(mod .. " + SHIFT + S", exec([[grim -g "$(slurp)" - | wl-copy]]))

-- Mouse window controls
bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Window rules
hl.window_rule({ match = { class = "^(gw2-64.exe)$" }, tag = "+game" })
hl.window_rule({ match = { class = "^(gw2-64.exe)$" }, workspace = "2 silent" })
hl.window_rule({ match = { class = "^(gw2-64.exe)$" }, monitor = "HDMI-A-1" })
hl.window_rule({ match = { class = "^(gw2-64.exe)$" }, fullscreen = true })
hl.window_rule({ match = { class = "^(com.heroicgameslauncher.hgl)$" }, monitor = "HDMI-A-1" })
hl.window_rule({ match = { class = "^(steam)$", title = "negative:^(Steam)$" }, float = true })
hl.window_rule({ match = { class = "^(steam)$", title = "^(notificationtoasts_[0-9]+_desktop)$" }, no_initial_focus = true })
