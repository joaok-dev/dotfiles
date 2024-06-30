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
		map_key("n", "<leader>xx", function()
			require("trouble").toggle()
		end, "Toggle Trouble")
		map_key("n", "<leader>xw", function()
			require("trouble").toggle("workspace_diagnostics")
		end, "Show Workspace Diagnostics")
		map_key("n", "<leader>xd", function()
			require("trouble").toggle("document_diagnostics")
		end, "Show Document Diagnostics")
		map_key("n", "<leader>xq", function()
			require("trouble").toggle("quickfix")
		end, "Toggle Quickfix List")
		map_key("n", "<leader>xl", function()
			require("trouble").toggle("loclist")
		end, "Toggle Location List")
		map_key("n", "gR", function()
			require("trouble").toggle("lsp_references")
		end, "Toggle LSP References")
	end,
}
