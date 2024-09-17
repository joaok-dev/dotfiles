local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath })
	vim.fn.system({ "git", "-C", lazypath, "checkout", "tags/stable" })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = { { import = "joaok.plugins" } },
	install = { colorscheme = { "default" } },
	defaults = { lazy = true },
	checker = { enabled = true },
	change_detection = { notify = false },
	performance = {
		cache = { enabled = true },
		rtp = {
			disabled_plugins = {
				"gzip",
				-- "matchit",
				-- "matchparen",
				-- "netrwPlugin",
				"rplugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
