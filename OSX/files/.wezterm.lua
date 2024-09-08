-- Load the WezTerm API
local wezterm = require("wezterm")

-- Create the configuration
local config = wezterm.config_builder()

-- Set the color scheme
config.color_scheme = "Monokai Pro (Gogh)"

-- Enable ligatures if supported by the font
-- config.harfbuzz_features = {"calt=1", "clig=1", "liga=1"}
config.harfbuzz_features = {}

config.font = wezterm.font_with_fallback({
	"Liga SFMono Nerd Font",
	"Noto Sans Symbols 2",  -- Add Noto Sans Symbols for digital figures
	"Symbols Nerd Font Mono"
  })
  config.font_size = 13
  config.font_size = 18

-- Configure cursor thickness and style
config.cursor_thickness = 1.0
config.default_cursor_style = "BlinkingBar"

-- Disable the tab bar
config.enable_tab_bar = false

-- Define keyboard shortcuts
config.keys = {
	{ key = "h", mods = "CMD", action = wezterm.action.HideApplication },
	{ key = "=", mods = "CTRL|SHIFT", action = "IncreaseFontSize" },
	{ key = "-", mods = "CTRL|SHIFT", action = "DecreaseFontSize" },
	{ key = "0", mods = "CTRL|SHIFT", action = "ResetFontSize" },
	{ key = "UpArrow", mods = "CMD", action = wezterm.action.ToggleFullScreen },
	{ key = "8", mods = "CTRL|SHIFT", action = wezterm.action.SendString("|") },
	{ key = "5", mods = "CTRL|SHIFT", action = wezterm.action.SendString("{") },
	{ key = "°", mods = "CTRL|SHIFT", action = wezterm.action.SendString("}") },
	{ key = "LeftArrow", mods = "CTRL", action = wezterm.action.SendKey{ key="b", mods="ALT" } },
	{ key = "RightArrow", mods = "CTRL", action = wezterm.action.SendKey{ key="f", mods="ALT" } },

-- Shortcuts for splitting the screen
    { key = "v", mods = "CMD|SHIFT", action = wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}} },
    { key = "h", mods = "CMD|SHIFT", action = wezterm.action{SplitVertical={domain="CurrentPaneDomain"}} },
}

-- Configure window appearance
config.window_decorations = "TITLE | RESIZE"
config.window_background_opacity = 0.8
config.macos_window_background_blur = 15

-- Set initial window size and position
config.initial_cols = 150
config.initial_rows = 50

-- Update the PATH to include the path to tmux
config.set_environment_variables = {
	PATH = "/usr/local/bin:/opt/homebrew/bin:" .. os.getenv("PATH"),  -- Add paths where tmux is installed
  }

-- Automatically launch tmux when WezTerm starts
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = wezterm.mux.spawn_window({
	  -- Launch Tmux in a session named "default" (or join the session if it exists)
	  args = {"tmux", "new-session", "-A", "-s", "default"}
	})
  
	-- Center the window slightly to the left with some margin
	window:gui_window():set_position(60, 100)  -- Slightly offset the window (x=60, y=100)
	window:gui_window():set_inner_size(1600, 1200)  -- Smaller width (1600px), reduced height (1200px)
  end)

-- Return the final configuration
return config