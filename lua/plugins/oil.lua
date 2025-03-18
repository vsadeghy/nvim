-- return {}
return {
  enables = false,
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    view_options = {
      show_hidden = true,
    },
  },
  keys = {
      -- stylua: ignore
      { "<leader>h", function() require("oil").open_float() end, desc = "Open Oil" },
  },
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  -- lazy = false,
}
