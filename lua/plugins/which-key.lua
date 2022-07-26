local wk = require "which-key"
wk.setup {
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  key_labels = {
    ["<space>"] = "SPC",
    ["<CR>"] = "RET",
    ["<tab>"] = "TAB",
  },
  operators = { gc = "line comment", gb = "block comment" },
}

nmap("<Space>", "<NOP>")

local hopmappings = {
  name = "+Hop",
  f = { "<cmd>HopChar1CurrentLineAC<CR>", "Find" },
  F = { "<cmd>HopChar1CurrentLineBC<CR>", "Find" },
  l = { "<cmd>HopLineStart<CR>", "line" },
  -- s = { "<cmd>HopChar2AC<CR>", "seek" },
  s = { "<cmd>HopChar2<CR>", "Seek" },
  w = { "<cmd>HopWordAC<CR>", "word" },
  W = { "<cmd>HopWordBC<CR>", "Word" },
  p = { "<cmd>HopPattern<CR>", "pattern" },
  j = { "<cmd>HopChar1AC<CR>", "Find down" },
  k = { "<cmd>HopChar1BC<CR>", "Find up" },
  [";"] = { ";", "next" },
}

-- normal nmappings
wk.register {
  ["<leader>"] = {
    e = { "<cmd>NvimTreeToggle<CR>", "Explorer" },
    q = { "<cmd>bd<CR>", "Close Buffer" },
    s = { "<cmd>w<CR>", "Write Buffer" },
    f = {
      name = "+Find",
      c = { "<cmd>Telescope commands<CR>", "Commands" },
      C = { "<cmd>Telescope command_history<CR>", "Command History" },
      f = { "<cmd>Telescope find_files<CR>", "File" },
      h = { "<cmd>Telescope help_tags<CR>", "helps" },
      m = { "<cmd>Telescope media_files<CR>", "Media" },
      o = { "<cmd>Telescope builtin<CR>", "Open Telescope" },
      p = { "<cmd>Telescope project<CR>", "Projects" },
      r = { "<cmd>Telescope oldfiles<CR>", "Recent Files" },
      s = { "<cmd>Telescope live_grep<CR>", "String" },
    },
    g = {
      name = "+Git",
      j = { "<cmd>Gitsigns next_hunk<CR>zz", "Next Hunk" },
      k = { "<cmd>Gitsigns prev_hunk<CR>zz", "Prev Hunk" },
      l = { "<cmd>lua _LAZTGIT_TOGGLE()<CR>", "Lazygit" },
      n = { "<cmd>Neogit<CR>", "Neogit" },
      p = { "<cmd>Gitsigns preview_hunk<CR>", "Preview Hunk" },
      r = { "<cmd>Gitsigns reset_hunk<CR>", "Reset Hunk" },
      R = { "<cmd>Gitsigns reset_buffer<CR>", "Reset Buffer" },
      s = { "<cmd>Gitsigns stage_hunk<CR>", "Stage Hunk" },
      u = { "<cmd>Gitsigns undo_stage_hunk<CR>", "Undo Stage Hunk" },
      S = { "<cmd>Telescope git_status<CR>", "Status" },
      b = { "<cmd>Telescope git_branches<CR>", "Checkout branch" },
      c = { "<cmd>Telescope git_commits<CR>", "Checkout commit" },
      C = { "<cmd>Telescope git_bcommits<CR>", "Checkout commit(for current file)" },
    },
    n = { "<cmd>nohl<CR>", "No Highlights" },
    p = {
      name = "+Packer",
      c = { "<cmd>PackerCompile<CR>", "Compile" },
      C = { "<cmd>PackerClean<CR>", "Clean" },
      i = { "<cmd>PackerInstall<CR>", "Install" },
      s = { "<cmd>PackerStatus<CR>", "Status" },
      S = { "<cmd>PackerSync<CR>", "Sync" },
      u = { "<cmd>PackerUpdate<CR>", "Update" },
    },
    r = {
      name = "+Replace",
      o = { "<cmd>lua require('spectre').open()<CR>", "Open" },
      f = { "<cmd>lua require('spectre').open_file_search()<CR>", "current File" },
    },
    w = {
      name = "+Window",
      k = { "<C-\\><C-n><C-w><C-k>", "window up" },
      j = { "<C-\\><C-n><C-w><C-j>", "window down" },
      h = { "<C-\\><C-n><C-w><C-h>", "window left" },
      l = { "<C-\\><C-n><C-w><C-l>", "window right" },
      ["<"] = { "v:count1 * g:reSize . '<C-w><'", "resize window", silent = false, expr = true },
      [">"] = { "v:count1 * g:reSize . '<C-w>>'", "resize window", silent = false, expr = true },
    },
    [";"] = { "<cmd>Dashboard<CR>", "Dashboard" },
    ["/"] = { "gcc", "Comment", noremap = false },
    ["<space>"] = hopmappings,
  }, -- end leader
  n = { "nzzzv", "center next" },
  N = { "Nzzzv", "center Next" },

  s = { "<cmd>HopChar1AC<CR>", "seek" },
  S = { "<cmd>HopChar1BC<CR>", "Seek" },

  ["<C-d>"] = { "<C-d>zzzv", "center down" },
  ["<C-u>"] = { "<C-u>zzzv", "center up" },
  ["<C-o>"] = { "<C-o>zzzv", "center older" },

  ["<A-k>"] = { "<C-w><C-k>", "window up" },
  ["<A-j>"] = { "<C-w><C-j>", "window down" },
  ["<A-h>"] = { "<C-w><C-h>", "window left" },
  ["<A-l>"] = { "<C-w><C-l>", "window right" },

  ["<tab>"] = { "<cmd>bn<CR>", "next buffer" },
  ["<S-tab>"] = { "<cmd>bp<CR>", "previous buffer" },

  ["<C-p>"] = { "<cmd>Telescope find_files<CR>", "find files" },

  [";"] = hopmappings,
}

