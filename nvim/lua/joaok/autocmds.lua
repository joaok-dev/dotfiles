-- Close specific types of buffers by pressing 'q'
-- This autocmd sets up a key mapping for the specified file types
-- When 'q' is pressed, the buffer will close, and the buffer will not be listed
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = {
		"netrw",
		"Jaq",
		"qf",
		"git",
		"help",
		"man",
		"lspinfo",
		"oil",
		"spectre_panel",
		"lir",
		"DressingSelect",
		"tsplayground",
		"query",
		"",
	},
	callback = function()
		vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]])
	end,
})

-- Check for file changes when a buffer is entered
-- This autocmd runs the 'checktime' command to check if the file
-- has been modified outside of Vim/Neovim, ensuring you are notified
-- of any changes made externally
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	pattern = { "*" },
	callback = function()
		vim.cmd("checktime")
	end,
})

-- Update the window title to the current directory name
-- This autocmd sets the window title to the name of the current directory
-- whenever a buffer is entered, making it easy to see which directory you are in
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	pattern = { "*" },
	callback = function()
		local dirname = vim.fn.getcwd():match("([^/]+)$")
		vim.opt.titlestring = dirname
	end,
})

-- Highlight text on yank
-- This autocmd visually highlights text that has been yanked (copied)
-- for a brief moment, providing visual feedback that the yank was successful
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 40 })
	end,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	command = [[%s/\s\+$//e]],
	-- %s/          : Substitute command
	-- \s\+$       : Match trailing whitespace
	-- //          : Replace with nothing (i.e., remove)
	-- e           : Suppress errors (e.g., if no trailing whitespace is found)
})
