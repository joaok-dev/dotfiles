return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "AndreM222/copilot-lualine",
  },
  opts = function()
    local lualine_require = require("lualine_require")
    lualine_require.require = require

    local icons = require("util.icons").diagnostics
    local diagnostics = {
      "diagnostics",
      sections = { "error", "warn" },
      colored = false,
      always_visible = true,
    }

    return {
      options = {
        component_separators = "",
        section_separators = "",
        ignore_focus = { "NvimTree" },
      },
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(str)
              return str:sub(1, 3)
            end,
          },
        },
        lualine_b = { "branch" },
        lualine_c = {
          diagnostics,
          {
            "filename",
            path = 3,
            padding = { left = 4, right = 0 },
          },
        },
        lualine_x = {
          "copilot",
          {
            "filetype",
            icon_only = true,
            separator = "",
            padding = { left = 1, right = 0 },
          },
        },
        lualine_y = { "progress" },
        lualine_z = {},
      },
      extensions = { "quickfix", "man", "fugitive" },
    }
  end,
}
