-- File and System Interaction
vim.opt.backup = false -- Disable backup file creation
vim.opt.clipboard = "unnamedplus" -- Enable system clipboard integration
vim.opt.swapfile = false -- Disable swapfile creation
vim.opt.undofile = true -- Enable persistent undo
vim.opt.writebackup = false -- Disable write backup

-- UI and Display
vim.opt.cmdheight = 1 -- Increase command line space for messages
vim.opt.cursorline = true -- Highlight current line
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Enable relative line numbers
vim.opt.showmode = false -- Disable showing modes like -- INSERT --
vim.opt.showtabline = 1 -- Always show tab bar
vim.opt.termguicolors = true -- Enable terminal GUI colors
vim.opt.title = false -- Disable the window title
vim.opt.signcolumn = "yes" -- Always show sign column
vim.opt.wrap = false -- Disable line wrapping
vim.opt.colorcolumn = "80"

-- Search and Navigation
vim.opt.hlsearch = true -- Highlight search results
vim.opt.incsearch = true
vim.opt.ignorecase = true -- Case-insensitive search
vim.opt.smartcase = true -- Enable smart case for search
vim.opt.mouse = "a" -- Enable mouse support
vim.opt.scrolloff = 0 -- Minimal number of screen lines to keep above and below the cursor
vim.opt.sidescrolloff = 8 -- Number of screen lines to keep to the left and right of the cursor

-- Editing and Indentation
vim.opt.smartindent = true -- Enable intelligent indentation
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.shiftwidth = 2 -- Spaces per tab (for indentation)
vim.opt.softtabstop = 4
vim.opt.tabstop = 2 -- Spaces per tab

-- Pop-up and Completion
vim.opt.completeopt = { "menuone", "noselect" } -- Configuration for completion menu
vim.opt.pumheight = 10 -- Pop-up menu height
vim.opt.pumblend = 10 -- Pop-up menu transparency
vim.opt.timeoutlen = 1000 -- Time to wait for a mapped sequence (ms)
vim.opt.updatetime = 100 -- Reduce delay for completion and diagnostics

-- Additional Settings
vim.opt.shortmess:append("c") -- Configure short message options

-- Keybindings and Behavior
vim.cmd("set whichwrap+=<,>,[,],h,l") -- Define wrapping behavior for movement keys
vim.cmd([[set iskeyword+=-]]) -- Add '-' to keywords for motion commands

-- Netrw Configuration (built-in file explorer)
vim.g.netrw_banner = 0 -- Disable Netrw banner
vim.g.netrw_mouse = 2 -- Netrw mouse mode

