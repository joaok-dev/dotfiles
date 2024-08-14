-- Editing and Indentation
vim.opt.smartindent = true -- Enable smart indentation based on syntax
vim.opt.expandtab = false -- Use spaces instead of tabs
vim.opt.shiftwidth = 4 -- Number of spaces to use for each step of (auto)indent
vim.opt.softtabstop = 4 -- Number of spaces a <Tab> counts for while editing
vim.opt.tabstop = 4 -- Number of spaces that a <Tab> in the file counts for

-- Telescope
vim.g.lazyvim_picker = "telescope"

-- Autoformat
vim.g.autoformat = false
