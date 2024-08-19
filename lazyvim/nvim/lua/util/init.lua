local M = {}

-- Notifies "Hold it Cowboy!" if certain keys are pressed 10 times quickly.
function M.cowboy()
  ---@type table?
  local id
  local ok = true
  for _, key in ipairs({ "h", "j", "k", "l", "+", "-" }) do
    local count = 0
    local timer = assert(vim.uv.new_timer())
    local map = key
    vim.keymap.set("n", key, function()
      if vim.v.count > 0 then
        count = 0
      end
      if count >= 10 and vim.bo.buftype ~= "nofile" then
        ok, id = pcall(vim.notify, "Hold it Cowboy!", vim.log.levels.WARN, {
          icon = "🤠",
          replace = id,
          keep = function()
            return count >= 10
          end,
        })
        if not ok then
          id = nil
          return map
        end
      else
        count = count + 1
        timer:start(2000, 0, function()
          count = 0
        end)
        return map
      end
    end, { expr = true, silent = true })
  end
end

-- =====================
-- Telescope Helpers
-- =====================

-- Cache for root directories
M.cache = {}

--- Returns the real path of a given file or directory.
--- @param path string: The file or directory path.
--- @return string|nil: The normalized real path, or nil if the path is empty or nil.
function M.realpath(path)
	if path == "" or path == nil then
		return nil
	end
	return vim.fs.normalize(vim.uv.fs_realpath(path) or path)
end

--- Gets the root directory of the current buffer or the provided buffer.
--- The root is determined by finding the nearest .git directory.
--- @param buf number|nil: The buffer number (optional, defaults to the current buffer).
--- @return string: The root directory path.
function M.get_root(buf)
  buf = buf or vim.api.nvim_get_current_buf()
  if not M.cache[buf] then
    local path = M.realpath(vim.api.nvim_buf_get_name(buf))
    local git_dir = vim.fs.find(".git", { path = path, upward = true })[1]
    M.cache[buf] = git_dir and vim.fn.fnamemodify(git_dir, ":h") or vim.uv.cwd()
  end
  return M.cache[buf]
end

--- Retrieves the root directory of the current Git repository.
--- @return string: The Git root directory path.
function M.git_root()
  local root = M.get_root()
  local git_root = vim.fs.find(".git", { path = root, upward = true })[1]
  return git_root and vim.fn.fnamemodify(git_root, ":h") or root
end

-------------

-- function M.customize_lsp_popups()
--   vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
--   vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
--   require("lspconfig.ui.windows").default_options.border = "rounded"
-- end

return M
