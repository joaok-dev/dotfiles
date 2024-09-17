return {
	-- autocomplete
	{
		"hrsh7th/nvim-cmp",
		version = false,
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
		},
		opts = function()
			local cmp = require("cmp")
			local defaults = require("cmp.config.default")()
			local auto_select = true
			return {
				auto_brackets = {},
				completion = {
					completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
				},
				preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = auto_select }),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<S-CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace }),
					["<C-CR>"] = function(fallback)
						cmp.abort()
						fallback()
					end,
					["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
					["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "path" },
				}, {
					{ name = "buffer" },
				}),
				formatting = {
					format = function(_, item)
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
				sorting = defaults.sorting,
				view = {
					entries = {
						name = "custom",
						selection_order = "top_down",
					},
					docs = {
						auto_open = false,
					},
				},
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
			}
		end,
	},
	-- snippets
	{
		"nvim-cmp",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				version = "v2.*",
				build = "make install_jsregexp",
			},
		},
		opts = function(_, opts)
			local luasnip = require("luasnip")
			opts.snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			}
			table.insert(opts.sources, { name = "luasnip" })
		end,
		config = function(_, opts)
			local cmp = require("cmp")
			cmp.setup(opts)
		end,
		keys = {
			{
				"<Tab>",
				function()
					return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<Tab>"
				end,
				expr = true,
				silent = true,
				mode = "i",
			},
			{
				"<Tab>",
				function()
					require("luasnip").jump(1)
				end,
				mode = "s",
			},
			{
				"<S-Tab>",
				function()
					require("luasnip").jump(-1)
				end,
				mode = { "i", "s" },
			},
		},
	},
}
