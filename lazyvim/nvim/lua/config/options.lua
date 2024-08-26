local opt = vim.opt

opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true
opt.expandtab = false
opt.list = false

-- disable providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

vim.g.lazyvim_picker = "telescope"

vim.g.lazyvim_python_lsp = "pyright"
vim.g.lazyvim_python_ruff = "ruff"
