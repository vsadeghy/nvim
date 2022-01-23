local toggleterm = require "toggleterm"
toggleterm.setup {
  -- size = 20,
  size = function(term)
    if term.direction == "horizontal" then
      return 20
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<c-\>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  -- direction = "vertical" | "horizontal" | "window" | "float",
  direction = "float",
  close_on_exit = true,
  shell = vim.o.shell,
  float_opts = {
    -- The border key is *almost* the same as "nvim_open_win"
    -- the "curved" border is a custom border type
    -- border = "single" | "double" | "shadow" | "curved", -- | ... other options supported by win open
    border = "curved",
    -- width = <value>,
    -- height = <value>,
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
}

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new { cmd = "lazygit", hidden = true }
function _LAZTGIT_TOGGLE()
  lazygit:toggle()
end
