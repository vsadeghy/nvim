return {
  "folke/todo-comments.nvim",
  event = { "BufRead", "BufWrite", "BufNewFile" },
  cmd = { "TodoTrouble", "TodoTelescope" },
  config = true,
    -- stylua: ignore
    keys = {
      { "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      -- { "<leader>sd", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME,TEST,TESTS,IDEA<cr>", desc = "Todo" },
    },
  opts = {},
}
