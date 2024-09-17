return {
  -- telescope: fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false,
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
      { "<leader>,", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "switch buffer" },
      { "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "grep (root dir)" },
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "command history" },
      -- find
      { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "buffers" },
      {
        "<leader>fc",
        function()
          require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
        end,
        desc = "find config file",
      },
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "find files (root dir)" },
      { "<leader>fF", "<cmd>Telescope find_files cwd=false<cr>", desc = "find files (cwd)" },
      { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "find files (git-files)" },
      -- git
      { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "commits" },
      { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "status" },
      -- search
      { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "registers" },
      { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "auto commands" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "buffer" },
      { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "command history" },
      { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "commands" },
      { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "document diagnostics" },
      { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "workspace diagnostics" },
      { "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "grep (root dir)" },
      { "<leader>sG", "<cmd>Telescope live_grep cwd=false<cr>", desc = "grep (cwd)" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "help pages" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "key maps" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "man pages" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "options" },
      { "<leader>sq", "<cmd>Telescope quickfix<cr>", desc = "quickfix list" },
      {
        "<leader>ss",
        function()
          require("telescope.builtin").lsp_document_symbols()
        end,
        desc = "goto symbol",
      },
      {
        "<leader>sS",
        function()
          require("telescope.builtin").lsp_dynamic_workspace_symbols()
        end,
        desc = "goto symbol (workspace)",
      },
    },
    opts = function()
      local function find_command()
        if vim.fn.executable("rg") == 1 then
          return { "rg", "--files", "--color", "never", "-g", "!.git" }
        elseif vim.fn.executable("fd") == 1 then
          return { "fd", "--type", "f", "--color", "never", "-E", ".git" }
        elseif vim.fn.executable("fdfind") == 1 then
          return { "fdfind", "--type", "f", "--color", "never", "-E", ".git" }
        elseif vim.fn.executable("find") == 1 and vim.fn.has("win32") == 0 then
          return { "find", ".", "-type", "f" }
        elseif vim.fn.executable("where") == 1 then
          return { "where", "/r", ".", "*" }
        end
      end

      return {
        defaults = {
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
              results_width = 0.8,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
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
        pickers = {
          find_files = {
            find_command = find_command,
            hidden = true,
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      }
    end,
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      pcall(telescope.load_extension, "fzf")
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
