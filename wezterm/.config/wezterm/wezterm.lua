local wezterm = require("wezterm")
local act = wezterm.action

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.color_scheme = "Kanagawa (Gogh)"
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.window_close_confirmation = "NeverPrompt"

config.keys = {
	{ key = "LeftArrow", mods = "CTRL | SHIFT", action = act.ActivateTabRelative(-1) },
	{ key = "RightArrow", mods = "CTRL | SHIFT", action = act.ActivateTabRelative(1) },
}

config.window_padding = {
	left = 5,
	right = 5,
	top = 0,
	bottom = 0,
}

config.font = wezterm.font("Consolas")

return config
