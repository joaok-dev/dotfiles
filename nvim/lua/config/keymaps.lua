-- Simplified key mappings
local map = vim.keymap.set
local opts = { noremap = true, silent = true }
local util = require("util")

util.cowboy()

-- Pane and Window Navigation
map("t", "<C-h>", "<cmd>wincmd h<CR>", { desc = "Navigate left in terminal" })
map("t", "<C-j>", "<cmd>wincmd j<CR>", { desc = "Navigate down in terminal" })
map("t", "<C-k>", "<cmd>wincmd k<CR>", { desc = "Navigate up in terminal" })
map("t", "<C-l>", "<cmd>wincmd l<CR>", { desc = "Navigate right in terminal" })

map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "Navigate left in tmux" })
map("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { desc = "Navigate down in tmux" })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "Navigate up in tmux" })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "Navigate right in tmux" })

-- CLipboard Operations
map("n", "<leader>Y", function()
  local cursor_pos = vim.fn.getcurpos()
  vim.cmd('normal! ggVG"+y')
  vim.fn.setpos(".", cursor_pos)
end, { desc = "Copy all file to system clipboard" })
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy to system clipboard" })
map("x", "<leader>p", [["_dP]], { desc = "Paste without overwriting register" })
map({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without overwriting register" })
