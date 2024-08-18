return {
	-- Which-key
	-- Popup displays keybindings for your started command.
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts_extend = { "spec" },
	opts = {
		defaults = {},
		preset = "helix",
		plugins = {
			-- presets = {
			--   operators = false,
			--   motions = false,
			--   text_objects = false,
			--   windows = false,
			--   nav = false,
			--   z = false,
			--   g = false,
			-- },
		},
		win = {
			border = "rounded",
			no_overlap = false,
			title = false,
		},
		-- show_help = false,
		-- show_keys = false,
		disable = {
			-- ft = { "TelescopePrompt" },
		},
		spec = {
			{
				mode = { "n", "v" },
				{ "<leader>f", group = "file/find" },
				{ "<leader>q", group = "quit/session" },
				{ "<leader>c", group = "code" },
				{ "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
			},
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
	end,
}
