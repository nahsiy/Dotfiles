local wezterm = require("wezterm")
local config = wezterm.config_builder()
config.color_scheme = "Tokyo Night"
config.font = wezterm.font_with_fallback({ "JetBrainsMono Nerd Font", "monospace" })
config.font_size = 14
config.default_cursor_style = "BlinkingBar"
config.window_background_opacity = 0.95
config.initial_cols = 120
config.initial_rows = 35
config.scrollback_lines = 10000
config.keys = {
  { key = "|", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "_", mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
}
-- Le shell habituel démarre ; tmux se lance explicitement.
return config
