-- List of languages to ensure are installed
local ensure_installed_languages = {
	"bash",
	"c",
	"cmake",
	"cpp",
	"css",
	"diff",
	"dockerfile",
	"go",
	"html",
	"http",
	"javascript",
	"jsdoc",
	"json",
	"jsonc",
	"just",
	"lua",
	"luadoc",
	"luap",
	"markdown",
	"markdown_inline",
	"php",
	"printf",
	"python",
	"query",
	"regex",
	"ruby",
	"rust",
	"scala",
	"scss",
	"sql",
	"svelte",
	"toml",
	"tsx",
	"typescript",
	"vim",
	"vimdoc",
	"vue",
	"xml",
	"yaml",
}

-- Shared textobjects configuration
local textobjects_config = {
	move = {
		enable = true,
		goto_next_start = {
			["]f"] = "@function.outer",
			["]c"] = "@class.outer",
			["]a"] = "@parameter.inner",
		},
		goto_next_end = {
			["]F"] = "@function.outer",
			["]C"] = "@class.outer",
			["]A"] = "@parameter.inner",
		},
		goto_previous_start = {
			["[f"] = "@function.outer",
			["[c"] = "@class.outer",
			["[a"] = "@parameter.inner",
		},
		goto_previous_end = {
			["[F"] = "@function.outer",
			["[C"] = "@class.outer",
			["[A"] = "@parameter.inner",
		},
	},
}

return {
	-- Treesitter: Parser generator tool for syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		version = false, -- Use the latest version
		build = ":TSUpdate",
		event = { "BufReadPre", "BufNewFile" },
		lazy = vim.fn.argc(-1) == 0,
		init = function(plugin)
			-- Add the plugin to the runtime path
			require("lazy.core.loader").add_to_rtp(plugin)
			require("nvim-treesitter.query_predicates")
		end,
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		opts_extend = { "ensure_installed" }, -- Allows extending the ensure_installed list
		opts = {
			-- Enable syntax highlighting
			highlight = { enable = true },
			-- Enable indentation
			indent = { enable = true },
			-- Enable autopairs integration
			autopairs = { enable = true },
			-- List of parsers to install
			ensure_installed = ensure_installed_languages,
			-- Configuration for incremental selection
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
			-- Textobjects configuration
			textobjects = textobjects_config,
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},

	-- nvim-treesitter-textobjects: Advanced syntax-aware text objects
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = { "BufReadPre", "BufNewFile" },
		enabled = true,
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function() end,
	},
}
