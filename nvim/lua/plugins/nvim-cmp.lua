return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
  },
  opts = function()
    local cmp = require("cmp")
    return {
      auto_brackets = {}, -- configure any filetype to auto add brackets
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
      }),
      sources = cmp.config.sources({}),
      formatting = {},
      view = {
        entries = {
          name = "custom",
          selection_order = "top_down",
        },
        docs = {
          auto_open = false,
        },
      },
      window = {
        completion = {
          border = "rounded",
          winhighlight = "Normal:Pmenu,CursorLine:PmenuSel,FloatBorder:FloatBorder,Search:None",
          col_offset = -3,
          side_padding = 1,
          scrollbar = false,
          scrolloff = 8,
        },
        documentation = {
          border = "rounded",
          winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,Search:None",
        },
      },
    }
  end,
}
