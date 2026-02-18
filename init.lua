--options
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.clipboard:append "unnamedplus"
vim.opt.signcolumn = "yes"
vim.opt.winborder = "rounded"
vim.opt.colorcolumn = "80"
vim.opt.list = true
vim.opt.listchars:append {
	multispace = "·",
	lead = "·",
	trail = ".",
}

--terminal
require "fterm"

--mappings
local function ext(tbl1, tbl2) return vim.tbl_extend("force", tbl1, tbl2) end
---@param desc_or_opts? string | vim.keymap.set.Opts
local function map(mode, key, func, desc_or_opts)
	local options = { silent = true }
	local optlist = { table = desc_or_opts, string = { desc = desc_or_opts } }
	vim.keymap.set(mode, key, func, ext(options, optlist[type(desc_or_opts)] or {}))
end

local c = function(cmd) return "<cmd>" .. cmd .. "<cr>" end
map({ "", "!" }, "<FIND>", "<HOME>", "home")
map({ "", "!" }, "<SELECT>", "<END>", "end")
map("", "<RightMouse>", "<nop>")
map("n", "<leader>w", c "w", "write")
map("n", "<leader>W", c "noautocmd w", "write nofmt")
map("n", "<leader>q", c "bd", "close")
map("n", "<leader>x", c "q", "quit")
map("n", "<leader>v", c("e " .. vim.fn.stdpath "config" .. "/init.lua"), "nvim config")
map("n", "<tab>", c "bn", "next buffer")
map("n", "<S-tab>", c "bp", "previous buffer")
map("n", "n", "nzzzv", "next search")
map("n", "N", "Nzzzv", "previous search")
map("n", "<PageDown>", "<C-d>zz", "half-page down")
map("n", "<PageUp>", "<C-u>zz", "half-page up")
map("v", ">", ">gv")
map("v", "<", "<gv")
map("v", "p", '"_dP')
map("n", "yA", c "%y", "Yank All")
map("n", "dA", c "%d", "Delete All")
map({ "n", "v" }, "<leader>d", '0"_D', "Better Delete Line")
map("n", "<leader>e", c "Oil", "Files")
map("n", "x", '"_x')
map("n", "gK", "@='ddkPJ'<cr>", "join reverse")
map("n", "gl", "<C-^>", "alternate file")
map("i", "<S-CR>", "<esc>O", "insert newline above")
map({ "n", "x" }, "<C-/>", "gcc", { desc = "Comment", remap = true })
map({ "n", "x" }, "<leader>l", "<nop>", "LSP")
--tmux
local function move_pane(direction, tmux_cmd)
	return function()
		local curwin = vim.api.nvim_get_current_win()
		vim.cmd("wincmd " .. direction)
		if curwin == vim.api.nvim_get_current_win() then vim.fn.system("tmux select-pane " .. tmux_cmd) end
	end
end
map({ "", "!", "t" }, "<M-Up>", move_pane("k", "-U"))
map({ "", "!", "t" }, "<M-Down>", move_pane("j", "-D"))
map({ "", "!", "t" }, "<M-Left>", move_pane("h", "-L"))
map({ "", "!", "t" }, "<M-Right>", move_pane("l", "-R"))

--autocmds
vim.api.nvim_create_autocmd("FileType", {
	pattern = "man",
	callback = function()
		map("n", "d", "<C-d>", { nowait = true })
		map("n", "u", "<C-u>", { nowait = true })
	end,
})
vim.api.nvim_create_autocmd("TermOpen", { command = "startinsert" })
vim.api.nvim_create_autocmd("BufReadPost", { command = 'norm! `"zz' })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function() vim.highlight.on_yank { timeout = 150 } end,
})
vim.api.nvim_create_autocmd("FileType", {
	callback = function() vim.opt.formatoptions:remove { "c", "r", "o" } end,
})
-- close [No Name] buffers
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
			if vim.api.nvim_buf_get_name(bufnr) == "" then
				local chars = 0
				for _, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
					chars = chars + #line
				end
				if chars == 0 then vim.api.nvim_buf_delete(bufnr, { force = true }) end
			end
		end
	end,
})

