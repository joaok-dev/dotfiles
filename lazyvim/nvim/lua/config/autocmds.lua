-- Show cursor line only in active window
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  callback = function()
    if vim.w.auto_cursorline then
      vim.wo.cursorline = true
      vim.w.auto_cursorline = nil
    end
  end,
})
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  callback = function()
    if vim.wo.cursorline then
      vim.w.auto_cursorline = true
      vim.wo.cursorline = false
    end
  end,
})

-- Set language-specific colorcolumn based on file type
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    local filetype = vim.bo.filetype
    local col_widths = {
      c = 80,
      cpp = 80,
      h = 80,
      python = 88,
      javascript = 80,
      typescript = 80,
      jsx = 80,
      tsx = 80,
      rust = 100,
      go = 120,
      ruby = 80,
      php = 120,
      lua = 120,
    }

    vim.opt_local.colorcolumn = tostring(col_widths[filetype] or "")
  end,
})

-- Disable autoformat for specific filetype
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = {
    -- C-family
    "c",
    "cpp",
    "h",
    "hpp",
  },
  callback = function()
    vim.b.autoformat = false
  end,
})
