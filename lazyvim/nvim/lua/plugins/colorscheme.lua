return {

  -- Configure LazyVim to load theme
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "tokyonight" },
  },

  -- Tokyonight
  { "tokyonight.nvim", lazy = true, opts = { style = "night" } },

  -- OneDark
  { "navarasu/onedark.nvim", lazy = true, opts = { style = "dark" } },

  -- VscodeDark
  { "Mofiqul/vscode.nvim", lazy = true },

	-- kanawaga
	  { "rebelot/kanagawa.nvim", lazy = true },

}
