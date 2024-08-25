local opt = vim.opt

-- file and system interaction
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- sync with system clipboard
opt.autowrite = true -- auto-save modified buffers before potentially dangerous commands
opt.backup = false -- disable backup file creation
opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- set undo directory
opt.undofile = true -- enable persistent undo

-- ui and display
opt.number = true -- show absolute line numbers
opt.relativenumber = true -- show relative line numbers
opt.wrap = false -- disable line wrapping
opt.termguicolors = true -- enable 24-bit rgb colors
opt.guicursor = "" -- disable fancy gui cursor (use terminal cursor)
opt.showmode = false -- hide mode display (e.g., -- insert --)
opt.signcolumn = "yes" -- always show the sign column (for linting/git)
opt.cursorline = true -- enable highlighting of the current line

-- search and navigation
opt.scrolloff = 8 -- keep 8 lines above/below the cursor when scrolling
opt.ignorecase = true -- case-insensitive search
opt.smartcase = true -- enable smart case for search

-- editing and indentation
opt.smartindent = true -- enable smart indentation based on syntax
opt.expandtab = false -- use spaces instead of tabs
opt.shiftwidth = 2 -- number of spaces to use for each step of (auto)indent
opt.tabstop = 2 -- number of spaces a <tab> counts for while editing
opt.softtabstop = 2 -- number of spaces a <tab> counts for while editing

-- pop-up menu (completion and diagnostics)
vim.opt.completeopt = {
	"menu",
	"menuone",
	"noselect",
} -- always show the menu, don't auto-select
opt.pumheight = 10 -- maximum height of the pop-up menu (in lines)
opt.pumblend = 10 -- transparency level of the pop-up menu (0-100)
opt.timeoutlen = 1000 -- time (in ms) to wait for mapped key sequences
opt.updatetime = 100 -- update interval (in ms) for completion/diagnostics

-- netrw configuration
vim.g.netrw_browse_split = 0 -- open files in the same window instead of splitting
vim.g.netrw_banner = 0 -- disable the banner at the top of the netrw window
vim.g.netrw_winsize = 25 -- set the size of the netrw window to 25% of the total window size

-- disable unused providers
vim.g.loaded_python3_provider = 0 -- disable python3 provider
vim.g.loaded_perl_provider = 0 -- disable perl provider
vim.g.loaded_ruby_provider = 0 -- disable ruby provider
vim.g.loaded_node_provider = 0 -- disable node.js provider