if vim.version().minor < 12 then return end
--plugins
vim.pack.add {
	"https://github.com/catppuccin/nvim",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/folke/which-key.nvim",
	"https://github.com/mbbill/undotree",
	{ src = "https://github.com/L3MON4D3/LuaSnip", version = "v2.4.1", build = "make install_jsregexp" },
	"https://github.com/supermaven-inc/supermaven-nvim",
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	"https://github.com/nvim-mini/mini.surround",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/ibhagwan/fzf-lua",
	"https://github.com/thePrimeagen/refactoring.nvim",
	"https://github.com/nvimdev/guard.nvim",
	"https://github.com/nvimdev/guard-collection",
	"https://github.com/chomosuke/typst-preview.nvim",
	{ src = "https://github.com/saghen/blink.cmp", version = "v1.7.0" },
	"https://github.com/nvim-tree/nvim-tree.lua",
}
vim.cmd "colorscheme catppuccin-macchiato"
for _, pack in ipairs { "mini.surround", "refactoring", "oil", "fzf-lua", "nvim-tree" } do
	require(pack).setup()
end
require "debugger"

require("which-key").setup { preset = "helix" }
map("n", "<leader>o", c "NvimTreeOpen", "nvim tree")

--lsp
-- https://github.com/neovim/nvim-lspconfig/tree/master/lsp
vim.lsp.enable { "lua_ls", "ts_ls", "jsonls", "pyright", "tinymist", "bashls", "taplo", "gh_actions_ls", "hls" }
vim.diagnostic.config { virtual_text = true }
require("blink.cmp").setup { keymap = { ["<C-n>"] = false, ["<C-p>"] = false } }
require("supermaven-nvim").setup { ignore_filetypes = { "bigfile", "oil" }, keymaps = { accept_word = "<C-tab>" } }

--snippets
local ls = require "luasnip"
ls.setup { enable_autosnippets = true }
require("luasnip.loaders.from_lua").load()
map("i", "<C-e>", ls.expand)
map("i", "<C-n>", function() ls.jump(1) end)
map("i", "<C-p>", function() ls.jump(-1) end)

--refactoring
local function r(cmd) return (":Refactor " .. cmd:gsub("(%S)$", "%1<cr>")) end
map("", "<leader>r", "<nop>", "refactor")
map("x", "<leader>re", r "extract_var ", "extract variable")
map("x", "<leader>rf", r "extract ", "extract function")
map("x", "<leader>rF", r "extract_to_file ", "extract to file")
map({ "n", "x" }, "<leader>ri", r "inline_var", "inline var")
map("x", "<leader>rI", r "inline_func", "inline func")
map("x", "<leader>rb", r "extract_block", "extract block")
map("x", "<leader>rB", r "extract_block_to_file", "extract block to file")

map("n", "<C-t>", "<nop>", "toggle")
map("n", "<C-t>h", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, "toggle hints")

local function fl(cmd) return c("FzfLua " .. cmd) end
map("n", "<C-f>", fl "files", "files")
map("n", "<leader>f", fl "oldfiles", "recent files")
map("n", "<C-h>", fl "helptags", "Help")
map("n", "<C-g>", fl "live_grep", "live_grep")
map("n", "gd", fl "lsp_definitions", "definitions")
map("n", "gr", fl "lsp_references", "references")
map("n", "gi", fl "lsp_implementations", "implementations")
map("n", "gI", "`.", "last Insert")
map("n", "gt", fl "lsp_typedefs", "type definitions")
map("n", "gk", vim.diagnostic.open_float, "diagnostics")
map("n", "<leader>lf", fl "lsp_finder", "lsp finder")
map("n", "<leader>ld", fl "diagnostics_document", "diagnostics")
map("n", "<leader>lD", fl "diagnostics_workspace", "diagnostics workspace")
map("n", "<leader>la", fl "lsp_code_actions", "code actions")
map("n", "<leader>u", fl "undotree", "undotree")
map("n", "gs", fl "lsp_document_symbols", "symbols")
map("n", "gS", fl "lsp_workspace_symbols", "workspace symbols")

--formatters
vim.g.guard_config = { lsp_as_default_formatter = true, format_on_save = true, save_on_fmt = true }
local ft = require "guard.filetype"
local formatters = require "guard-collection.formatter"
local biome = ext(formatters.biome, { find = { "biome.json", "biome.jsonc" } })
local prettier = ext(formatters.prettier, { cmd = "prettierd", args = { "--stdin-filepath" } })
local tsfiles = "javascript,typescript,javascriptreact,typescriptreact"
ft(tsfiles):fmt(prettier) --:append(biome)
ft("yaml,json,jsonc"):fmt(prettier)
ft("python"):fmt "ruff"
ft("lua"):fmt "stylua"
