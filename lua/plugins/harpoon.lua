local map = require "utils.map"
return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  config = function()
    local harpoon = require "harpoon"
    harpoon:setup()

    --stylua: ignore start
    map("n", "<leader>a", function() harpoon:list():add() end, "harpoon add")
    map("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, "harpoon list")

    map("n", "<C-j>", function() harpoon:list():select(1) end, "harpoon 1")
    map("n", "<C-k>", function() harpoon:list():select(2) end, "harpoon 2")
    map("n", "<C-l>", function() harpoon:list():select(3) end, "harpoon 3")
    -- your terminal should Support <C-;> or remap it from terminal
    map("n", "<C-p>", function() harpoon:list():select(4) end, "harpoon 4")
    -- map("n", "<leader>;", function() harpoon:list():select(4) end, "harpoon 4")
    --stylua: ignore end
  end,
  keys = {
    { "<leader>a" },
    { "<C-e>" },
    { "<C-j>" },
    { "<C-k>" },
    { "<C-l>" },
    { "<C-p>" },
  },
}
