return {

  -- Autocomplete
  -- Suggests and completes code as you type
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")

      opts.mapping["<C-j>"] = cmp.mapping.select_next_item()
      opts.mapping["<C-n>"] = cmp.mapping.select_next_item()
      opts.mapping["<C-k>"] = cmp.mapping.select_prev_item()
      opts.mapping["<C-p>"] = cmp.mapping.select_prev_item()

      return opts
    end,
  },

  -- Linting
  -- Analyzes code for potential errors, bugs, and style issues
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {},
      linters = {
        -- -- Example of using selene only when a selene.toml file is present
        -- selene = {
        --   -- `condition` is another LazyVim extension that allows you to
        --   -- dynamically enable/disable linters based on the context.
        --   condition = function(ctx)
        --     return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1]
        --   end,
        -- },
      },
    },
  },

  -- Formatting
  -- Automatically adjusts code layout and style for consistency
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        c = { "c_formatter_42" },
      },
      formatters = {
        c_formatter_42 = {
          command = "/Users/joaok/.asdf/installs/python/3.12.4/bin/c_formatter_42",
          args = {},
          stdin = true,
          stdout = true,
          tempfile_postfix = ".c",
        },
      },
    },
  },
}
