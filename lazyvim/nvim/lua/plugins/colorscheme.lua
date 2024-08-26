return {

  -- set colorscheme
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "catppuccin-mocha" },
    -- opts = { colorscheme = "tokyonight" },
    -- opts = { colorscheme = "defaultplus" },
    -- opts = { colorscheme = "vscode" },
  },
  --defaultplus
  {
    "joaok-dev/defaultplus",
    lazy = false,
    priority = 1000,
  },
  --tokyonight
  {
    "tokyonight.nvim",
    opts = function()
      return {
        -- style = "night",
        -- transparent = true,
        styles = {
          comments = { italic = false },
          keywords = { italic = false },
          -- sidebars = "transparent",
          -- floats = "transparent",
        },
        on_highlights = function(hl, c)
          local prompt = "#2d3149"
          hl.TelescopeNormal = { bg = c.bg_dark, fg = c.fg }
          hl.TelescopeBorder = { bg = c.bg_dark, fg = c.bg_dark }
          hl.TelescopePromptNormal = { bg = prompt }
          hl.TelescopePromptBorder = { bg = prompt, fg = prompt }
          hl.TelescopePromptTitle = { bg = c.fg_gutter, fg = c.orange }
          hl.TelescopePreviewTitle = { bg = c.bg_dark, fg = c.bg_dark }
          hl.TelescopeResultsTitle = { bg = c.bg_dark, fg = c.bg_dark }
        end,
      }
    end,
  },

  -- vscode
  {
    "Mofiqul/vscode.nvim",
    -- lazy = false,
    -- priority = 1000,
    opts = {
      transparent = false,
      italic_comments = false,
      disable_nvimtree_bg = true,
    },
  },
  -- catppuccin
  {
    "catppuccin/nvim",
    lazy = false,
  },
}
