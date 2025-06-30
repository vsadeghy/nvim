return {
  { "echasnovski/mini.ai", version = "*", event = require "utils.lazyfile", opts = {} },
  {
    "echasnovski/mini.surround",
    version = "*",
    opts = {
      mappings = {
        add = "Sa",
        delete = "Sd",
        find = "Sf",
        find_left = "SF",
        highlight = "Sh",
        replace = "Sc",
        update_n_lines = "Sn",
      },
    },
    init = function()
      vim.keymap.set({ "n", "x" }, "s", "<nop>")
    end,
  },
}
