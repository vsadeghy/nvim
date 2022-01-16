local wk = require "which-key"
wk.setup {
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  key_labels = {
    ["<space>"] = "SPC",
    ["<cr>"] = "RET",
    ["<tab>"] = "TAB",
  },
  operators = { gc = "line comment", gb = "block comment" },
}

local function merge(tbl1, tbl2)
  return vim.tbl_extend("force", tbl1, tbl2)
end

nmap("<Space>", "<NOP>")

local hopmappings = {
  name = "+Hop",
  f = { "<cmd>HopChar1CurrentLineAC<CR>", "Find" },
  F = { "<cmd>HopChar1CurrentLineBC<CR>", "Find" },
  l = { "<cmd>HopLineStart<CR>", "line" },
  s = { "<cmd>HopChar2AC<CR>", "seek" },
  S = { "<cmd>HopChar2BC<CR>", "Seek" },
  w = { "<cmd>HopWordAC<CR>", "word" },
  W = { "<cmd>HopWordBC<CR>", "Word" },
  p = { "<cmd>HopPattern<CR>", "pattern" },
  j = { "<cmd>HopChar1AC<CR>", "Find down" },
  k = { "<cmd>HopChar1BC<CR>", "Find up" },
  [";"] = { ";", "next" },
}

local nmappings = {
  e = { "<cmd>NvimTreeToggle<CR>", "Explorer" },
  q = { "<cmd>bd<CR>", "Close Buffer" },
  s = { "<cmd>w<CR>", "Write Buffer" },
  -- w = {"<cmd>w<CR>", "Write Buffer"},
  x = { "<cmd>bd<CR>", "Close Buffer" },
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
    j = {"<cmd>NextHunk<cr>", "Next Hunk"},
    k = {"<cmd>PrevHunk<cr>", "Prev Hunk"},
    p = {"<cmd>PreviewHunk<cr>", "Preview Hunk"},
    r = {"<cmd>ResetHunk<cr>", "Reset Hunk"},
    R = {"<cmd>ResetBuffer<cr>", "Reset Buffer"},
    s = {"<cmd>StageHunk<cr>", "Stage Hunk"},
    u = {"<cmd>UndoStageHunk<cr>", "Undo Stage Hunk"},
    o = {"<cmd>Telescope git_status<cr>", "Open changed file"},
    b = {"<cmd>Telescope git_branches<cr>", "Checkout branch"},
    c = {"<cmd>Telescope git_commits<cr>", "Checkout commit"},
    C = {"<cmd>Telescope git_bcommits<cr>", "Checkout commit(for current file)"},
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
  P = {
    name = "+Plugin",
    n = { 'ouse{"",<CR>}<esc>>>kf"', "new plugin" },
    c = { '0f/lyt"oconfig = function() require("plugins.<C-o>p") end, <esc>==', "plugin config" },
  },
  r = {
    name = "+Replace",
    o = { "<cmd>lua require('spectre').open()<CR>", "Open" },
    f = { "<cmd>lua require('spectre').open_file_search()<CR>", "current File" },
  },
  [";"] = { "<cmd>Dashboard<cr>", "Dashboard" },
  ["/"] = { "gcc", "Comment", noremap = false },
  ["<space>"] = merge(hopmappings, { name = "+Hop" }),
}

local vmappings = {
  ["<leader>/"] = { "gcgv", "Comment", noremap = false },
  [";"] = hopmappings,
}

wk.register(nmappings, { prefix = "<leader>" })
wk.register(vmappings, { mode = "v" })
wk.register(hopmappings, { prefix = ";", mode = "n" })
