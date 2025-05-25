local set = require "utils.set"
return {
  { "LnL7/vim-nix", ft = "nix", enabled = set(false, true) },
  { "nvim-lua/plenary.nvim", lazy = true },
  { "nvim-tree/nvim-web-devicons", lazy = true },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { "<leader>go", "<cmd>Neogit<cr>", desc = "Neogit" },
    },
  },
  { "tpope/vim-abolish", opt = {}, event = "CmdlineEnter" },
}
