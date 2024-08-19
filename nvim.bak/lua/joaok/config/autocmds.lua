local function augroup(name)
  return vim.api.nvim_create_augroup("joaok_" .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "checkhealth",
    "dbout",
    "git",
    "gitsigns.blame",
    "grug-far",
    "help",
    "jir",
    "lspinfo",
    "man",
    "neotest-output",
    "neotest-output-panel",
    "neotest-summary",
    "netrw",
    "notify",
    "oil",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", {
      buffer = event.buf,
      silent = true,
      desc = "Quit buffer",
    })
  end,
})

-- Wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
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

-- Set specific indentation for C-family files
vim.api.nvim_create_autocmd({"FileType"}, {
  pattern = {"c", "cpp", "h", "hpp"},
  callback = function()
    vim.opt_local.smartindent = true
    vim.opt_local.expandtab = false
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
  end,
})
