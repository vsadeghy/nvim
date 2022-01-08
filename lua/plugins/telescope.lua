local actions = require "telescope.actions"
require("telescope").load_extension "fzf"
require("telescope").load_extension "media_files"
require("telescope").load_extension "project"

require("telescope").setup {
  defaults = {
    find_command = { "rg", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
    -- prompt_position = "bottom",
    -- prompt_prefix = " ",
    prompt_prefix = " ",
    selection_caret = " ",
    -- entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    scroll_strategy = "cycle",
    sorting_strategy = "ascending",
    layout_strategy = "flex",
    -- layout_defaults = {horizontal = {mirror = false}, vertical = {mirror = false}},
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    file_ignore_patterns = {
      "node%_modules",
      ".git",
      "dist",
      "package%-lock.json",
      "yarn.lock",
    },
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    -- path_display = "shorten",
    -- winblend = 0,
    -- width = 0.75,
    layout_config = {
      -- height = 0.8,
      -- width = 0.75,
      prompt_position = "top",
      horizontal = { mirror = false, preview_cutoff = 100, preview_width = 0.60 },
      vertical = { mirror = true, preview_cutoff = 0.4 },
    },
    flex = {
      flip_columns = 110,
    },
    -- preview_cutoff = 1,
    -- -- results_height = 1,
    -- -- preview_height = 1,
    -- -- preview_width = 10,
    -- -- border = {},
    -- -- borderchars = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
    color_devicons = true,
    -- use_less = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        -- To disable a keymap, put [map] = false
        -- So, to not map "<C-n>", just put
        -- ["<c-x>"] = false,
        ["<esc>"] = actions.close,

        -- Otherwise, just set the mapping to the function that you want it to be.
        -- ["<C-i>"] = actions.select_horizontal,

        -- Add up multiple actions
        ["<CR>"] = actions.select_default + actions.center,

        -- You can perform as many actions in a row as you like
        -- ["<CR>"] = actions.select_default + actions.center + my_cool_custom_action,
      },
      n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        -- ["<C-i>"] = my_cool_custom_action,
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
    },
    media_files = {
      filetypes = { "png", "jpg", "mp4", "webm", "mkv", "pdf" },
      find_cmd = "rg",
    },
  },
}
