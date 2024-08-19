return {
	-- Autocomplete
	{
		"hrsh7th/nvim-cmp",
		version = false,
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			{
				"garymjr/nvim-snippets",
				opts = { friendly_snippets = true },
				dependencies = { "rafamadriz/friendly-snippets" },
			},
			"saadparwaiz1/cmp_luasnip",
		},
		opts = function()
			-- Set up custom highlight for ghost text
			vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

			local cmp = require("cmp")

			return {
				-- Completion settings
				completion = {
					completeopt = "menu,menuone,noinsert,noselect",
				},

				-- Set autoselect to false to require explicit selection
				preselect = cmp.PreselectMode.None,

				-- Key mappings
				mapping = cmp.mapping.preset.insert({
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-y>"] = JoaoK.confirm({ select = true }),
					["<CR>"] = JoaoK.confirm({ select = true }),
				}),

				-- Sources for autocompletion
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" }, -- Add luasnip source
					{ name = "path" },
					{ name = "buffer" },
				}),

				-- Customize appearance of completion items
				formatting = {
					format = function(entry, item)
						local icons = JoaoK.icons.kind
						if icons[item.kind] then
							item.kind = icons[item.kind] .. item.kind
						end

						-- Truncate completion item text if it's too long
						local widths = {
							abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
							menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
						}

						for key, width in pairs(widths) do
							if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
								item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
							end
						end

						return item
					end,
				},

				-- Window appearance
				window = {
					completion = {
						border = "rounded",
						winhighlight = "Normal:Pmenu,CursorLine:PmenuSel,FloatBorder:FloatBorder,Search:None",
						col_offset = -3,
						side_padding = 1,
						scrollbar = false,
						scrolloff = 8,
					},
					documentation = {
						border = "rounded",
						winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,Search:None",
					},
				},

				-- Experimental features
				experimental = {
					ghost_text = {
						hl_group = "CmpGhostText",
					},
				},
			}
		end,
	},
}
