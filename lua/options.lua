vim.wo.number = true -- Set numbered lines (default: false)
vim.opt.signcolumn = "yes" -- Keep signcolumn on by default (default: "auto")
vim.opt.relativenumber = true -- Set relative numbered lines (default: false)
vim.opt.wrap = false -- Display lines as one long line (default: true)
vim.opt.linebreak = true -- Companion to wrap, don"t split words (default: false)
vim.opt.mouse = "a" -- Enable mouse mode (default: "")
vim.opt.autoindent = true -- Copy indent from current line when starting new one (default: true)
vim.opt.ignorecase = true -- Case-insensitive searching UNLESS \C or capital in search (default: false)
vim.opt.smartcase = true -- Smart case (default: false)
vim.opt.shiftwidth = 2 -- The number of spaces inserted for each indentation (default: 8)
vim.opt.tabstop = 2 -- Insert n spaces for a tab (default: 8)
vim.opt.softtabstop = 2 -- Number of spaces that a tab counts for while performing editing operations (default: 0)
vim.opt.expandtab = true -- Convert tabs to spaces (default: false)
vim.opt.scrolloff = 4 -- Minimal number of screen lines to keep above and below the cursor (default: 0)
vim.opt.sidescrolloff = 8 -- Minimal number of screen columns either side of cursor if wrap is `false` (default: 0)
vim.opt.cursorline = true -- Highlight the current line (default: false)
-- vim.opt.colorcolumn = { 80, 81 }
vim.opt.splitbelow = true -- Force all horizontal splits to go below current window (default: false)
vim.opt.splitright = true -- Force all vertical splits to go to the right of current window (default: false)
vim.opt.hlsearch = false -- Set highlight on search (default: true)
vim.opt.showmode = false -- We don"t need to see things like -- INSERT -- anymore (default: true)
vim.opt.whichwrap = "bs<>[]hl" -- Which "horizontal" keys are allowed to travel to prev/next line (default: "b,s")
vim.opt.numberwidth = 4 -- Set number column width to 2 {default 4} (default: 4)
vim.opt.swapfile = false -- Creates a swapfile (default: true)
vim.opt.smartindent = true -- Make indenting smarter again (default: false)
vim.opt.showtabline = 1 -- Always show tabs (default: 1)
vim.opt.backspace = "indent,eol,start" -- Allow backspace on (default: "indent,eol,start")
vim.opt.pumheight = 10 -- Pop up menu height (default: 0)
vim.opt.conceallevel = 0 -- So that `` is visible in markdown files (default: 1)
vim.opt.fileencoding = "utf-8" -- The encoding written to a file (default: "utf-8")
vim.opt.cmdheight = 1 -- More space in the Neovim command line for displaying messages (default: 1)
vim.opt.breakindent = true -- Enable break indent (default: false)
vim.opt.updatetime = 250 -- Decrease update time (default: 4000)
vim.opt.timeoutlen = 300 -- Time to wait for a mapped sequence to complete (in milliseconds) (default: 1000)
vim.opt.backup = false -- Creates a backup file (default: false)
vim.opt.writebackup = false -- If a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited (default: true)
vim.opt.undofile = true -- Save undo history (default: false)
vim.opt.completeopt = "menuone,noselect" -- Set completeopt to have a better completion experience (default: "menu,preview")
vim.opt.termguicolors = true -- Set termguicolors to enable highlight groups (default: false)
vim.opt.list = true
vim.opt.hidden = true

-- vim.opt.shortmess:append "c" -- Don't give |ins-completion-menu| messages (default: does not include 'c')
vim.opt.iskeyword:remove "_" -- So when using 'w' and such stops at _ and doesn't go over it
vim.opt.clipboard:append "unnamedplus"
vim.opt.formatoptions:remove { "c", "r", "o" } -- Don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode. (default: 'croql')
vim.opt.runtimepath:remove "/usr/share/vim/vimfiles" -- Separate Vim plugins from Neovim in case Vim still in use (default: includes this path if Vim is installed)
vim.opt.listchars:append {
  -- multispace = "·",
  lead = "·",
  trail = "~",
  nbsp = "·",
  -- eol = "↵",
  tab = ">-",
  extends = ">",
  precedes = "<",
}

-- -- Change lsp inlay_hint_handler to only show hints on the current line
-- -- https://github.com/neovim/neovim/issues/28261#issuecomment-2130338921
-- local methods = vim.lsp.protocol.Methods
-- local inlay_hint_handler = vim.lsp.handlers[methods["textDocument_inlayHint"]]
-- vim.lsp.handlers[methods["textDocument_inlayHint"]] = function(err, result, ctx, config)
--     local client = vim.lsp.get_client_by_id(ctx.client_id)
--     if client then
--         local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
--         if result == nil then
--             return
--         end
--         result = vim.iter(result)
--             :filter(function(hint)
--                 return hint.position.line + 1 == row
--             end)
--             :totable()
--     end
--     inlay_hint_handler(err, result, ctx, config)
-- end
