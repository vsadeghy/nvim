return {
  "catgoose/nvim-colorizer.lua",
  event = require "utils.lazyfile",
  opts = { -- set to setup table
    filetypes = { "css", "javascriptreact", "typescriptreact" },
    lazy_load = true,
    user_default_options = {
      css = true,
      css_fn = true,
      tailwind = true,
    },
  },
}
