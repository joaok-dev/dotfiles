return {
	-- Telescope: Fuzzy finder
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	dependencies = {
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	keys = function()
		local builtin = require("telescope.builtin")
		return {
			{ "/", builtin.current_buffer_fuzzy_find, desc = "Buffer search" },
			{ "fk", builtin.keymaps, desc = "Show keymaps" },
			{ "fh", builtin.help_tags, desc = "Show help tags" },
			{ "ff", builtin.find_files, desc = "Find files in project" },
			{ "fg", builtin.live_grep, desc = "Live grep in project" },
			{ "fb", builtin.buffers, desc = "Find buffers" },
		}
	end,
	opts = function()
		local actions = require("telescope.actions")
		return {
			defaults = {
				mappings = {
					i = {
						["<C-n>"] = actions.cycle_history_next,
						["<C-p>"] = actions.cycle_history_prev,
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
					},
					n = {
						["<esc>"] = actions.close,
						["j"] = actions.move_selection_next,
						["k"] = actions.move_selection_previous,
						["q"] = actions.close,
					},
				},
			},
			wrap_results = true,
			["ui-select"] = {
				require("telescope.themes").get_dropdown({}),
			},
		}
	end,
	config = function(_, opts)
		require("telescope").setup(opts)
		require("telescope").load_extension("fzf")
	end,
}
