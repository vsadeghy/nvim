---@type vim.lsp.Config
return {
	cmd = { "tailwindcss-language-server", "--stdio" },
	filetypes = {
		"html",
		"css",
		"scss",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"svelte",
	},
	root_markers = {
		"tailwind.config.js",
		"tailwind.config.ts",
		"tailwind.config.mjs",
		"tailwind.config.cjs",
		"postcss.config.js",
		"postcss.config.ts",
		"package.json",
	},
	settings = {
		tailwindCSS = {
			classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
			validate = true,
		},
	},
}
