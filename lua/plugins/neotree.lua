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
  -- config = function(_, opts)
  --     require("neo-tree").setup(opts)
  --     -- vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<cr>")
  -- end,
  keys = {
    { "<C-n>", ":Neotree filesystem reveal right<cr>" },
  },
}
