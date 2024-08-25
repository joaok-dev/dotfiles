return {
	"mbbill/undotree",
	event = { "BufReadPre", "BufNewFile" },
	keys = {
		{
			"<leader>cu",
			"<cmd>UndotreeToggle<cr>",
			mode = "n",
			desc = "Show the UndoTree menu",
		},
	},
}
