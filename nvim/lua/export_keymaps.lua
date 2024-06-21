local function export_keymaps()
	local keymaps = vim.api.nvim_get_keymap("n") -- Obter mapeamentos no modo normal
	local buffer_local_keymaps = vim.api.nvim_buf_get_keymap(0, "n") -- Obter mapeamentos específicos do buffer no modo normal

	local file = io.open("keymaps.txt", "w") -- Abre um arquivo para escrever os mapeamentos
	file:write("Global Keymaps:\n")
	for _, keymap in ipairs(keymaps) do
		file:write(string.format("%s %s %s\n", keymap.lhs, keymap.rhs or keymap.callback, keymap.desc or ""))
	end

	file:write("\nBuffer Local Keymaps:\n")
	for _, keymap in ipairs(buffer_local_keymaps) do
		file:write(string.format("%s %s %s\n", keymap.lhs, keymap.rhs or keymap.callback, keymap.desc or ""))
	end
	file:close()

	print("Keymaps exported to keymaps.txt")
end

return {
	export_keymaps = export_keymaps,
}
