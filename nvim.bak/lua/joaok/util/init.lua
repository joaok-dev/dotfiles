local M = {}

setmetatable(M, {
	__index = function(t, k)
		t[k] = require("joaok.util." .. k)
		return t[k]
	end,
})

-- =====================
-- General Utilities
-- =====================

--- Retrieves the plugin configuration by its name from the lazy plugin manager.
--- @param name string: The name of the plugin.
--- @return table|nil: The plugin configuration if found, or nil if not.
function M.get_plugin(name)
	return require("lazy.core.config").spec.plugins[name]
end

--- Fetches the options for a specified plugin.
--- @param name string: The name of the plugin.
--- @return table: The options table for the plugin, or an empty table if not found.
function M.opts(name)
	local plugin = M.get_plugin(name)
	if not plugin then
		return {}
	end
	local Plugin = require("lazy.core.plugin")
	return Plugin.values(plugin, "opts", false)
end

--- Checks if a specific plugin is loaded.
--- @param name string: The name of the plugin.
--- @return boolean: True if the plugin is loaded, false otherwise.
function M.is_loaded(name)
	local Config = require("lazy.core.config")
	return Config.plugins[name] and Config.plugins[name]._.loaded
end

M.CREATE_UNDO = vim.api.nvim_replace_termcodes("<c-G>u", true, true, true)

--- Creates an undo point in insert mode.
function M.create_undo()
	if vim.api.nvim_get_mode().mode == "i" then
		vim.api.nvim_feedkeys(M.CREATE_UNDO, "n", false)
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

-- =====================
-- Buffer Helpers
-- =====================

---@param buf number?
function M.bufremove(buf)
	buf = buf or 0
	buf = buf == 0 and vim.api.nvim_get_current_buf() or buf

	if vim.bo[buf].modified then
		local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname(buf)), "&Yes\n&No\n&Cancel")
		if choice == 0 or choice == 3 then -- 0 for <Esc>/<C-c> and 3 for Cancel
			return
		end
		if choice == 1 then -- Yes
			vim.cmd.write()
		end
	end
end

-- =====================
-- Cmp Helpers
-- =====================

--- A custom implementation of `cmp.confirm` that checks if the completion menu is visible
--- without waiting for sources and creates an undo point before confirming.
--- This function is more performant and reliable than the default `cmp.confirm`.
--- @param opts table|nil: Optional settings for confirmation behavior.
--- @return function: A function that confirms the completion or calls the fallback function.
function M.confirm(opts)
	local cmp = require("cmp")
	opts = vim.tbl_extend("force", {
		select = true,
		behavior = cmp.ConfirmBehavior.Insert,
	}, opts or {})
	return function(fallback)
		if cmp.core.view:visible() or vim.fn.pumvisible() == 1 then
			M.create_undo()
			if cmp.confirm(opts) then
				return
			end
		end
		return fallback()
	end
end

-- =====================
-- LSP Helpers
-- =====================

---@param opts? lsp.Client.filter
function M.get_clients(opts)
	local ret = {} ---@type vim.lsp.Client[]
	if vim.lsp.get_clients then
		ret = vim.lsp.get_clients(opts)
	else
		---@diagnostic disable-next-line: deprecated
		ret = vim.lsp.get_active_clients(opts)
		if opts and opts.method then
			---@param client vim.lsp.Client
			ret = vim.tbl_filter(function(client)
				return client.supports_method(opts.method, { bufnr = opts.bufnr })
			end, ret)
		end
	end
	return opts and opts.filter and vim.tbl_filter(opts.filter, ret) or ret
end

---@param on_attach fun(client:vim.lsp.Client, buffer)
---@param name? string
function M.on_attach(on_attach, name)
	return vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local buffer = args.buf ---@type number
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if client and (not name or client.name == name) then
				return on_attach(client, buffer)
			end
		end,
	})
end

-- Store supported methods
---@type table<string, table<vim.lsp.Client, table<number, boolean>>>
M._supports_method = {}

