return {

  -- Bufferline
  -- Fancy-looking tabs
  {
    "akinsho/bufferline.nvim",
    keys = {
      { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next Buffer" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev Buffer" },
    },
    opts = {
      options = {
        mode = "tabs",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },

  -- Lualine
  -- Fancy status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "AndreM222/copilot-lualine",
    },
    opts = function()
      local lualine_require = require("lualine_require")
      lualine_require.require = require

      local icons = require("util.icons")
      local lualine_utils = require("lazyvim.util.lualine")
      local lazy_utils = require("lazyvim.util.ui")

      local diff = {
        "diff",
        colored = false,
        symbols = {
          added = icons.git.LineAdded,
          modified = icons.git.LineModified,
          removed = icons.git.LineRemoved,
        },
      }

      local diagnostics = {
        "diagnostics",
        sections = { "error", "warn" },
        -- colored = false,
        symbols = {
          error = icons.diagnostics.Error,
          warn = icons.diagnostics.Warn,
        },
        padding = 1,
      }

      vim.o.laststatus = vim.g.lualine_laststatus

      return {
        options = {
          component_separators = "",
          section_separators = "",
          ignore_focus = { "NvimTree" },
        },
        sections = {
          lualine_a = {
						-- stylua: ignore
            { "mode", fmt = function(str) return str:sub(1, 3) end, },
          },
          lualine_b = { "branch" },
          lualine_c = {
            lualine_utils.root_dir(),
            diagnostics,
						-- stylua: ignore
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { lualine_utils.pretty_path() },
          },
          lualine_x = {
						-- stylua: ignore
						{
							function() return require("noice").api.status.command.get() end,
							cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
							color = function() return LazyVim.ui.fg("Statement") end,
						},
						-- stylua: ignore
						{
							function() return require("noice").api.status.command.get() end,
							cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
          		color = function() return lazy_utils.fg("Constant") end,
						},
						-- stylua: ignore
						{
							function() return "  " .. require("dap").status() end,
							cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
							color = function() return lazy_utils.fg("Debug") end,
						},
						-- stylua: ignore
						{
							require("lazy.status").updates,
							cond = require("lazy.status").has_updates,
							color = function() return lazy_utils.fg("Special") end,
						},
						diff,
            "copilot",
          },
          lualine_y = {
            { "location", padding = { left = 0, right = 1 } },
            { "progress", separator = " ", padding = { left = 1, right = 0 } },
          },
          lualine_z = {},
        },
        extensions = { "quickfix", "man", "neo-tree", "lazy" },
      }
    end,
  },
}
