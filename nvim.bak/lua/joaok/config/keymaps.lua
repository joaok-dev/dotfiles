-- Simplified key mappings
local map = vim.keymap.set -- for conciseness
local opts = { noremap = true, silent = true }

-- Define leader key
vim.g.mapleader = " "

-- Netrw Navigation
map("n", "<leader>e", ":Ex<CR>", { desc = "Open Netrw" })

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

-- Buffers
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<Tab>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-Tab>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bd", JoaoK.bufremove, { desc = "Delete Buffer" })
map("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

-- Search and center the current line
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- Save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- Lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- Quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")
