return {
  "mizlan/iswap.nvim",
  event = require "utils.lazyfile",
  keys = {
    { "<leader>ss", "<cmd>ISwapWith<cr>", "swap" },
    { "<leader>sS", "<cmd>ISwapNodeWith<cr>", "swap arbitary" },
  },
}
