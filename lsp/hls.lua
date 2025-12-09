return {
	cmd = { "haskell-language-server-wrapper", "--lsp" },
	filetypes = { "haskell", "lhaskell", "cabal" },
	root_dir = function(bufnr, on_dir)
		local root_markers = { "hie.yaml", "stack.yaml", "cabal.project", "*.cabal", "package.yaml" }
		local project_root = vim.fs.root(bufnr, root_markers) or vim.fn.getcwd()
		on_dir(project_root)
	end,
	settings = {
		haskell = {
			formattingProvider = "ormolu",
			cabalFormattingProvider = "cabal-fmt",
		},
	},
}
