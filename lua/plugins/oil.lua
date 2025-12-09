-- return {}
return {
  -- enabled = false,
  "stevearc/oil.nvim",
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    default_file_explorer = true,
    view_options = {
      show_hidden = false,
      is_hidden_file = function(name, bufnr)
        local show = { ".env", ".%ignore", "prettier" }
        local hide = { "^%.", "node_modules", "lock" }
        for _, v in ipairs(show) do
          if name:match(v) then
            return false
          end
        end
        for _, v in ipairs(hide) do
          if name:match(v) then
            return true
          end
        end
        return false
      end,
    },
  },
  keys = {
      -- stylua: ignore
      { "<leader>h", function() require("oil").open_float() end, desc = "Open Oil" },
  },
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
}
