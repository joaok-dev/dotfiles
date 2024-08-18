local M = {}

-- Key mappings
M._keys = {
  { "<leader>cl", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
  { "gd", vim.lsp.buf.definition, desc = "Goto Definition", has = "definition" },
  { "gr", vim.lsp.buf.references, desc = "References", nowait = true },
  { "gI", vim.lsp.buf.implementation, desc = "Goto Implementation" },
  { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
  { "K", vim.lsp.buf.hover, desc = "Hover" },
  { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
  { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
}

-- Function to get key mappings
function M.get()
  return M._keys
end

-- Function to check if LSP client supports a method
function M.has(buffer, method)
  if type(method) == "table" then
    for _, m in ipairs(method) do
      if M.has(buffer, m) then
        return true
      end
    end
    return false
  end
  method = method:find("/") and method or "textDocument/" .. method
  local clients = vim.lsp.get_active_clients({ bufnr = buffer })
  for _, client in ipairs(clients) do
    if client.supports_method(method) then
      return true
    end
  end
  return false
end

-- Function to attach key mappings to buffer
function M.on_attach(_, buffer)
  for _, keys in pairs(M.get()) do
    local has = not keys.has or M.has(buffer, keys.has)
    if has then
      local opts = { silent = true, buffer = buffer }
      vim.keymap.set(keys.mode or "n", keys[1], keys[2], opts)
    end
  end
end

return M
