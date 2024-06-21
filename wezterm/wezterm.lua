local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

local fonts = {
  "MonaspiceNe Nerd Font",
	"Monaspace Neon",
	"Monaspace Xenon",
	"Monaspace Krypton",
	"Monaspace Radon",
	"Monaspace Argon",
}
local emoji_fonts = { 
	"Apple Color Emoji", 
	"Joypixels", 
	"Twemoji", 
	"Noto Color Emoji", 
	"Noto Emoji" 
}

config.color_scheme = 'tokyonight_night'
config.window_padding = {
	left = 16,
	right = 16,
	top = 12,
	bottom = 12,
}
config.font = wezterm.font_with_fallback({ fonts[1], emoji_fonts[1], emoji_fonts[2] })
config.font_size = 12 
config.scrollback_lines = 10240
-- config.hide_tab_bar_if_only_one_tab = true 
config.default_cursor_style = "BlinkingBar"

return config
