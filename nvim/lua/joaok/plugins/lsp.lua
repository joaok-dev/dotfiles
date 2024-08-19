local M = {}

M._keys = {
	{ "<leader>cl", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
	{ "gd", "<cmd>Lspsaga goto_definition<CR>", desc = "Goto Definition" },
	{ "gr", "<cmd>Lspsaga finder<CR>", desc = "References" },
	{ "gI", "<cmd>Lspsaga finder imp<CR>", desc = "Goto Implementation" },
	{ "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" }, -- Lspsaga doesn't have a direct equivalent
	{ "K", "<cmd>Lspsaga hover_doc<CR>", desc = "Hover" },
	{ "gK", "<cmd>Lspsaga hover_doc ++keep<CR>", desc = "Signature Help" },
	{ "<leader>ca", "<cmd>Lspsaga code_action<CR>", desc = "Code Action", mode = { "n", "v" } },
	{ "<leader>cp", "<cmd>Lspsaga peek_definition<CR>", desc = "Peek Definition" },
	{ "<leader>ci", "<cmd>Lspsaga incoming_calls<CR>", desc = "Incoming Calls" },
	{ "<leader>co", "<cmd>Lspsaga outgoing_calls<CR>", desc = "Outgoing Calls" },
	{ "<leader>cr", "<cmd>Lspsaga rename<CR>", desc = "Rename" },
	{ "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", desc = "Cursor Diagnostics" },
	{ "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", desc = "Previous Diagnostic" },
	{ "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", desc = "Next Diagnostic" },
	{ "<leader>cl", "<cmd>Lspsaga show_line_diagnostics<CR>", desc = "Line Diagnostics" },
	{ "<leader>cw", "<cmd>Lspsaga show_workspace_diagnostics<CR>", desc = "Workspace Diagnostics" },
	{ "<leader>co", "<cmd>Lspsaga outline<CR>", desc = "Code Outline" },
}

-- Function to set up keymaps
local function setup_keymaps(client, bufnr)
	for _, map in ipairs(M._keys) do
		local lhs, rhs, opts = map[1], map[2], { buffer = bufnr, desc = map.desc }

		-- Remove mode from opts if it exists
		local mode = map.mode or "n"
		opts.mode = nil

		vim.keymap.set(mode, lhs, rhs, opts)
	end
end

-- Main LSP configuration
return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	opts = function()
		return {
			diagnostics = {
				virtual_text = true,
				virtual_lines = false,
				severity_sort = true,
				float = {
					focusable = false,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			},
		}
	end,
	config = function(_, opts)
		local lspconfig = require("lspconfig")
		local cmp_lsp = require("cmp_nvim_lsp")

		-- Apply diagnostic settings
		vim.diagnostic.config(opts.diagnostics)

		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		require("mason").setup()
		-- Setup mason-tool-installer
		require("mason-tool-installer").setup({
			ensure_installed = {
				-- LSP
				"lua_ls",
				-- Linter
				"luacheck",
				-- Formatter
				"stylua",
				-- DAP
				-- Add DAP tools here if needed
			},
		})

		-- Create an autocmd to set up keymaps when an LSP attaches
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local client = vim.lsp.get_client_by_id(ev.data.client_id)
				local bufnr = ev.buf
				setup_keymaps(client, bufnr)
			end,
		})

		require("mason-lspconfig").setup_handlers({
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,

			["lua_ls"] = function()
				lspconfig.lua_ls.setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							runtime = { version = "Lua 5.1" },
							diagnostics = {
								globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
							},
						},
					},
				})
			end,
		})
	end,
}
