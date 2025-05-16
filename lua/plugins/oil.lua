-- return {}
return {
  enables = false,
  "stevearc/oil.nvim",
  ---@module 'oil'
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
