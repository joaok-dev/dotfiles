---@diagnostic disable: missing-fields
return {

  -- LSP Config
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local icons = require("util.icons")
      return {
        diagnostics = {
          virtual_text = true,
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
              [vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
              [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
              [vim.diagnostic.severity.INFO] = icons.diagnostics.Information,
            },
          },
          float = {
            focusable = true,
            style = "minimal",
            border = "rounded",
            header = "",
            prefix = "",
          },
        },

        -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
        -- Be aware that you also will need to properly configure your LSP server to
        -- provide the inlay hints.
        inlay_hints = {
          enabled = false,
          exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
        },
        -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
        -- Be aware that you also will need to properly configure your LSP server to
        -- provide the code lenses.
        codelens = {
          enabled = false,
        },
        -- Enable lsp cursor word highlighting
        document_highlight = {
          enabled = true,
        },
        -- add any global capabilities here
        capabilities = {
          workspace = {
            fileOperations = {
              didRename = true,
              willRename = true,
            },
          },
        },
        -- options for vim.lsp.buf.format
        -- `bufnr` and `filter` is handled by the LazyVim formatter,
        -- but can be also overridden when specified
        format = {
          formatting_options = nil,
          timeout_ms = nil,
        },

        -- LSP Server Settings
        ---@type lspconfig.options
        ---------------------------
        servers = {},
        -- you can do any additional lsp server setup here
        -- return true if you don't want this server to be setup with lspconfig
        setup = {
          -- example to setup with typescript.nvim
          -- tsserver = function(_, opts)
          --   require("typescript").setup({ server = opts })
          --   return true
          -- end,
          -- Specify * to use this function as a fallback for any server
          -- ["*"] = function(server, opts) end,
        },
      }
    end,
  },

  -- Mason
  -- Manager for LSP, linters, formatters and DAP
  {
    "williamboman/mason.nvim",
    opts = {
      ui = { border = "rounded" },
      ensure_installed = {
        -- LSP
        -- Linter
        -- Formatter
        -- DAP
      },
    },
  },
}
