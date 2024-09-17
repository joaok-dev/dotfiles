return {
	-- mason
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
			ensure_installed = {
				"stylua",
				"luacheck",
				-- add other tools here
			},
		},
		config = function(_, opts)
			local mason = require("mason")
			mason.setup(opts)

			local mr = require("mason-registry")
			mr.refresh(function()
				for _, tool in ipairs(opts.ensure_installed) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end)
		end,
	},

	-- lsp configuration
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		dependencies = {
			{ "j-hui/fidget.nvim", opts = {} },
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			-- centralized lsp options
			local opts = {
				diagnostics = {
					underline = true,
					update_in_insert = false,
					virtual_text = {
						spacing = 4,
						source = "if_many",
						prefix = "●",
					},
					severity_sort = true,
					signs = {
						text = {
							[vim.diagnostic.severity.ERROR] = " ",
							[vim.diagnostic.severity.WARN] = " ",
							[vim.diagnostic.severity.HINT] = "󰌶 ",
							[vim.diagnostic.severity.INFO] = " ",
						},
					},
				},
				inlay_hints = {
					enabled = false,
					exclude = {},
				},
				codelens = {
					enabled = false,
				},
				document_highlight = {
					enabled = false,
				},
				capabilities = {},
				servers = {
					lua_ls = {
						settings = {
							Lua = {
								workspace = { checkThirdParty = false },
								completion = { callSnippet = "Replace" },
								hint = {
									enable = true,
									setType = false,
									paramType = true,
									paramName = "Disable",
									semicolon = "Disable",
									arrayIndex = "Disable",
								},
							},
						},
					},
					-- add other servers here
				},
			}

			-- diagnostic signs
			for type, icon in pairs(opts.diagnostics.signs.text) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

			vim.diagnostic.config(opts.diagnostics)

			-- capabilities
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
			if ok then
				capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
			end
			capabilities.workspace = {
				fileOperations = {
					didRename = true,
					willRename = true,
				},
			}
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}
			opts.capabilities = capabilities

			-- lsp handlers
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
			vim.lsp.handlers["textDocument/signatureHelp"] =
				vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
			require("lspconfig.ui.windows").default_options.border = "rounded"

			-- inlay hints and code lens
			if vim.fn.has("nvim-0.10.0") == 1 then
				-- inlay hints
				if opts.inlay_hints.enabled then
					vim.api.nvim_create_autocmd("LspAttach", {
						group = vim.api.nvim_create_augroup("LspInlayHints", {}),
						callback = function(args)
							local client = vim.lsp.get_client_by_id(args.data.client_id)
							local bufnr = args.buf
							if
								client.server_capabilities.inlayHintProvider
								and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[bufnr].filetype)
							then
								vim.lsp.inlay_hint(bufnr, true)
							end
						end,
					})
				end

				-- code lens
				if opts.codelens.enabled then
					vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
						group = vim.api.nvim_create_augroup("LspCodeLens", {}),
						callback = function()
							vim.lsp.codelens.refresh()
						end,
					})
				end
			end

			-- document highlighting
			if opts.document_highlight.enabled then
				vim.api.nvim_create_autocmd("LspAttach", {
					group = vim.api.nvim_create_augroup("LspDocumentHighlight", {}),
					callback = function(args)
						local client = vim.lsp.get_client_by_id(args.data.client_id)
						if client.server_capabilities.documentHighlightProvider then
							local bufnr = args.buf
							vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
								group = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = true }),
								buffer = bufnr,
								callback = vim.lsp.buf.document_highlight,
							})
							vim.api.nvim_create_autocmd("CursorMoved", {
								group = vim.api.nvim_create_augroup("LspDocumentHighlightClear", { clear = true }),
								buffer = bufnr,
								callback = vim.lsp.buf.clear_references,
							})
						end
					end,
				})
			end

			-- lsp attach function
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
				callback = function(event)
					local bufnr = event.buf

					-- keymaps
					local telescope = require("telescope.builtin")
					vim.keymap.set("n", "gd", function()
						telescope.lsp_definitions({ reuse_win = true })
					end, { desc = "Goto Definition", buffer = bufnr })
					vim.keymap.set(
						"n",
						"gr",
						"<cmd>Telescope lsp_references<cr>",
						{ desc = "References", buffer = bufnr }
					)
					vim.keymap.set("n", "gI", function()
						telescope.lsp_implementations({ reuse_win = true })
					end, { desc = "Goto Implementation", buffer = bufnr })
					vim.keymap.set("n", "gy", function()
						telescope.lsp_type_definitions({ reuse_win = true })
					end, { desc = "Goto Type Definition", buffer = bufnr })

					-- other lsp keymaps
					vim.keymap.set("n", "<leader>cl", "<cmd>LspInfo<cr>", { desc = "LSP Info", buffer = bufnr })
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

			-- setup servers
			local lspconfig = require("lspconfig")
			local mlsp = require("mason-lspconfig")

			local servers = opts.servers
			local ensure_installed = {}

			for server, _ in pairs(servers) do
				ensure_installed[#ensure_installed + 1] = server
			end

			-- setup mason-lspconfig
			mlsp.setup({
				ensure_installed = ensure_installed,
				automatic_installation = true,
			})

			-- setup servers
			mlsp.setup_handlers({
				function(server_name)
					local server_opts = servers[server_name] or {}
					server_opts.capabilities = opts.capabilities
					require("lspconfig")[server_name].setup(server_opts)
				end,
			})
		end,
	},
}
