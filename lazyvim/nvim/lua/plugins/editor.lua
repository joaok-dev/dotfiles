return {
  -- disabled
  { "MagicDuck/grug-far.nvim", enabled = false },
  { "folke/flash.nvim", enabled = false },

  -- whichkey
  {
    "folke/which-key.nvim",
    opts = {
      preset = "helix",
    },
  },
  -- tmux navigator
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  -- neotree
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
          always_show = { ".gitignore" },
          never_show = { ".DS_Store" },
        },
      },
    },
  },
  -- undotree
  {
    "mbbill/undotree",
    keys = {
      { "<leader>cu", "<cmd>UndotreeToggle<CR>", desc = "Toggle UndoTree" },
    },
  },
  -- gitsigns
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      preview_config = {
        border = "rounded",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
    },
  },
}
