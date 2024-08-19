return {
	"mbbill/undotree",
	event = { "BufReadPre", "BufNewFile" },
	keys = {
		{ "<leader>u", "<cmd>UndotreeToggle<cr>", mode = "n", desc = "Show the UndoTree menu" },
	},
}
