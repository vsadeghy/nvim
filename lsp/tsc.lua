local bin_cache = {} ---@type table<string, string>

---@param bin string
---@return boolean
local function supports_lsp(bin)
	if vim.fn.executable(bin) ~= 1 then return false end

	local out = vim.system({ bin, "--version" }, { text = true }):wait()
	local version = vim.version.parse(out.stdout or "")

	return out.code == 0 and version ~= nil and version.major >= 7
end

---@type vim.lsp.Config
return {
	settings = {
		["js/ts"] = {
			inlayHints = {
				parameterNames = {
					enabled = "literals",
					suppressWhenArgumentMatchesName = true,
				},
				parameterTypes = { enabled = true },
				variableTypes = { enabled = true },
				propertyDeclarationTypes = { enabled = true },
				functionLikeReturnTypes = { enabled = true },
				enumMemberValues = { enabled = true },
			},
			referencesCodeLens = {
				enabled = true,
				showOnAllFunctions = true,
			},
			implementationsCodeLens = {
				enabled = true,
				showOnInterfaceMethods = true,
				showOnAllClassMethods = true,
			},
		},
	},
	cmd = function(dispatchers, config)
		local cmd = bin_cache[(config or {}).root_dir] or "tsc"
		return vim.lsp.rpc.start({ cmd, "--lsp", "--stdio" }, dispatchers)
	end,
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
	},
	root_dir = function(bufnr, on_dir)
		local root_markers = { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock" }
		root_markers = vim.fn.has "nvim-0.11.3" == 1 and { root_markers, { ".git" } }
			or vim.list_extend(root_markers, { ".git" })

		local deno_root = vim.fs.root(bufnr, { "deno.json", "deno.jsonc" })
		local deno_lock_root = vim.fs.root(bufnr, { "deno.lock" })
		local project_root = vim.fs.root(bufnr, root_markers)
		if deno_lock_root and (not project_root or #deno_lock_root > #project_root) then return end
		if deno_root and (not project_root or #deno_root >= #project_root) then return end
		local root = project_root or vim.fn.getcwd()

		if bin_cache[root] then return on_dir(root) end

		local bins = {}

		for _, bin in ipairs { "tsc", "tsgo" } do
			bins[#bins + 1] = vim.fs.joinpath(root, "node_modules/.bin", bin)
			bins[#bins + 1] = bin
		end

		for _, bin in ipairs(bins) do
			if supports_lsp(bin) then
				bin_cache[root] = bin
				return on_dir(root)
			end
		end

		vim.notify("tsc: no binary supporting `--lsp` found (requires TypeScript 7.0+)", vim.log.levels.WARN)
	end,

	on_attach = function(client, bufnr)
		vim.keymap.set(
			"n",
			"<leader>lo",
			function()
				vim.lsp.buf.code_action {
					apply = true,
					context = { only = { "source.organizeImports" }, diagnostics = {} },
				}
			end,
			{ desc = "Organize Imports", buffer = bufnr }
		)
		-- require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
		vim.api.nvim_buf_create_user_command(bufnr, "LspTypescriptSourceAction", function()
			local source_actions = vim.tbl_filter(
				function(action) return vim.startswith(action, "source.") end,
				client.server_capabilities.codeActionProvider.codeActionKinds
			)
			vim.lsp.buf.code_action { context = { only = source_actions } }
		end, {})
	end,
}
