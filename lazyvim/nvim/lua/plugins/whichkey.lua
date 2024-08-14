return {
  "folke/which-key.nvim",
  opts = {
    preset = "helix",
    plugins = {
      -- presets = {
      --   operators = false,
      --   motions = false,
      --   text_objects = false,
      --   windows = false,
      --   nav = false,
      --   z = false,
      --   g = false,
      -- },
    },
    win = {
      border = "rounded",
      no_overlap = false,
      title = false,
    },
    -- show_help = false,
    -- show_keys = false,
    disable = {
      -- ft = { "TelescopePrompt" },
    },
  },
}
