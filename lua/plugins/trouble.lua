return {
  "folke/trouble.nvim",
  opts = {
    keys = {
      ["<cr>"] = "jump_close",
      ["<space>"] = {
        ---@param view trouble.View
        ---@param ctx trouble.Action.ctx
        action = function(view, ctx)
          if ctx.item then
            view:jump(ctx.item)
            view:close()
          elseif ctx.node then
            view:fold(ctx.node)
          end
        end,
      },
    },
  },
  cmd = "Trouble",
  keys = {
    {
      "<leader>lt",
      -- "<cmd>Trouble lsp toggle focus=false win.position=right open_no_results=true<cr>",
      function()
        require("trouble").toggle {
          win = {
            position = "right",
            type = "split",
          },
          open_no_results = true,
          mode = "lsp",
          source = "",
        }
      end,
      desc = "Trouble",
    },
    {
      "<leader>e",
      function()
        require("trouble").toggle {
          mode = "diagnostics",
          focus = true,
          auto_close = true,
        }
      end,
      desc = "Trouble Diagnostics",
    },
  },
}
