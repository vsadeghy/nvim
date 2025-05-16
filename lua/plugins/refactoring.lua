return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  lazy = require "utils.lazyfile",
  opts = {},
  keys = {
    {
      "<leader>le",
      function()
        return require("refactoring").refactor "Extract Function"
      end,
      expr = true,
      desc = "Extract Function",
      mode = { "n", "x" },
    },
    {
      "<leader>lf",
      function()
        return require("refactoring").refactor "Extract Function To File"
      end,
      expr = true,
      desc = "Extract Function To File",
      mode = { "n", "x" },
    },
    {
      "<leader>lv",
      function()
        return require("refactoring").refactor "Extract Variable"
      end,
      expr = true,
      desc = "Extract Variable",
      mode = { "n", "x" },
    },
    {
      "<leader>lI",
      function()
        return require("refactoring").refactor "Inline Function"
      end,
      expr = true,
      desc = "Inline Function",
      mode = { "n", "x" },
    },
    {
      "<leader>li",
      function()
        return require("refactoring").refactor "Inline Variable"
      end,
      expr = true,
      desc = "Inline Variable",
      mode = { "n", "x" },
    },
    {
      "<leader>lb",
      function()
        return require("refactoring").refactor "Extract Block"
      end,
      expr = true,
      desc = "Extract Block",
      mode = { "n", "x" },
    },
    {
      "<leader>lB",
      function()
        return require("refactoring").refactor "Extract Block To File"
      end,
      expr = true,
      desc = "Extract Block To File",
      mode = { "n", "x" },
    },
  },
}
