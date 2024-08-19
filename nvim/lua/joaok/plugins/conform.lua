return {
	-- Formatter
	"stevearc/conform.nvim",
	dependencies = { "mason.nvim" },
	lazy = true,
	cmd = "ConformInfo",
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({ timeout_ms = 1000 })
			end,
			mode = { "n", "v" },
			desc = "Format Injected Langs",
		},
	},
	opts = function()
		return {
			formatters_by_ft = {
				lua = { "stylua" },
				sh = { "shfmt" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
		}
	end,
	config = function(_, opts)
		require("conform").setup(opts)
		require("mason-registry"):on("package:install:success", function()
			require("conform").setup(opts)
		end)
	end,
}
