return {
  enabled = true,
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "3rd/image.nvim",
  },
  opts = {
    event_handlers = {
      {
        event = "file_opened",
        handler = function()
          require("neo-tree.command").execute { action = "close" }
        end,
      },
    },
  },
  keys = {
    -- { "<C-n>", ":Neotree filesystem reveal right<cr>", "Neotree" },
  },
}
