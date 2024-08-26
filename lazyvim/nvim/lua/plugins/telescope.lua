return {
  "telescope.nvim",
  optional = true,
  opts = function()
    local actions = require("telescope.actions")
    return {
      defaults = {
        prompt_prefix = "  ",
        selection_caret = " ",
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
    }
  end,
}
