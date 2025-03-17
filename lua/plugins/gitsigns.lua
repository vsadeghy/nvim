local signs = {
  add = { text = "+" },
  change = { text = "~" },
  topdelete = { text = "‾" },
  delete = { text = "_" },
  changedelete = { text = "~" },
}
return {
  "lewis6991/gitsigns.nvim",
  event = require "utils.lazyfile",
  opts = {
    signs = signs,
    signs_staged = signs,
  },
}
