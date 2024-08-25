return {
	-- defaultplus
	{
		"joaok-dev/defaultplus",
		-- lazy = false,
		-- priority = 1000,
		name = "defaultplus",
		config = function()
			-- vim.cmd.colorscheme("defaultplus")
		end,
	},
	-- tokyonight
	{
		"folke/tokyonight.nvim",
		lazy = false,
		opts = function()
			return {
				style = "night",
				on_highlights = function(hl, c)
					-- Customize Telescope highlights
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
	-- vscode
	{
		"Mofiqul/vscode.nvim",
		-- lazy = false,
		priority = 1000,
		opts = function()
			return {
				transparent = false,
				italic_comments = true,
				underline_links = true,
				disable_nvimtree_bg = true,
				group_overrides = {},
			}
		end,
		config = function(_, opts)
			require("vscode").setup(opts)
			-- vim.cmd.colorscheme("vscode")
		end,
	},
}
