-- Define diagnostic signs
local diagnostic_signs = {
	Error = " ",
	Warn = " ",
	Hint = "",
	Info = "",
}

-- Define key mappings
local function map_key(mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

-- Main plugin configuration
return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		signs = {
			-- Icons / text used for diagnostics
			error = diagnostic_signs.Error,
			warning = diagnostic_signs.Warn,
			hint = diagnostic_signs.Hint,
			information = diagnostic_signs.Info,
			other = diagnostic_signs.Info,
		},
	},
	config = function()
		-- Load the plugin
		require("trouble").setup({})

		-- Map the keybindings with correct commands
		map_key("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", "Diagnostics (Trouble)")
		map_key("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", "Buffer Diagnostics (Trouble)")
		map_key("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", "Symbols (Trouble)")
		map_key(
			"n",
			"<leader>cl",
			"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
			"LSP Definitions / references / ... (Trouble)"
		)
		map_key("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", "Location List (Trouble)")
		map_key("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", "Quickfix List (Trouble)")
	end,
}
