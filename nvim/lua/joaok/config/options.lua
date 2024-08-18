local opt = vim.opt

-- File and System Interaction
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard
opt.autowrite = true -- Auto-save modified buffers before potentially dangerous commands
opt.confirm = true -- Ask for confirmation before potentially data-losing actions

-- UI and Display
opt.number = true -- Show absolute line numbers
opt.relativenumber = true -- Show relative line numbers
opt.wrap = false -- Disable line wrapping
opt.termguicolors = true -- Enable 24-bit RGB colors
opt.guicursor = "" -- Disable fancy GUI cursor (use terminal cursor)
opt.showmode = false -- Hide mode display (e.g., -- INSERT --)
opt.signcolumn = "yes" -- Always show the sign column (for linting/git)

-- Search and Navigation
opt.scrolloff = 8 -- Keep 8 lines above/below the cursor when scrolling
opt.ignorecase = true -- Case-insensitive search
opt.smartcase = true -- Enable smart case for search

-- Editing and Indentation
opt.smartindent = true -- Enable smart indentation based on syntax
opt.expandtab = false -- Use spaces instead of tabs
opt.shiftwidth = 2 -- Number of spaces to use for each step of (auto)indent
opt.tabstop = 2 -- Number of spaces that a <Tab> in the file counts for

-- Pop-up Menu (Completion and Diagnostics)
-- Configure the behavior and appearance of the pop-up menu used for code completion,
-- linting suggestions, and other diagnostics.
vim.opt.completeopt = {
	"menu",
	"menuone",
	"noselect",
} -- Always show the menu, don't auto-select
opt.pumheight = 10 -- Maximum height of the pop-up menu (in lines)
opt.pumblend = 10 -- Transparency level of the pop-up menu (0-100)
opt.timeoutlen = 1000 -- Time (in ms) to wait for mapped key sequences
opt.updatetime = 100 -- Update interval (in ms) for completion/diagnostics


-- Netrw configuration
vim.g.netrw_browse_split = 0 -- Open files in the same window instead of splitting
vim.g.netrw_banner = 0 -- Disable the banner at the top of the Netrw window
vim.g.netrw_winsize = 25 -- Set the size of the Netrw window to 25% of the total window size

