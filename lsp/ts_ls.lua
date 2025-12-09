local inlay_hints = {
	includeInlayParameterNameHints = "all",
	includeInlayParameterNameHintsWhenArgumentMatchesName = false,
	includeInlayFunctionParameterTypeHints = true,
	includeInlayVariableTypeHints = true,
	includeInlayVariableTypeHintsWhenTypeMatchesName = false,
	includeInlayPropertyDeclarationTypeHints = true,
	includeInlayFunctionLikeReturnTypeHints = true,
	includeInlayEnumMemberValueHints = true,
}
return {
	init_options = { hostInfo = "neovim" },
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	root_markers = { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock", ".git" },
	settings = {
		typescript = { inlayHints = inlay_hints },
		javascript = { inlayHints = inlay_hints },
		typescriptreact = { inlayHints = inlay_hints },
		javascriptreact = { inlayHints = inlay_hints },
	},
	handlers = {
		["_typescript.rename"] = function(_, result, ctx)
			local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
			vim.lsp.util.show_document({
				uri = result.textDocument.uri,
				range = {
					start = result.position,
					["end"] = result.position,
				},
			}, client.offset_encoding)
			vim.lsp.buf.rename()
			return vim.NIL
		end,
	},
	commands = {
		["editor.action.showReferences"] = function(command, ctx)
			local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
			local file_uri, position, references = unpack(command.arguments)

			local quickfix_items = vim.lsp.util.locations_to_items(references, client.offset_encoding)
			vim.fn.setqflist({}, " ", {
				title = command.title,
				items = quickfix_items,
				context = {
					command = command,
					bufnr = ctx.bufnr,
				},
			})

			vim.lsp.util.show_document({
				uri = file_uri,
				range = {
					start = position,
					["end"] = position,
				},
			}, client.offset_encoding)

			vim.cmd "botright copen"
		end,
	},
	on_attach = function(client, bufnr)
		vim.keymap.set("n", "<leader>lo", function()
			client:exec_cmd({
				command = "_typescript.organizeImports",
				arguments = {vim.api.nvim_buf_get_name(bufnr)},
			}, {bufnr = bufnr})
		end, {desc = "Organize Imports", buffer = bufnr})
		-- require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
		vim.api.nvim_buf_create_user_command(bufnr, "LspTypescriptSourceAction", function()
			local source_actions = vim.tbl_filter(
				function(action) return vim.startswith(action, "source.") end,
				client.server_capabilities.codeActionProvider.codeActionKinds
			)
			vim.lsp.buf.code_action { context = { only = source_actions } }
		end, {})
		if vim.bo[bufnr].filetype == "javscript" then
			client.workspace_did_change_configuration({
				settings = {
					javascript = {
						preferences = { noImplicitAny = false },
					},
				},
			})
		end
	end,
}
