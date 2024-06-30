-- Mason Configuration
return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- Imports
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		-- Mason setup configuration
		local mason_setup = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		}

		-- Mason-lspconfig setup to ensure LSP servers are installed
		local mason_lspconfig_setup = {
			ensure_installed = {
				"lua_ls", -- Lua language server
			},
		}

		-- Mason-tool-installer setup to ensure formatters, linters, and DAPs are installed
		local mason_tool_installer_setup = {
			ensure_installed = {
				"stylua", -- Lua formatter
				"shfmt", -- Shell script formatter
				"shellcheck", -- Shell script linter
			},
		}

		mason.setup(mason_setup)
		mason_lspconfig.setup(mason_lspconfig_setup)
		mason_tool_installer.setup(mason_tool_installer_setup)
	end,
}
