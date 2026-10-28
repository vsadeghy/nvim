vim.loader.enable()
--options
vim.g.mapleader = " "
vim.g.novisual = false -- toggle visual elements linke number and list, so you can copy in client without them
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.breakindent = true
vim.opt.linebreak = true
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
vim.opt.arabicshape = false
vim.opt.listchars:append {
	multispace = "·",
	lead = "·",
	trail = ".",
}

--mappings
local function ext(tbl1, tbl2) return vim.tbl_extend("force", tbl1, tbl2) end
---@param desc_or_opts? string | vim.keymap.set.Opts
function Map(mode, key, func, desc_or_opts)
	local options = { silent = true }
	local optlist = { table = desc_or_opts, string = { desc = desc_or_opts } }
	vim.keymap.set(mode, key, func, ext(options, optlist[type(desc_or_opts)] or {}))
end

local c = function(cmd) return "<cmd>" .. cmd .. "<cr>" end
Map("i", "<f1>", "<nop>")
Map({ "", "!" }, "<FIND>", "<HOME>", "home")
Map({ "", "!" }, "<SELECT>", "<END>", "end")
Map("", "<RightMouse>", "<nop>")
Map("n", "<leader>w", c "w", "write")
Map("n", "<leader>W", c "noautocmd w", "write nofmt")
Map("n", "<leader>q", c "bd", "close")
Map("n", "<leader>x", c "q", "quit")
Map("n", "<leader>v", c("e " .. vim.fn.stdpath "config" .. "/init.lua"), "nvim config")
Map("n", "<tab>", c "bn", "next buffer")
Map("n", "<S-tab>", c "bp", "previous buffer")
Map("n", "n", "nzzzv", "next search")
Map("n", "N", "Nzzzv", "previous search")
Map("n", "<PageDown>", "<C-d>zz", "half-page down")
Map("n", "<PageUp>", "<C-u>zz", "half-page up")
Map("v", ">", ">gv")
Map("v", "<", "<gv")
Map("v", "p", '"_dP')
Map("n", "yA", c "%y", "Yank All")
Map("n", "dA", c "%d", "Delete All")
Map({ "n", "v" }, "<leader>d", '0"_D', "Better Delete Line")
Map("n", "<leader>e", c "Oil", "Files")
Map("n", "x", '"_x')
Map("n", "gK", "@='ddkPJ'<cr>", "join reverse")
Map("n", "gl", "<C-^>", "alternate file")
Map("i", "<S-CR>", "<esc>O", "insert newline above")
Map({ "n", "x" }, "<C-/>", "gcc", { desc = "Comment", remap = true })
Map({ "n", "x" }, "<leader>l", "<nop>", "LSP")

Map("n", "<leader>t", "<nop>", "toggle")
Map("n", "<leader>tl", function()
	if vim.g.novisual == true then
		vim.g.novisual = false
		vim.opt.number = true
		vim.opt.relativenumber = true
		vim.opt.list = true
		vim.opt.signcolumn = "yes"
		vim.diagnostic.config { virtual_text = true }
	else
		vim.g.novisual = true
		vim.opt.number = false
		vim.opt.relativenumber = false
		vim.opt.list = false
		vim.opt.signcolumn = "no"
		vim.diagnostic.config { virtual_text = false }
	end
end, "toggle visual elements")
Map("n", "<leader>tw", function() vim.opt.wrap = not vim.opt.wrap end, "toggle wrap")
Map("n", "<leader>th", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, "toggle hints")

--tmux
local function move_pane(direction, tmux_cmd)
	return function()
		local curwin = vim.api.nvim_get_current_win()
		vim.cmd("wincmd " .. direction)
		if curwin == vim.api.nvim_get_current_win() then vim.fn.system("tmux select-pane " .. tmux_cmd) end
	end
end
Map({ "", "!", "t" }, "<M-Up>", move_pane("k", "-U"))
Map({ "", "!", "t" }, "<M-Down>", move_pane("j", "-D"))
Map({ "", "!", "t" }, "<M-Left>", move_pane("h", "-L"))
Map({ "", "!", "t" }, "<M-Right>", move_pane("l", "-R"))

require "autocmd"

if vim.fn.has "nvim-0.12" == 0 then return end
--plugins
---@param repo string
local function gh(repo) return "https://github.com/" .. repo end
vim.pack.add {
	{ src = gh "catppuccin/nvim", name = "catppuccin" },
	gh "stevearc/oil.nvim",
	gh "folke/which-key.nvim",
	gh "mbbill/undotree",
	{ src = gh "L3MON4D3/LuaSnip", version = "v2.5.0", build = "make install_jsregexp" },
	gh "supermaven-inc/supermaven-nvim",
	gh "nvim-treesitter/nvim-treesitter",
	gh "kdheepak/lazygit.nvim",
	gh "dmmulroy/ts-error-translator.nvim",
	gh "nvim-mini/mini.surround",
	gh "nvim-lua/plenary.nvim",
	gh "ibhagwan/fzf-lua",
	gh "stevearc/quicker.nvim",
	gh "thePrimeagen/refactoring.nvim",
	gh "nvimdev/guard.nvim",
	gh "nvimdev/guard-collection",
	gh "chomosuke/typst-preview.nvim",
	{ src = gh "saghen/blink.cmp", version = vim.version.range "1.*" },
	gh "nvim-tree/nvim-tree.lua",
}

