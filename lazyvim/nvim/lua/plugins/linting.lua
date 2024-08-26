return {
  -- analyzes code for potential errors, bugs, and style issues
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        python = { "ruff" },
      },
      linters = {},
    },
  },
}
