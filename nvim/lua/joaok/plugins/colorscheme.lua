return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("tokyonight").setup({
			style = "night",
			on_highlights = function(hl, colors)
				hl.Comment = { fg = "#6974a8" }
			end,
		})
		vim.cmd([[colorscheme tokyonight]])
	end,
}
