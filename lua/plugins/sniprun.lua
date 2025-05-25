return {
  "michaelb/sniprun",
  enabled = require "utils.set"(true, false),
  build = "bash ./install.sh 1",
  opts = {
    display = {
      "VirtualLine",
    },
    interpreter_options = {
      TypeScript_original = {
        interpreter = "node",
      },
    },
  },
  keys = {
    { "<leader>lx", ":%SnipRun<cr>", desc = "Run code", mode = "n" },
    { "<leader>lx", ":SnipRun<cr>", desc = "Run code", mode = "v" },
  },
}
