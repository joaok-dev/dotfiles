-- Helper function
local helpers = {
  create_picker = function(picker, opts)
    return function()
      opts = opts or {}
      opts.cwd = require("util").get_root()
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
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-telescope/telescope-fzf-native.nvim" },
  enabled = function()
    return LazyVim.pick.want() == "telescope"
  end,
  version = false,
  keys = {
    { "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Grep Buffer" },
    { "<leader>fF", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
    { "<leader>ff", helpers.create_picker("find_files"), desc = "Find Files (cwd)" },
    { "<leader>sg", helpers.create_picker("live_grep"), desc = "Live grep in project" },
  },
  opts = function()
    local icons = require("util.icons")
    local actions = require("telescope.actions")

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

    local defaults = {
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
    }

    local pickers = {
      live_grep = {
        theme = "dropdown",
        find_command = find_command(),
        file_ignore_patterns = ignore_patterns,
      },
      grep_string = {
        theme = "dropdown",
      },
      find_files = {
        theme = "dropdown",
        find_command = find_command(),
        path_display = file_name_first,
      },
      buffers = {
        theme = "dropdown",
        previewer = true,
        initial_mode = "normal",
        mappings = {
          i = { ["<C-d>"] = actions.delete_buffer },
          n = { ["dd"] = actions.delete_buffer },
        },
      },
      planets = {
        show_pluto = true,
        show_moon = true,
      },
      colorscheme = {
        enable_preview = true,
      },
      lsp_references = {
        theme = "dropdown",
        initial_mode = "normal",
      },
      lsp_definitions = {
        theme = "dropdown",
        initial_mode = "normal",
      },
      lsp_declarations = {
        theme = "dropdown",
        initial_mode = "normal",
      },
      lsp_implementations = {
        theme = "dropdown",
        initial_mode = "normal",
      },
    }

    local extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    }

    return {
      defaults = defaults,
      pickers = pickers,
      extensions = extensions,
    }
  end,
}