vim.cmd "colorscheme catppuccin-macchiato"
for _, group in ipairs {
	"Normal",
	"NormalNC",
	"NormalFloat",
	"FloatBorder",
	"SignColumn",
	"LineNr",
	"CursorLineNr",
	"Folded",
	"FoldColumn",
} do
	vim.api.nvim_set_hl(0, group, { bg = "none", ctermbg = "none" })
end

for _, pack in ipairs {
	"nvim-treesitter.config",
	"mini.surround",
	"refactoring",
	"oil",
	"nvim-tree",
	"quicker",
	"ts-error-translator",
} do
	require(pack).setup()
end

vim.cmd "colorscheme catppuccin-macchiato"
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })

require("nvim-treesitter").install { "html", "css", "typescript", "svelte" }
vim.api.nvim_create_autocmd("FileType", {
	callback = function(ev)
		local ok = pcall(vim.treesitter.start, ev.buf)
		if not ok then return end
	end,
})
require "debugger"

require("fzf-lua").register_ui_select()

require("which-key").setup { preset = "helix" }
Map("n", "<leader>o", c "NvimTreeOpen", "nvim tree")

--lsp
-- https://github.com/neovim/nvim-lspconfig/tree/master/lsp
vim.lsp.enable {
	"lua_ls",
	"ts_ls",
	-- "tsc",
	"html",
	"css",
	"svelte",
	"tailwindcss",
	"jsonls",
	"pyright",
	"tinymist",
	"bashls",
	"taplo",
	"gh_actions_ls",
	"hls",
}
vim.diagnostic.config { virtual_text = true }
Map("n", "gR", vim.lsp.buf.rename, "rename")
require("blink.cmp").setup { keymap = { ["<C-n>"] = false, ["<C-p>"] = false } }
require("supermaven-nvim").setup { ignore_filetypes = { "bigfile", "oil" }, keymaps = { accept_word = "<C-tab>" } }

--snippets
local ls = require "luasnip"
ls.setup { enable_autosnippets = true }
require("luasnip.loaders.from_lua").load()
Map("i", "<C-e>", ls.expand)
Map("i", "<C-n>", function() ls.jump(1) end)
Map("i", "<C-p>", function() ls.jump(-1) end)

--refactoring
local function r(cmd) return (":Refactor " .. cmd:gsub("(%S)$", "%1<cr>")) end
Map("", "<leader>r", "<nop>", "refactor")
Map("x", "<leader>re", r "extract_var ", "extract variable")
Map("x", "<leader>rf", r "extract ", "extract function")
Map("x", "<leader>rF", r "extract_to_file ", "extract to file")
Map({ "n", "x" }, "<leader>ri", r "inline_var", "inline var")
Map("x", "<leader>rI", r "inline_func", "inline func")
Map("x", "<leader>rb", r "extract_block", "extract block")
Map("x", "<leader>rB", r "extract_block_to_file", "extract block to file")

local function fl(cmd) return c("FzfLua " .. cmd) end
Map("n", "<C-f>", fl "files", "files")
Map("n", "<leader>f", fl "history", "recent files")
Map("n", "<C-h>", fl "helptags", "Help")
Map("n", "<leader>g", fl "grep_cword", "recent files")
Map("v", "<leader>g", fl "grep_visual", "recent files")
Map("n", "<C-g>", fl "live_grep", "live grep")
Map("n", "<C-M-G>", fl "grep resume=true", "grep last")
Map("n", "gd", fl "lsp_definitions", "definitions")
Map("n", "gr", fl "lsp_references", { desc = "references", nowait = true })
Map("n", "gi", fl "lsp_implementations", "implementations")
Map("n", "gI", "`.", "last Insert")
Map("n", "gt", fl "lsp_typedefs", "type definitions")
Map("n", "gk", vim.diagnostic.open_float, "diagnostics")
Map("n", "<leader>lf", fl "lsp_finder", "lsp finder")
Map("n", "<leader>ld", fl "diagnostics_document", "diagnostics")
Map("n", "<leader>lD", fl "diagnostics_workspace", "diagnostics workspace")
Map("n", "<leader>la", fl "lsp_code_actions", "code actions")
Map("n", "<leader>u", fl "undotree", "undotree")
Map("n", "gs", fl "lsp_document_symbols", "symbols")
Map("n", "gS", fl "lsp_workspace_symbols", "workspace symbols")

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

pcall(dofile, vim.fn.expand "~/.lconfig/nvim.lua")
