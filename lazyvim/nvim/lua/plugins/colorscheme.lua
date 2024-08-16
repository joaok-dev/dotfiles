return {

  -- Configure LazyVim to load theme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "darkplus",
    },
  },

  -- Tokyonight
  {
    "tokyonight.nvim",
    lazy = true,
    opts = { style = "night" },
  },

  -- Darkplus
  {
    "lunarvim/darkplus.nvim",
    lazy = true,
  },
}
