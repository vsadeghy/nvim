vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = function(mode, key, func, desc, opts)
  local options = { silent = true }
  if desc then
    options = vim.tbl_extend("force", options, { desc = desc })
  end
  options = vim.tbl_extend("force", options, opts or {})
  vim.keymap.set(mode, key, func, options)
end
local _ = nil

map({ "n", "v" }, "<space>", "<nop>")
-- Better movement
map({ "n", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", _, { expr = true })
map({ "n", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", _, { expr = true })
map("v", ">", ">gv")
map("v", "<", "<gv")
map("", "H", "^")
map("", "L", "$")

-- Move Lines
map("v", "J", ":m '>+1<cr>gv=gv")
map("v", "K", ":m '<-2<cr>gv=gv")

-- Center after jump
map({ "n", "v" }, "<C-d>", "<C-d>zz")
map({ "n", "v" }, "<C-u>", "<C-u>zz")
map("n", "n", "nzz")
map("n", "N", "Nzz")
map("n", "<C-o>", "<C-o>zz")
map("n", "<C-i>", "<C-i>zz")

map("n", "'", "`")

-- Better Inserting
--
map("n", "<leader>o", 'o<Esc>0"_D', "Better New Line")
map("n", "<leader>O", 'O<Esc>0"_D', "Better New Line")
map("v", "p", '"_dp')

-- Better deleting
map("n", "<leader>d", '0"_D')
map("n", "x", '"_x')

-- Better leaving things
map("i", "jk", "<Esc>")
map("i", "kj", "<Esc>")

-- Quick Fix
-- map("n", "<C-j>", "<cmd>cnext<cr>")
-- map("n", "<C-k>", "<cmd>cprev<cr>")

-- Buffers
map("n", "<tab>", "<cmd>bnext<cr>")
map("n", "<S-tab>", "<cmd>bprev<cr>")
map("n", "<leader>w", "<cmd>write<cr>", "Save Buffer")
map("n", "<leader>W", "<cmd>noautocmd write<cr>", "Save Buffer no Format")
map("n", "<leader>q", "<cmd>bdelete<cr>", "Quit Buffer")
map("n", "<leader>Q", "<cmd>wall|%bdelete<cr><C-o><cmd>bdelete#<cr>", "Quit Other Buffers")
map("n", "<leader>x", "<cmd>quit<cr>", "Quit Buffer")

-- Comment
map("n", "<leader>/", "gcc", "Comment", { remap = true })
map("v", "<leader>/", "gc", "Comment", { remap = true })

vim.api.nvim_create_user_command("E", function()
  vim.cmd.wa()
  vim.cmd.qa()
end, {})