-- visual
wk.register({
  K = { "<cmd>m -2<CR>gv-gv", "move selected up" },
  J = { "<cmd>m +1<CR>gv-gv", "move selected down" },
  ["<leader>"] = {
    g = {
      name = "+Git",
      s = { ":Gitsigns stage_hunk<CR>", "Stage Hunk" },
      u = { "<cmd>Gitsigns undo_stage_hunk<CR>", "Undo Stage Hunk" },
      r = { "<cmd>Gitsigns reset_hunk<CR>", "Reset Hunk" },
    },
    ["/"] = { "gcgv", "comment", noremap = false },
  },
  [";"] = hopmappings,
}, { mode = "v" })

-- insert
wk.register({
  ["kj"] = { "<esc>", "easy escape" },
  ["jk"] = { "<esc>", "easy escape" },
  ["<A-k>"] = { "<esc>:m .-2<CR>==gi", "move line up" },
  ["<A-j>"] = { "<esc>:m .+1<CR>==gi", "move line down" },
}, { mode = "i" })

-- terminal
-- wk.register({
--   ["<A-k>"] = { "<C-\\><C-n><C-w><C-k>", "window up" },
--   ["<A-j>"] = { "<C-\\><C-n><C-w><C-j>", "window down" },
--   ["<A-h>"] = { "<C-\\><C-n><C-w><C-h>", "window left" },
--   ["<A-l>"] = { "<C-\\><C-n><C-w><C-l>", "window right" },
--   ["<esc>"] = { "<C-\\><C-n>", "escape terminal" },
-- }, { mode = "t", silent = false })
tmap("<A-k>", [[<C-\><C-n><C-w><C-k>]])
tmap("<A-j>", [[<C-\><C-n><C-w><C-j>]])
tmap("<A-h>", [[<C-\><C-n><C-w><C-h>]])
tmap("<A-l>", [[<C-\><C-n><C-w><C-l>]])
tmap("<esc>", [[<C-\><C-n>]])
tmap("<jk>", [[<C-\><C-n>]])
tmap("<nn>", [[<C-\><C-n>]])

cmap("<A-k>", "<up>")
cmap("<A-j>", "<down>")
