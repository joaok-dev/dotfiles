local map = vim.keymap.set

-- Define leader key
vim.g.mapleader = " "

-- Netrw Navigation
map("n", "<leader>pv", ":Ex<CR>", { desc = "Open Netrw" })

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

-- Search and center the current line
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- Quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })
