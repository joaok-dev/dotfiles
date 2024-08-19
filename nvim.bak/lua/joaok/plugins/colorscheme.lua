-- Set colorscheme
local function set_colorscheme()
	local colorscheme = "defaultplus" -- << Name of colorscheme <<
	vim.cmd.colorscheme(colorscheme)
end

return {
	-- Defaultplus
	{
		"ChristianChiarulli/defaultplus",
		lazy = false,
		priority = 1000,
	},

	-- Darkplus
	{ "lunarvim/darkplus.nvim" },

	-- Tokyonight
	{
		"folke/tokyonight.nvim",
		opts = { style = "night" },
	},

	-- Set the colorscheme after plugins are loaded
	config = function()
		vim.schedule(set_colorscheme)
	end,
}
