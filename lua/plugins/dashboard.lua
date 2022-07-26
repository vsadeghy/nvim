local db = require "dashboard"
db.custom_header = {
  "     _   __________   ",
  "    | | / / __/ __/   ",
  "    | |/ /\\ \\_\\ \\     ",
  "  __________/___/ ____",
  " / ___/ __ \\/ _ \\/ __/",
  "/ /__/ /_/ / // / _/  ",
  "\\___/\\____/____/___/  ",
  "                      ",
}

-- vim.g.dashboard_default_executive = "telescope"

db.custom_center = {
  { icon = " ", desc = "Projects           ", action = "Telescope project" },
  { icon = " ", desc = "Recently Used Files", action = "Telescope oldfiles" },
  { icon = " ", desc = "Find File          ", action = "Telescope find_files" },
  -- { icon =" ", desc = "Load Last Session  ", action = "SessionLoad" },
  { icon = " ", desc = "Find Word          ", action = "Telescope live_grep" },
  { icon = " ", desc = "Settings           ", action = ":e " .. CONFIG_PATH .. "/settings.lua" },
  { icon = " ", desc = "Marks              ", action = "Telescope marks" },
}

-- vim.g.dashboard_custom_footer = { "" }
