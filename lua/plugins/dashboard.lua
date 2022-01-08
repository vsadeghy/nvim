vim.g.dashboard_custom_header = {
  "     _   __________   ",
  "    | | / / __/ __/   ",
  "    | |/ /\\ \\_\\ \\     ",
  "  __________/___/ ____",
  " / ___/ __ \\/ _ \\/ __/",
  "/ /__/ /_/ / // / _/  ",
  "\\___/\\____/____/___/  ",
  "                      ",
}

vim.g.dashboard_default_executive = "telescope"

vim.g.dashboard_custom_section = {
  a = { description = { "  Find File          " }, command = "Telescope find_files" },
  b = { description = { "  Recently Used Files" }, command = "Telescope oldfiles" },
  -- c = {description = {'  Load Last Session  '}, command = 'SessionLoad'},
  c = { description = { "  Projects           " }, command = "Telescope project" },
  d = { description = { "  Find Word          " }, command = "Telescope live_grep" },
  e = { description = { "  Settings           " }, command = ":e " .. CONFIG_PATH .. "/settings.lua" },
  -- e = {description = {'  Marks              '}, command = 'Telescope marks'}
}

vim.g.dashboard_custom_footer = { "" }