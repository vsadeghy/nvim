return {
  "folke/which-key.nvim",
  -- event = "VeryLazy",
  lazy = false,
  opts = {
    preset = "helix",
    spec = {
      { "<leader>g", group = "Git", mode = { "n", "v" } },
      { "<leader>l", group = "LSP", mode = { "n", "v" } },
      { "<leader>s", group = "Search", mode = { "n", "v" } },
      { "<leader>t", group = "Toggle", icon = { icon = "", color = "green" }, mode = { "n", "v" } },
    },
  },
}