-- Initialize LSP configuration
function M.lsp_setup()
	local register_capability = vim.lsp.handlers["client/registerCapability"]
	vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
		---@diagnostic disable-next-line: no-unknown
		local ret = register_capability(err, res, ctx)
		local client = vim.lsp.get_client_by_id(ctx.client_id)
		if client then
			for buffer in pairs(client.attached_buffers) do
				vim.api.nvim_exec_autocmds("User", {
					pattern = "LspDynamicCapability",
					data = { client_id = client.id, buffer = buffer },
				})
			end
		end
		return ret
	end
	M.on_attach(M._check_methods)
	M.on_dynamic_capability(M._check_methods)
end

-- Check if client supports specific methods
---@param client vim.lsp.Client
function M._check_methods(client, buffer)
	-- don't trigger on invalid buffers
	if not vim.api.nvim_buf_is_valid(buffer) then
		return
	end
	-- don't trigger on non-listed buffers
	if not vim.bo[buffer].buflisted then
		return
	end
	-- don't trigger on nofile buffers
	if vim.bo[buffer].buftype == "nofile" then
		return
	end
	for method, clients in pairs(M._supports_method) do
		clients[client] = clients[client] or {}
		if not clients[client][buffer] then
			if client.supports_method and client.supports_method(method, { bufnr = buffer }) then
				clients[client][buffer] = true
				vim.api.nvim_exec_autocmds("User", {
					pattern = "LspSupportsMethod",
					data = { client_id = client.id, buffer = buffer, method = method },
				})
			end
		end
	end
end

-- Set up autocmd for dynamic capabilities
---@param fn fun(client:vim.lsp.Client, buffer):boolean?
---@param opts? {group?: integer}
function M.on_dynamic_capability(fn, opts)
	return vim.api.nvim_create_autocmd("User", {
		pattern = "LspDynamicCapability",
		group = opts and opts.group or nil,
		callback = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			local buffer = args.data.buffer
			if client then
				return fn(client, buffer)
			end
		end,
	})
end

-- Set up autocmd for supported methods
---@param method string
---@param fn fun(client:vim.lsp.Client, buffer)
function M.on_supports_method(method, fn)
	M._supports_method[method] = M._supports_method[method] or setmetatable({}, { __mode = "k" })
	return vim.api.nvim_create_autocmd("User", {
		pattern = "LspSupportsMethod",
		callback = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			local buffer = args.data.buffer
			if client and method == args.data.method then
				return fn(client, buffer)
			end
		end,
	})
end

-- Format the buffer using conform
---@param opts? table
function M.format(opts)
	opts = vim.tbl_deep_extend("force", {}, opts or {})
	local ok, conform = pcall(require, "conform")
	if ok then
		conform.format(opts)
	else
		vim.lsp.buf.format(opts)
	end
end

-- Create a formatter configuration
---@param opts? table
function M.formatter(opts)
	opts = opts or {}
	local filter = opts.filter or {}
	filter = type(filter) == "string" and { name = filter } or filter

	return {
		name = "LSP",
		primary = true,
		priority = 1,
		format = function(buf)
			M.format({ bufnr = buf })
		end,
		sources = function(buf)
			local clients = vim.lsp.get_active_clients({ bufnr = buf })
			local ret = vim.tbl_filter(function(client)
				return client.supports_method("textDocument/formatting")
					or client.supports_method("textDocument/rangeFormatting")
			end, clients)
			return vim.tbl_map(function(client)
				return client.name
			end, ret)
		end,
	}
end

-- Setup diagnostic signs
---@param diagnostics table
function M.setup_signs(diagnostics)
	if diagnostics and diagnostics.signs and diagnostics.signs.text then
		for severity, icon in pairs(diagnostics.signs.text) do
			local name = vim.diagnostic.severity[severity]:lower():gsub("^%l", string.upper)
			name = "DiagnosticSign" .. name
			vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
		end
	end
end

return M
