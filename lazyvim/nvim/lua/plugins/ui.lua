return {
  -- noice
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      opts.presets.lsp_doc_border = true
    end,
  },
  -- notify
  {
    "rcarriga/nvim-notify",
    opts = { timeout = 5000 },
  },
  -- indent-blankline
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      enabled = false,
    },
  },
  -- bufferline
  {
    "akinsho/bufferline.nvim",
    keys = {
      { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    },
    opts = {
      options = {
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },
  -- lualine
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options.component_separators = { left = "", right = "" }
      opts.options.section_separators = { left = "", right = "" }
      opts.sections.lualine_a = {
        {
          "mode",
          fmt = function(str)
            return str:sub(1, 3)
          end,
        },
      }
      opts.sections.lualine_b = { "branch" }
      opts.sections.lualine_z = {}
      return opts
    end,
  },
}
