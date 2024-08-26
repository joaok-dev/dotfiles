return {
  -- suggests and completes code as you type
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.mapping = vim.tbl_extend("force", opts.mapping or {}, {
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
      })
      opts.view = {
        entries = {
          name = "custom",
          selection_order = "top_down",
        },
        docs = {
          auto_open = false,
        },
      }
      opts.window = {
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
      }
      opts.experimental = {
        ghost_text = false,
      }
      return opts
    end,
  },
}
