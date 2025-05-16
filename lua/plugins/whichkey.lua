return {
  "folke/which-key.nvim",
  -- event = "VeryLazy",
  lazy = false,
  opts = {
    preset = "helix",
    spec = {
      { "<leader>g", group = "Git" },
      { "<leader>l", group = "LSP" },
      { "<leader>s", group = "Search" },
      { "<leader>t", group = "Toggle", icon = { icon = "", color = "green" } },
    },
  },
}
