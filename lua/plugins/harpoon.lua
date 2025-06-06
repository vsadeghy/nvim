return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  config = function()
    local harpoon = require "harpoon"
    harpoon:setup()

    --stylua: ignore start
    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
    vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

    vim.keymap.set("n", "<C-j>", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<C-k>", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "<C-l>", function() harpoon:list():select(3) end)
    -- your terminal should Support <C-;> or remap it from terminal
    vim.keymap.set("n", "<C-;>", function() harpoon:list():select(4) end)
    --stylua: ignore end
  end,
  keys = {
    { "<leader>a" },
    { "<C-e>" },
    { "<C-j>" },
    { "<C-k>" },
    { "<C-l>" },
    { "<C-;>" },
  },
}
