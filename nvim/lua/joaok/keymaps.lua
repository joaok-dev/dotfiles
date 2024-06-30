-- Simplified key mappings
local keymap = vim.keymap -- for conciseness
local opts = { noremap = true, silent = true }

-- Define leader key
vim.g.mapleader = " "

-- Netrw Navigation
keymap.set("n", "<leader>pv", ":Ex<CR>", { desc = "Open Netrw" })

-- Pane and Window Navigation in terminal mode
keymap.set("t", "<C-h>", "<cmd>wincmd h<CR>", { desc = "Navigate left in terminal" })
keymap.set("t", "<C-j>", "<cmd>wincmd j<CR>", { desc = "Navigate down in terminal" })
keymap.set("t", "<C-k>", "<cmd>wincmd k<CR>", { desc = "Navigate up in terminal" })
keymap.set("t", "<C-l>", "<cmd>wincmd l<CR>", { desc = "Navigate right in terminal" })

-- Pane and Window Navigation in normal mode
keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "Navigate left in tmux" })
keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { desc = "Navigate down in tmux" })
keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "Navigate up in tmux" })
keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "Navigate right in tmux" })

-- Clipboard Operations
keymap.set("n", "<leader>y", '"+y', { desc = "Copy to system clipboard" })
keymap.set("v", "<leader>y", '"+y', { desc = "Copy to system clipboard" })

-- Center Search Results
keymap.set("n", "n", "nzzzv", { desc = "Next search result and center" })
keymap.set("n", "N", "Nzzzv", { desc = "Previous search result and center" })

-- Delete and Paste without overwriting register
keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without overwriting register" })
keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without overwriting register" })

-- Clear search highlight
keymap.set("n", "<leader>h", ":noh<CR>", { desc = "Clear search highlight" })
