return {
	-- Mason and related plugins
	{
		"williamboman/mason.nvim",
		dependencies = {
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		build = ":MasonUpdate",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
		config = function(_, opts)
			require("mason").setup(opts)

			require("mason-tool-installer").setup({
				ensure_installed = {
					"luacheck",
					"stylua",
					"pyright",
					"ruff",
					"ruff-lsp",
				},
				auto_update = true,
				run_on_start = true,
			})
		end,
	},

	-- LSP Configuration
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		dependencies = {
			{ "j-hui/fidget.nvim", opts = {} },
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			local icons = {
				Error = " ",
				Warning = " ",
				Hint = "󰌶",
				Information = " ",
			}

			vim.diagnostic.config({
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = icons.Error,
						[vim.diagnostic.severity.WARN] = icons.Warning,
						[vim.diagnostic.severity.HINT] = icons.Hint,
						[vim.diagnostic.severity.INFO] = icons.Information,
					},
				},
				virtual_text = true,
				update_in_insert = false,
				underline = true,
				severity_sort = true,
				float = {
					focusable = true,
					style = "minimal",
					border = "rounded",
					header = "",
					prefix = "",
				},
			})

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
			vim.lsp.handlers["textDocument/signatureHelp"] =
				vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
			require("lspconfig.ui.windows").default_options.border = "rounded"

			local function common_capabilities()
				local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
				if status_ok then
					return cmp_nvim_lsp.default_capabilities()
				end
				local capabilities = vim.lsp.protocol.make_client_capabilities()
				capabilities.textDocument.completion.completionItem.snippetSupport = true
				capabilities.textDocument.completion.completionItem.resolveSupport = {
					properties = {
						"documentation",
						"detail",
						"additionalTextEdits",
					},
				}
				capabilities.textDocument.foldingRange = {
					dynamicRegistration = false,
					lineFoldingOnly = true,
				}
				return capabilities
			end

			local capabilities = common_capabilities()

			-- LSP servers configuration
			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							workspace = { checkThirdParty = false },
							completion = { callSnippet = "Replace" },
						},
					},
				},
				pyright = {
					settings = {
						python = {
							analysis = {
								autoSearchPaths = true,
								diagnosticMode = "workspace",
								useLibraryCodeForTypes = true,
								typeCheckingMode = "basic",
							},
						},
					},
				},
				ruff_lsp = {
					on_attach = function(client, bufnr)
						-- Disable hover in favor of Pyright
						client.server_capabilities.hoverProvider = false
					end,
				},
				-- Add other servers here
			}

			-- LSP attach function
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
				callback = function(event)
					local bufnr = event.buf
					local client = vim.lsp.get_client_by_id(event.data.client_id)

					-- Keymaps
					vim.keymap.set("n", "<leader>cl", "<cmd>LspInfo<cr>", { desc = "Lsp Info", buffer = bufnr })
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Goto Definition", buffer = bufnr })
					vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "References", buffer = bufnr })
					vim.keymap.set(
						"n",
						"gI",
						vim.lsp.buf.implementation,
						{ desc = "Goto Implementation", buffer = bufnr }
					)
					vim.keymap.set(
						"n",
						"gy",
						vim.lsp.buf.type_definition,
						{ desc = "Goto T[y]pe Definition", buffer = bufnr }
					)
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration", buffer = bufnr })
					vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover", buffer = bufnr })
					vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, { desc = "Signature Help", buffer = bufnr })
					vim.keymap.set(
						"i",
						"<c-k>",
						vim.lsp.buf.signature_help,
						{ desc = "Signature Help", buffer = bufnr }
					)
					vim.keymap.set(
						{ "n", "v" },
						"<leader>ca",
						vim.lsp.buf.code_action,
						{ desc = "Code Action", buffer = bufnr }
					)
					vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename", buffer = bufnr })
				end,
			})

			-- Setup servers
			local lspconfig = require("lspconfig")
			local mlsp = require("mason-lspconfig")

			mlsp.setup({
				ensure_installed = {
					"lua_ls",
					"pyright",
					"ruff_lsp",

					-- Add other LSP servers here
				},
				automatic_installation = true,
			})

			mlsp.setup_handlers({
				function(server_name)
					local config = servers[server_name] or {}
					config.capabilities = capabilities
					lspconfig[server_name].setup(config)
				end,
			})
		end,
	},

	-- LazyDev and Luvit
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true },
}
