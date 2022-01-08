require("spectre").setup {
  live_update = false,
  mappings = {
    ["send_to_qf"] = {
      map = "<leader>Q",
      cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
      desc = "send all item to quickfix",
    },
    ["toggle_line"] = {
      map = "tt",
      cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
      desc = "toggle current item",
    },
  },
}
