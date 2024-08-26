return {
  --lsp servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = { virtual_text = { prefix = "icons" } },
      inlay_hints = {
        enabled = false,
        exclude = {},
      },
      codelens = { enabled = false },
      document_highlight = { enabled = false },
      capabilities = {
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = false,
          },
        },
      },
      servers = {
        -- lua
        lua_ls = {
          settings = {
            Lua = {
              misc = {},
              type = {
                castNumberToInteger = true,
              },
              diagnostics = {
                disable = {},
                groupSeverity = {
                  strong = "Warning",
                  strict = "Warning",
                },
                groupFileStatus = {},
                unusedLocalExclude = { "_*" },
              },
            },
          },
        },
        -- python
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "off",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
              },
            },
          },
        },
        ruff_lsp = {
          init_options = {
            settings = {
              -- add any ruff-specific settings here
            },
          },
        },
      },
      setup = {
        ruff_lsp = function()
          require("lazyvim.util").lsp.on_attach(function(client, _)
            -- disable hover in favor of pyright
            client.server_capabilities.hoverProvider = false
          end)
        end,
      },
    },
  },
  -- mason
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
      },
    },
  },
}
