local function map(mode, key, command, opts, bufnr)
  local options = { noremap = true, silent = true }
  options = vim.tbl_extend("force", options, opts or {})
  if bufnr then
    vim.api.nvim_buf_set_keymap(bufnr, mode, key, command, options)
  else
    vim.api.nvim_set_keymap(mode, key, command, options)
  end
end

function nmap(key, command, options)
  map("n", key, command, options)
end

function imap(key, command, options)
  map("i", key, command, options)
end

function vmap(key, command, options)
  map("v", key, command, options)
end

function cmap(key, command, options)
  map("c", key, command, { silent = false })
end

function tmap(key, command, options)
  map("t", key, command)
end

local function bmap(mode, key, command, options, bufnr)
  map(mode, key, command, options, bufnr)
end

function bnmap(bufnr, key, command, options)
  bmap("n", key, command, options, bufnr)
end

function tnmap(bufnr, key, command, options)
  bmap("t", key, command, options, bufnr)
end
