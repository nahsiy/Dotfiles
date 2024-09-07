-- Charger l'API WezTerm
local wezterm = require("wezterm")

-- Créer la configuration
local config = wezterm.config_builder()

-- Définir le schéma de couleurs
config.color_scheme = "Monokai Pro (Gogh)"

-- Activer les ligatures si supportées par la police
-- config.harfbuzz_features = {"calt=1", "clig=1", "liga=1"}
config.harfbuzz_features = {}

config.font = wezterm.font_with_fallback({
	"Liga SFMono Nerd Font",
	"Noto Sans Symbols 2",  -- Ajoute Noto Sans Symbols pour les chiffres digitaux
	"Symbols Nerd Font Mono"
  })
  config.font_size = 13
  config.font_size = 18

-- Configurer l'épaisseur et le style du curseur
config.cursor_thickness = 1.0
config.default_cursor_style = "BlinkingBar"

-- Désactiver la barre d'onglets
config.enable_tab_bar = false

-- Définir les raccourcis clavier
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

-- Raccourcis pour diviser l'écran
    { key = "v", mods = "CMD|SHIFT", action = wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}} },
    { key = "h", mods = "CMD|SHIFT", action = wezterm.action{SplitVertical={domain="CurrentPaneDomain"}} },
}

-- Configurer l'apparence de la fenêtre
config.window_decorations = "TITLE | RESIZE"
config.window_background_opacity = 0.8
config.macos_window_background_blur = 15

-- Définir la taille et la position initiales de la fenêtre
config.initial_cols = 150
config.initial_rows = 50

-- Mettre à jour le PATH pour inclure le chemin vers tmux
config.set_environment_variables = {
	PATH = "/usr/local/bin:/opt/homebrew/bin:" .. os.getenv("PATH"),  -- Ajoute les chemins où tmux est installé
  }

-- Lancer automatiquement tmux lors de l'ouverture de WezTerm
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = wezterm.mux.spawn_window({
	  -- Lancer Tmux dans une session nommée "default" (ou rejoindre la session si elle existe)
	  args = {"tmux", "new-session", "-A", "-s", "default"}
	})
  
	-- Centrer la fenêtre à gauche avec un peu de marge
	window:gui_window():set_position(60, 100)  -- Décale légèrement la fenêtre vers l'intérieur (x=60, y=100)
	window:gui_window():set_inner_size(1600, 1200)  -- Largeur plus petite (1600px), Hauteur réduite (1200px)
  end)

-- Retourner la configuration finale
return config