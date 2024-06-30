return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		-- Import conform
		local conform = require("conform")

		-- Configuration for conform
		local conform_setup = {
			formatters_by_ft = {
				lua = { "stylua" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			},
		}

		-- Setup conform with the defined configuration
		conform.setup(conform_setup)
	end,
}
