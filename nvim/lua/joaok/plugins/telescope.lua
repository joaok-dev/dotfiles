-- Check if the current directory is a Git repository
local function is_git_repo()
	vim.fn.system("git rev-parse --is-inside-work-tree")
	return vim.v.shell_error == 0
end

-- Get the root directory of the Git repository, if it exists
local function get_git_root()
	local dot_git_path = vim.fn.finddir(".git", vim.loop.cwd() .. ";")
	if dot_git_path == "" then
		return nil
	end
	return vim.fn.fnamemodify(dot_git_path, ":h")
end

-- Set the working directory for text search based on the Git repository
local function live_grep_from_project_git_root()
	local opts = {}
	if is_git_repo() then
		local git_root = get_git_root()
		if git_root then
			opts.cwd = git_root
		else
			opts.cwd = vim.loop.cwd()
		end
	else
		opts.cwd = vim.loop.cwd()
	end
	require("telescope.builtin").live_grep(opts)
end

-- Set the working directory for file search based on the Git repository
local function find_files_from_project_git_root()
	local opts = {}
	if is_git_repo() then
		local git_root = get_git_root()
		if git_root then
			opts.cwd = git_root
		else
			opts.cwd = vim.loop.cwd()
		end
	else
		opts.cwd = vim.loop.cwd()
	end
	require("telescope.builtin").find_files(opts)
end

local keys = {
	{ "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer search" },
	{ "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "Show Keymaps" },
	{ "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Show Help Tags" },
	{ "<leader>ff", find_files_from_project_git_root, desc = "Find Files in Project" },
	{ "<leader>fg", live_grep_from_project_git_root, desc = "Live Grep in Project" },
	{ "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Find Buffers" },
}

local config = function()
	local telescope = require("telescope")

	telescope.setup({
		defaults = {
			mappings = {
				i = {
					["<C-j>"] = "move_selection_next", -- Move selection down in insert mode
					["<C-k>"] = "move_selection_previous", -- Move selection up in insert mode
				},
			},
		},
		pickers = {
			find_files = {
				find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
				file_ignore_patterns = { "node_modules", ".venv" }, -- Ignore these directories
			},
			live_grep = {
				file_ignore_patterns = { "node_modules", ".venv" }, -- Ignore these directories
				additional_args = function(_)
					return { "--hidden", "--no-ignore-vcs" } -- Include hidden files and no VCS ignore
				end,
			},
		},
		extensions = {
			"fzf", -- Load the fzf extension for Telescope
		},
	})

	telescope.load_extension("fzf")
end

return {
	"nvim-telescope/telescope.nvim", -- Main Telescope plugin
	dependencies = {
		{ "nvim-lua/plenary.nvim" }, -- Dependency required by Telescope
		{
			"nvim-telescope/telescope-fzf-native.nvim", -- fzf-native extension for Telescope
			build = "make", -- Build command for the fzf-native extension
		},
		{ "nvim-tree/nvim-web-devicons" },
	},
	keys = keys, -- Key mappings defined above
	config = config, -- Configuration function defined above
}
