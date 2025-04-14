vim.g.tmux_navigator_no_mappings = 1
return {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
    "TmuxNavigatorProcessList",
  },
  keys = {
    { "<M-Left>", "<cmd>TmuxNavigateLeft<cr>" },
    { "<M-Down>", "<cmd>TmuxNavigateDown<cr>" },
    { "<M-Up>", "<cmd>TmuxNavigateUp<cr>" },
    { "<M-Right>", "<cmd>TmuxNavigateRight<cr>" },
  },
}
