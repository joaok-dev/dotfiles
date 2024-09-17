local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- general
config.enable_wayland = true
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.scrollback_lines = 10000

-- window and tab
-- config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.enable_tab_bar = false
if wezterm.target_triple:find("darwin") then
	config.window_decorations = "RESIZE"
else
	config.term = "wezterm"
	config.window_decorations = "NONE"
end

-- font
config.font_size = 11
config.font = wezterm.font({ family = "FiraCode" })
config.font_rules = {
	{
		intensity = "Bold",
		italic = true,
		font = wezterm.font({ family = "Maple Mono", weight = "Bold", style = "Italic" }),
	},
	{
		italic = true,
		intensity = "Half",
		font = wezterm.font({ family = "Maple Mono", weight = "DemiBold", style = "Italic" }),
	},
	{
		italic = true,
		intensity = "Normal",
		font = wezterm.font({ family = "Maple Mono", style = "Italic" }),
	},
}

-- cursor
config.default_cursor_style = "BlinkingBar"
config.force_reverse_video_cursor = true

-- colorscheme
config.color_scheme = "tokyonight_night"

return config
