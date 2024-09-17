local map = vim.keymap.set

vim.g.mapleader = " "

-- netrw navigation
map("n", "<leader>e", ":Ex<CR>", { desc = "open netrw" })

-- pane and window navigation (tmux & neovim)
map("t", "<C-h>", "<cmd>wincmd h<CR>", { desc = "navigate left in terminal" })
map("t", "<C-j>", "<cmd>wincmd j<CR>", { desc = "navigate down in terminal" })
map("t", "<C-k>", "<cmd>wincmd k<CR>", { desc = "navigate up in terminal" })
map("t", "<C-l>", "<cmd>wincmd l<CR>", { desc = "navigate right in terminal" })

map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "navigate left in tmux" })
map("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { desc = "navigate down in tmux" })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "navigate up in tmux" })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "navigate right in tmux" })

-- buffer navigation
map("n", "[b", "<cmd>bprevious<cr>", { desc = "previous buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "next buffer" })
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "next Buffer" })
map("n", "<leader>bd", "<cmd>:bd<cr>", { desc = "delete buffer" })

-- move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

-- search and center 
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "next search result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "previous search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "previous search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "previous search result" })

-- better indenting
map("v", "<", "<gv", { desc = "decrease indent" })
map("v", ">", ">gv", { desc = "increase indent" })

-- clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "escape and clear hlsearch" })

-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "quit all" })

-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "save file" })

-- formatting
map({ "n", "v" }, "<leader>cf", function()
	require("conform").format({ async = true, lsp_fallback = true, timeout_ms = 5000 })
end, { desc = "Format" })

-- clipboard operations
map("n", "<leader>Y", function()
  local cursor_pos = vim.fn.getcurpos()
  vim.cmd('normal! ggVG"+y')
  vim.fn.setpos(".", cursor_pos)
end, { desc = "copy all file to system clipboard" })

map({ "n", "v" }, "<leader>y", '"+y', { desc = "copy to system clipboard" })
map({ "n", "v" }, "<leader>d", [["_d]], { desc = "delete without overwriting register" })

-- diagnostics
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "line diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "next diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "previous diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "next error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "previous error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "next warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "previous warning" })

map("n", "[q", vim.cmd.cprev, { desc = "previous quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "next quickfix" })

