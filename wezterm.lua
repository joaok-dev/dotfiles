local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.enable_wayland = true
config.webgpu_power_preference = "HighPerformance"

-- config.color_scheme = "tokyonight_night"
config.color_scheme = "Dark+"

config.window_decorations = "NONE"
config.enable_tab_bar = false

config.window_padding = {
	left = 16,
	right = 16,
	top = 12,
	bottom = 12,
}

config.scrollback_lines = 10240

config.font_size = 11
config.font = wezterm.font("MonaspiceNe Nerd Font")
config.bold_brightens_ansi_colors = true
config.font_rules = {
	{
		intensity = "Bold",
		italic = true,
		font = wezterm.font({
			family = "Maple Mono",
			weight = "Bold",
			style = "Italic",
		}),
	},
	{
		italic = true,
		intensity = "Half",
		font = wezterm.font({
			family = "Maple Mono",
			weight = "DemiBold",
			style = "Italic",
		}),
	},
	{
		italic = true,
		intensity = "Normal",
		font = wezterm.font({
			family = "Maple Mono",
			style = "Italic",
		}),
	},
}

config.default_cursor_style = "SteadyBlock"

return config
