-- Key mappings for LSP actions
local function lsp_keymaps(bufnr)
	local keymap = vim.keymap
	local opts = { buffer = bufnr, silent = true }

	opts.desc = "Find LSP definition"
	keymap.set("n", "<leader>fd", "<cmd>Lspsaga finder<CR>", opts) -- find definition

	opts.desc = "Peek LSP definition"
	keymap.set("n", "<leader>gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- peek definition

	opts.desc = "Go to LSP definition"
	keymap.set("n", "<leader>gD", "<cmd>Lspsaga goto_definition<CR>", opts) -- go to definition

	opts.desc = "See available code actions"
	keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions

	opts.desc = "Smart rename"
	keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename

	opts.desc = "Show line diagnostics"
	keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show diagnostics for line

	opts.desc = "Show cursor diagnostics"
	keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor

	opts.desc = "Jump to previous diagnostic"
	keymap.set("n", "<leader>pd", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to prev diagnostic in buffer

	opts.desc = "Jump to next diagnostic"
	keymap.set("n", "<leader>nd", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer

	opts.desc = "Show documentation for what is under cursor"
	keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
end

-- Define diagnostic symbols
local function define_diagnostic_signs()
	local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end
end

-- Configuration function
local config = function()
	local lspconfig = require("lspconfig")
	local mason_lspconfig = require("mason-lspconfig")
	local cmp_nvim_lsp = require("cmp_nvim_lsp")

	-- Setup autocommands for LSP
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("UserLspConfig", {}),
		callback = function(ev)
			lsp_keymaps(ev.buf)
		end,
	})

	-- Enable autocompletion for every LSP server
	local capabilities = cmp_nvim_lsp.default_capabilities()

	-- Change Diagnostic symbols in the sign column (gutter)
	define_diagnostic_signs()

	-- Setup handlers for Mason LSPConfig
	mason_lspconfig.setup_handlers({
		-- Default handler for installed servers
		function(server_name)
			lspconfig[server_name].setup({
				capabilities = capabilities,
			})
		end,

		["lua_ls"] = function()
			-- Configure Lua language server with special settings
			lspconfig["lua_ls"].setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			})
		end,
	})
end

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = config,
}
