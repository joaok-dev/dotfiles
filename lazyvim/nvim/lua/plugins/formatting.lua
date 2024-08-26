return {
  -- automatically adjusts code layout and style for consistency
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        c = { "c_formatter_42" },
        python = { "ruff" },
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
