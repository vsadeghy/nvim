CONFIG_PATH = "~/.config/nvim"
DATA_PATH = vim.fn.stdpath "data"
CACHE_PATH = vim.fn.stdpath "cache"

O = {
  number = true,
  relativenumber = true,

  tabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  linebreak = true,

  ignorecase = true,
  smartcase = true,

  hidden = true,
  swapfile = true,
  undofile = true,

  splitbelow = true,
  splitright = true,

  cursorline = true,
  showmode = false,

  clipboard = "unnamedplus",
  mouse = "a",
  updatetime = 300,
  timeoutlen = 100,
  cmdheight = 2,

  title = true,
  listchars = "eol:¬,tab:>-,trail:~,extends:>,precedes:<",
  list = true,

  termguicolors = true,
  lazyredraw = true,
}

PO = {
  colorscheme = "tokyonight",
  borders = true,
  enabledLanguages = { "typescript", "lua", "bash", "python", "svelte", "css", "rust" },
  -- enabledLanguages = { "null-ls" },
}

G = {
  mapleader = " ",
  reSize = 5, -- <C-w> resize amount
  did_load_filetypes = 1,
  shell = "/bin/bash",
  neovide_cursor_vfx_mode = "pixiedust",
}
