-- List of languages to ensure are installed
local ensure_installed_languages = {
  "bash",
  "c",
  "cpp",
  "css",
  "diff",
  "dockerfile",
  "go",
  "html",
  "javascript",
  "just",
  "lua",
  "markdown",
  "markdown_inline",
  "php",
  "python",
  "ruby",
  "rust",
  "scss",
  "sql",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "xml",
  "yaml",
}

return {
  -- Treesitter: Parser generator tool for syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- Use the latest version
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    lazy = vim.fn.argc(-1) == 0,
    init = function(plugin)
      -- Add the plugin to the runtime path
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    opts_extend = { "ensure_installed" }, -- Allows extending the ensure_installed list
    opts = {
      -- Enable syntax highlighting
      highlight = { enable = true },
      -- Enable indentation
      indent = { enable = true },
      -- Enable autopairs integration
      autopairs = { enable = true },
      -- List of parsers to install
      ensure_installed = ensure_installed_languages,
      -- Automatically install missing parsers when entering buffer
      auto_install = true, -- This should be a boolean, not a table
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}

