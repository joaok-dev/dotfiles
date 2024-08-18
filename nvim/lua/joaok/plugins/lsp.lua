return {
	-- LSP Config
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason.nvim",
			{ "williamboman/mason-lspconfig.nvim", config = function() end },
		},
		opts = function()
			local icons = JoaoK.icons
			-- LSP configuration options
			local ret = {
				-- Diagnostic settings
				diagnostics = {
					virtual_text = true,
					severity_sort = true,
					signs = {
						text = {
							[vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
							[vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
							[vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
							[vim.diagnostic.severity.INFO] = icons.diagnostics.Information,
						},
					},
					float = {
						focusable = true,
						style = "minimal",
						border = "rounded",
						header = "",
						prefix = "",
					},
				},

				-- Inlay hints settings
				inlay_hints = {
					enabled = false,
					exclude = {}, -- filetypes for which you don't want to enable inlay hints
				},

				-- Code lens settings
				codelens = {
					enabled = false,
				},

				-- Document highlight settings
				document_highlight = {
					enabled = true,
				},

				-- Global capabilities
				capabilities = {
					workspace = {
						fileOperations = {
							didRename = true,
							willRename = true,
						},
					},
				},

				-- Formatting options
				format = {
					formatting_options = nil,
					timeout_ms = nil,
				},

				-- LSP Server Settings
				servers = {
					lua_ls = {
						settings = {
							Lua = {
								workspace = {
									checkThirdParty = false,
								},
								diagnostics = {
									globals = { "vim", "spec" },
								},
								completion = {
									callSnippet = "Replace",
								},
								doc = {
									privateName = { "^_" },
								},
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
				},

				-- Custom server setup
				setup = {
					-- Add custom server setups here
					-- Example:
					-- tsserver = function(_, opts)
					--   require("typescript").setup({ server = opts })
					--   return true
					-- end,
				},
			}
			return ret
		end,
		config = function(_, opts)
			-- Setup mason.nvim
			require("mason").setup()

			-- Setup mason-lspconfig
			local have_mason, mlsp = pcall(require, "mason-lspconfig")
			if have_mason then
				mlsp.setup({
					ensure_installed = vim.tbl_deep_extend(
						"force",
						{},
						JoaoK.opts("mason-lspconfig.nvim").ensure_installed or {}
					),
				})
			end

			-- Setup autoformat
			JoaoK.formatter()

			-- Setup keymaps
			JoaoK.on_attach(function(client, buffer)
				JoaoK.lsp_keymaps.on_attach(client, buffer)
			end)

			-- Setup LSP
			JoaoK.lsp_setup()
			JoaoK.on_dynamic_capability(JoaoK.lsp_keymaps.on_attach)

			-- Setup diagnostic signs
			JoaoK.setup_signs(opts.diagnostics)

			-- Setup inlay hints
			if vim.fn.has("nvim-0.10") == 1 then
				if opts.inlay_hints.enabled then
					JoaoK.on_supports_method("textDocument/inlayHint", function(client, buffer)
						if
							vim.api.nvim_buf_is_valid(buffer)
							and vim.bo[buffer].buftype == ""
							and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
						then
							-- Usando a função enable para ativar inlay hints no buffer específico
							vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
						end
					end)
				end
			end

			-- Setup code lens
			if opts.codelens.enabled and vim.lsp.codelens then
				JoaoK.on_supports_method("textDocument/codeLens", function(client, buffer)
					vim.lsp.codelens.refresh()
					vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
						buffer = buffer,
						callback = vim.lsp.codelens.refresh,
					})
				end)
			end

			-- Diagnostics Virtual Text Prefix
			if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
				opts.diagnostics.virtual_text.prefix = function(diagnostic)
					local icons = JoaoK.icons.diagnostics
					for d, icon in pairs(icons) do
						if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
							return icon
						end
					end
				end
			end

			-- Configure diagnostics with the provided options
			vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

			-- LSP Server Capabilities
			local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				has_cmp and cmp_nvim_lsp.default_capabilities() or {},
				opts.capabilities or {}
			)

			-- Function to setup each LSP server
			local function setup(server)
				local server_opts = vim.tbl_deep_extend("force", {
					capabilities = vim.deepcopy(capabilities),
				}, opts.servers[server] or {})
				if server_opts.enabled == false then
					return
				end

				if opts.setup[server] then
					if opts.setup[server](server, server_opts) then
						return
					end
				elseif opts.setup["*"] then
					if opts.setup["*"](server, server_opts) then
						return
					end
				end
				require("lspconfig")[server].setup(server_opts)
			end

			-- Get all the servers that are available through mason-lspconfig
			local all_mslp_servers = {}
			if have_mason then
				all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
			end

			local ensure_installed = {} ---@type string[]
			for server, server_opts in pairs(opts.servers) do
				if server_opts then
					server_opts = server_opts == true and {} or server_opts
					if server_opts.enabled ~= false then
						-- Run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
						if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
							setup(server)
						else
							ensure_installed[#ensure_installed + 1] = server
						end
					end
				end
			end

			if have_mason then
				mlsp.setup({
					ensure_installed = vim.tbl_deep_extend(
						"force",
						ensure_installed,
						JoaoK.opts("mason-lspconfig.nvim").ensure_installed or {}
					),
					handlers = { setup },
				})
			end
		end,
	},

	-- Mason: Manager for LSP, linters, formatters and DAP
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		build = ":MasonUpdate",
		opts_extend = { "ensure_installed" },
		opts = {
			ui = { border = "rounded" },
			ensure_installed = {
				-- LSP
				"stylua",
				"shfmt",

				-- Linter

				-- Formatter

				-- DAP
			},
		},
		config = function(_, opts) end,
	},
}
