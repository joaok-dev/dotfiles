-- Define leader key
vim.g.mapleader = " "

-- Simplified key mappings
local keymap = vim.keymap -- for conciseness

-- Buffer Navigation
keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
keymap.set("n", "<leader>bb", ":e #<CR>", { desc = "Switch to other buffer" })
keymap.set("n", "<leader>`", ":e #<CR>", { desc = "Switch to other buffer" })

-- Directory Navigation
keymap.set("n", "<leader>m", ":NvimTreeFocus<CR>", { desc = "Focus NvimTree" })
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })

-- Netrw Navigation
keymap.set("n", "<leader>pv", ":Ex<CR>", { desc = "Open Netrw" })

-- Pane and Window Navigation
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Navigate left" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Navigate down" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Navigate up" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Navigate right" })
keymap.set("t", "<C-h>", "<cmd>wincmd h<CR>", { desc = "Navigate left in terminal" })
keymap.set("t", "<C-j>", "<cmd>wincmd j<CR>", { desc = "Navigate down in terminal" })
keymap.set("t", "<C-k>", "<cmd>wincmd k<CR>", { desc = "Navigate up in terminal" })
keymap.set("t", "<C-l>", "<cmd>wincmd l<CR>", { desc = "Navigate right in terminal" })
keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "Navigate left in tmux" })
keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { desc = "Navigate down in tmux" })
keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "Navigate up in tmux" })
keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "Navigate right in tmux" })

-- Window Management
keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })
keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
keymap.set("n", "<C-Left>", ":vertical resize +2<CR>", { desc = "Increase window width" })
keymap.set("n", "<C-Right>", ":vertical resize -2<CR>", { desc = "Decrease window width" })

-- Show Full File Path
keymap.set("n", "<leader>pa", ":echo expand('%:p')<CR>", { desc = "Show full file path" })

-- Indenting
keymap.set("v", "<", "<gv", { silent = true, noremap = true, desc = "Indent left" })
keymap.set("v", ">", ">gv", { silent = true, noremap = true, desc = "Indent right" })

-- Miscellaneous
keymap.set("n", "<leader>w", ":lua vim.wo.wrap = not vim.wo.wrap<CR>", { desc = "Toggle word wrap" })
keymap.set("n", "<leader>y", '"+y', { desc = "Copy to system clipboard" })
keymap.set("v", "<leader>y", '"+y', { desc = "Copy to system clipboard" })

-- Moving Lines
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true, noremap = true, desc = "Move line down" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true, noremap = true, desc = "Move line up" })

-- Comments
keymap.set("n", "<C-/>", "gtc", { noremap = false, desc = "Toggle comment" })
keymap.set("v", "<C-/>", "goc", { noremap = false, desc = "Toggle comment" })

