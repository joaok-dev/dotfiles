-- File and System Interaction
vim.opt.clipboard = "unnamedplus" -- Enable system clipboard integration
vim.opt.swapfile = false -- Disable swapfile creation
vim.opt.undofile = true -- Enable persistent undo
vim.opt.backup = false -- Disable backup file creation
vim.opt.writebackup = false -- Disable write backup (no need if backup is disabled)

-- UI and Display
vim.opt.number = true -- Show absolute line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.wrap = false -- Disable line wrapping
vim.opt.termguicolors = true -- Enable 24-bit RGB colors
vim.opt.colorcolumn = "80" -- Highlight column 80 (common line length guide)
vim.opt.guicursor = "" -- Disable fancy GUI cursor (use terminal cursor)
vim.opt.showmode = false -- Hide mode display (e.g., -- INSERT --)
vim.opt.title = false -- Disable automatic window title setting
vim.opt.signcolumn = "yes" -- Always show the sign column (for linting/git)

-- Search and Navigation
vim.opt.scrolloff = 8 -- Keep 8 lines above/below the cursor when scrolling
vim.opt.hlsearch = true -- Highlight search results
vim.opt.incsearch = true -- Enable incremental search (highlight matches as you type)
vim.opt.ignorecase = true -- Case-insensitive search
vim.opt.smartcase = true -- Enable smart case for search

-- Editing and Indentation
vim.opt.smartindent = true -- Enable smart indentation based on syntax
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.shiftwidth = 4 -- Number of spaces to use for each step of (auto)indent
vim.opt.softtabstop = 4 -- Number of spaces a <Tab> counts for while editing
vim.opt.tabstop = 4 -- Number of spaces that a <Tab> in the file counts for

-- Pop-up Menu (Completion and Diagnostics)
-- Configure the behavior and appearance of the pop-up menu used for code completion,
-- linting suggestions, and other diagnostics.
vim.opt.completeopt = {
	"menuone",
	"noselect",
} -- Always show the menu, don't auto-select
vim.opt.pumheight = 10 -- Maximum height of the pop-up menu (in lines)
vim.opt.pumblend = 10 -- Transparency level of the pop-up menu (0-100)
vim.opt.timeoutlen = 1000 -- Time (in ms) to wait for mapped key sequences
vim.opt.updatetime = 100 -- Update interval (in ms) for completion/diagnostics

-- Netrw configuration
vim.g.netrw_browse_split = 0 -- Open files in the same window instead of splitting
vim.g.netrw_banner = 0 -- Disable the banner at the top of the Netrw window
vim.g.netrw_winsize = 25 -- Set the size of the Netrw window to 25% of the total window size

-- Additional Settings
vim.opt.shortmess:append("c") -- Configure short message options
--vim.cmd("set whichwrap+=<,>,[,],h,l") -- Define wrapping behavior for movement keys
vim.cmd([[set iskeyword+=-]]) -- Add '-' to keywords for motion commands
