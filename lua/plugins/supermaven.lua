return {
  "supermaven-inc/supermaven-nvim",
  event = "InsertEnter",
  depenancies = "saghen/blink.cmp",
  opts = {
    -- disable_keymaps = true,
    keymaps = {
      -- accept_suggestion = nil,
      accept_suggestion = "<C-right>",
      clear_suggestion = "<C-left>",
      accept_word = "<C-down>",
    },
    ignore_filetypes = { "bigfile", "snacks_input", "snacks_notif", "gitcommit", "oil" },
    disable_inline_completion = false,
  },
}
