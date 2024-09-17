return {
	-- tokyonight
	{
		"folke/tokyonight.nvim",
		lazy = false,
		opts = function()
			return {
				style = "night",
				on_highlights = function(hl, c)
					local prompt = "#2d3149"
					hl.TelescopeNormal = { bg = c.bg_dark, fg = c.fg }
					hl.TelescopeBorder = { bg = c.bg_dark, fg = c.bg_dark }
					hl.TelescopePromptNormal = { bg = prompt }
					hl.TelescopePromptBorder = { bg = prompt, fg = prompt }
					hl.TelescopePromptTitle = { bg = c.fg_gutter, fg = c.orange }
					hl.TelescopePreviewTitle = { bg = c.bg_dark, fg = c.bg_dark }
					hl.TelescopeResultsTitle = { bg = c.bg_dark, fg = c.bg_dark }
				end,
			}
		end,
		config = function(_, opts)
			require("tokyonight").setup(opts)
			vim.cmd.colorscheme("tokyonight")
		end,
	},
}
