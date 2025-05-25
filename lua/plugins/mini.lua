return {
  { "echasnovski/mini.ai", version = "*", event = require "utils.lazyfile", opts = {} },
  {
    "echasnovski/mini.surround",
    version = "*",
    event = require "utils.lazyfile",
    opts = {
      mappings = {
        add = "gsa",
        delete = "gsd",
        find = "gsf",
        find_left = "gsF",
        highlight = "gsh",
        replace = "gsr",
        update_n_lines = "gsn",
      },
    },
  },
}
