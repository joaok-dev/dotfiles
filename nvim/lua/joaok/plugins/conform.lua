return {
	{
		"stevearc/conform.nvim",
		dependencies = { "mason.nvim" },
		lazy = true,
		cmd = "ConformInfo",
				opts = {
			default_format_opts = {
				timeout_ms = 3000,
				async = false, -- not recommended to change
				quiet = false, -- not recommended to change
				lsp_format = "fallback", -- not recommended to change
			},
			formatters_by_ft = {
				lua = { "stylua" },
				c = { "c_formattter_42" },
				python = { "ruff_format" },
			},
			formatters = {
				c_formattter_42 = {
					command = "/Users/joaok/.asdf/installs/python/3.12.4/bin/c_formatter_42",
					args = {},
					stdin = true,
					stdout = true,
					tempfile_postfix = ".c",
				},
				injected = { options = { ignore_errors = true } },
			},
		},
		config = function(_, opts)
			require("conform").setup(opts)
		end,
	},
}

