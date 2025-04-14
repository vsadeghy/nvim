return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = require "utils.lazyfile",
  enabled = false,
  ---@module "ibl"
  opts = {
    indent = { char = "▏" },
    scope = {
      show_start = false,
      show_end = false,
      show_exact_scope = false,
    },
    exclude = {
      filetypes = {
        "help",
        "startify",
        "dashboard",
        "neogitstatus",
        "NvinTree",
        "Trouble",
      },
    },
  },
}
