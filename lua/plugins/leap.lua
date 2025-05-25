return {
  {
    "ggandor/leap.nvim",
    event = require "utils.lazyfile",
    dependencies = "tpope/vim-repeat",
    enabled = function()
      return vim.bo.filetype ~= "undotree"
    end,
    config = function()
      local action = require("leap.remote").action
      local remote_text = function(prefix)
        local ok, ch = pcall(vim.fn.getcharstr)
        if not ok or ch == vim.keycode "<esc>" then
          return
        end
        action { input = prefix .. ch }
      end

      vim.keymap.set({ "n", "x", "o" }, "S", function()
        require("leap.remote").action()
      end, { desc = "Stealth" })
      --stylua: ignore start
      vim.keymap.set("n", "s", "<Plug>(leap-anywhere)")
      vim.keymap.set({"x", "o"}, "s", "<Plug>(leap)")
      vim.keymap.set({ "x", "o" }, "ar", function() remote_text "a" end, { desc = "remote" })
      vim.keymap.set({ "x", "o" }, "ir", function() remote_text "i" end, { desc = "remote" })
      --stylua: ignore end

      -- "clever-R"
      vim.keymap.set({ "n", "x", "o" }, "R", function()
        local leap_opts = require("leap").opts
        local sk = vim.deepcopy(leap_opts.special_keys)
        sk.next_target = vim.fn.flatten(vim.list_extend({ "R" }, { sk.next_target }))
        sk.prev_target = vim.fn.flatten(vim.list_extend({ "r" }, { sk.prev_target }))
        -- Remove these temporary traversal keys from `safe_labels`.
        local sl = {}
        for _, label in ipairs(vim.deepcopy(leap_opts.safe_labels)) do
          if label ~= "R" and label ~= "r" then
            table.insert(sl, label)
          end
        end
        require("leap.treesitter").select {
          opts = { special_keys = sk, safe_labels = sl },
        }
      end)

      vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
    end,
  },
  { "tpope/vim-repeat", lazy = true },
}
