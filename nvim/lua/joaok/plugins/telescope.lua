return {
	-- telescope: fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		version = false,
		dependencies = {
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-telescope/telescope-ui-select.nvim",
		},
		keys = {
			{
				"<leader>,",
				"<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
				desc = "Switch Buffer",
			},
			{ "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "buffer search" },
			{ "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "buffers" },
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files (Root Dir)" },
			{ "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Files (git-files)" },
			{
				"<leader>fc",
				function()
					local builtin = require("telescope.builtin")
					builtin.find_files({ cwd = vim.fn.stdpath("config") })
				end,
				desc = "Find Config File",
			},
			{ "<leader>fd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics" },
			{ "<leader>fD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
			-- git
			{ "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Commits" },
			{ "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Status" },
			-- search
			{ "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Grep (Root Dir)" },
			{
				"<leader>sG",
				function()
					require("telescope.builtin").live_grep({ cwd = vim.fn.getcwd() })
				end,
				desc = "Grep (cwd)",
			},
		},
		opts = {
			defaults = {
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.5,
					},
					width = 0.8,
					height = 0.8,
					preview_cutoff = 120,
				},
				sorting_strategy = "ascending",
				winblend = 0,
				mappings = {
					i = {
						["<C-n>"] = "cycle_history_next",
						["<C-p>"] = "cycle_history_prev",
						["<C-j>"] = "move_selection_next",
						["<C-k>"] = "move_selection_previous",
					},
					n = {
						["<esc>"] = "close",
						["j"] = "move_selection_next",
						["k"] = "move_selection_previous",
						["q"] = "close",
					},
				},
			},
			extensions = {
				fzf = {},
				["ui-select"] = {
					require("telescope.themes").get_dropdown({}),
				},
			},
		},
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)
			pcall(telescope.load_extension, "fzf")
			pcall(telescope.load_extension, "ui-select")
		end,
	},
	-- better vim.ui with telescope
	{
		"stevearc/dressing.nvim",
		lazy = true,
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return require("dressing").select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return require("dressing").input(...)
			end
		end,
	},
}
