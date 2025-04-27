return {
  "supermaven-inc/supermaven-nvim",
  event = "InsertEnter",
  depenancies = "saghen/blink.cmp",
  opts = {
    -- disable_keymaps = true,
    keymaps = {
      -- accept_suggestion = nil,
      accept_suggestion = "<right>",
      clear_suggestion = "<left>",
      accept_word = "<down>",
    },
    ignore_filetypes = { "bigfile", "snacks_input", "snacks_notif", "gitcommit" },
    disable_inline_completion = false,
  },
}
