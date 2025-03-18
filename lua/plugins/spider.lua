return {
  "chrisgrieser/nvim-spider",
  keys = {
    { "gw", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" } },
    { "ge", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" } },
    { "gb", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" } },
  },
}
