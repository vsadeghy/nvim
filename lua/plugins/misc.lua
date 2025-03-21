local set = require "utils.set"
return {
  { "LnL7/vim-nix", ft = "nix", enabled = set(false, true) },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { "<leader>go", "<cmd>Neogit<cr>", desc = "Neogit" },
    },
  },
}
