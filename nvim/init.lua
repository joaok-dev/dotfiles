require("joaok.core")
require("joaok.lazy")

vim.cmd("command! ExportKeymaps lua require('export_keymaps').export_keymaps()")
