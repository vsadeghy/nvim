require "options"
require "keymaps"
require "autocmds"
require "load_lazy"

local set = require "utils.set"
require("lazy").setup("plugins", {
  rocks = { enabled = false },
  performance = { rtp = { reset = set(true, false) } },
  install = { colorscheme = { "catppuccin" } },
})

require "post"
