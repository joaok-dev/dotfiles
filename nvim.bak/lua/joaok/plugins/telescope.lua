-- Helper functions (moved outside for modularity)
local helpers = {
	create_picker = function(picker, opts)
		return function()
			opts = opts or {}
			opts.cwd = JoaoK.get_root()
			require("telescope.builtin")[picker](opts)
		end
	end,
}

-- Memoization for file_name_first function
local file_name_cache = {}
local function file_name_first(_, path)
	if file_name_cache[path] then
		return file_name_cache[path]
	end
	local tail = vim.fs.basename(path)
	local parent = vim.fs.dirname(path)
	local result = parent == "." and tail or string.format("%s\t\t%s", tail, parent)
	file_name_cache[path] = result
	return result
end

return {
	{
		-- Telescope: Fuzzy finder
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		version = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		keys = function()
			return {
				{ "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer search" },
				{ "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "Show keymaps" },
				{ "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Show help tags" },
				{ "<leader>ff", helpers.create_picker("find_files"), desc = "Find files in project" },
				{ "<leader>fg", helpers.create_picker("live_grep"), desc = "Live grep in project" },
				{ "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Find buffers" },
			}
		end,
		opts = function()
			local actions = require("telescope.actions")
			local icons = JoaoK.icons

			-- Function to determine the best file finder command
			local function find_command()
				local commands = {
					{ "rg", "--files", "--hidden", "--color", "never", "-g", "!.git" },
					{ "fd", "--type", "f", "--hidden", "--color", "never", "-E", ".git" },
					{ "fdfind", "--type", "f", "--hidden", "--color", "never", "-E", ".git" },
					{ "find", ".", "-type", "f" },
					{ "where", "/r", ".", "*" },
				}
				for _, cmd in ipairs(commands) do
					if vim.fn.executable(cmd[1]) == 1 then
						return cmd
					end
				end
				vim.notify("No suitable find command found. Falling back to Telescope's default.", vim.log.levels.WARN)
				return nil -- Fallback: let Telescope use its default
			end

			local ignore_patterns = { "node_modules", ".venv" }

			return {
				defaults = {
					prompt_prefix = icons.ui.Telescope .. " ",
					selection_caret = icons.ui.Forward .. "  ",
					initial_mode = "insert",
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
				pickers = {
					find_files = {
						theme = "dropdown",
						previewer = false,
						find_command = find_command(),
						path_display = file_name_first,
						file_ignore_patterns = ignore_patterns,
					},
					live_grep = {
						theme = "dropdown",
						find_command = find_command(),
						file_ignore_patterns = ignore_patterns,
					},
					buffers = {
						theme = "dropdown",
						previewer = false,
						mappings = {
							i = { ["<C-d>"] = actions.delete_buffer },
							n = { ["dd"] = actions.delete_buffer },
						},
					},
					lsp_references = { theme = "dropdown" },
					lsp_definitions = { theme = "dropdown" },
					lsp_declarations = { theme = "dropdown" },
					lsp_implementations = { theme = "dropdown" },
				},
			}
		end,
		config = function(_, opts)
			require("telescope").setup(opts)
			require("telescope").load_extension("fzf")
		end,
	},

	-- Dressing: Better vim.ui with telescope
	{
		"stevearc/dressing.nvim",
		lazy = true,
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},
}
