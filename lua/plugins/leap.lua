return {
  {
    "ggandor/leap.nvim",
    event = require "utils.lazyfile",
    dependencies = "tpope/vim-repeat",
    config = function()
      local action = require("leap.remote").action
      local remote_text = function(prefix)
        local ok, ch = pcall(vim.fn.getcharstr)
        if not ok or ch == vim.keycode "<esc>" then
          return
        end
        action { input = prefix .. ch }
      end

      --stylua: ignore start
      vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)", { desc = "Leap Forwards" })
      vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)", { desc = "Leap Backwards" })
      vim.keymap.set({ "n", "x", "o" }, "gs", function() action() end, { desc = "Go Stealth" })
      vim.keymap.set({ "x", "o" }, "ar", function() remote_text "a" end, { desc = "remote" })
      vim.keymap.set({ "x", "o" }, "ir", function() remote_text "i" end, { desc = "remote" })
      --stylua: ignore end

      vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
    end,
  },
  { "tpope/vim-repeat", lazy = true },
}
