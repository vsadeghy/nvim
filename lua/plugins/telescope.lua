return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    cmd = "Telescope",
    keys = {
      { "<C-f>", "<cmd>Telescope find_files<cr>" },
      { "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "Search Files" },
      { "<leader>st", "<cmd>Telescope live_grep<cr>", desc = "Search Text" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search Buffer" },
      { "gr", "<cmd>Telescope lsp_references<cr>" },
    },
    config = function()
      local telescope = require "telescope"

      telescope.setup {
        defaults = {
          file_ignore_patterns = {
            "node%_modules",
            "%.git",
            "dist",
            "package%-lock.json",
            "yarn.lock",
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {},
          },
          undo = {},
        },
      }

      telescope.load_extension "ui-select"
      telescope.load_extension "undo"
      telescope.load_extension "fzf"
    end,
  },
}
