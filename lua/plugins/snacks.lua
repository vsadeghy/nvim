return {
  "folke/snacks.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  priority = 1000,
  lazy = false,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    picker = {
      layout = {
        preset = "ivy_split",
      },
      sources = {
        explorer = {
          auto_close = true,
          layout = { layout = { position = "right" } },
        },
      },
    },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    -- scroll = { enabled = true },
    -- statuscolumn = { enabled = true },
    words = { enabled = true },
    zen = {
      toggles = {
        dim = true,
        git_signs = false,
        mini_diff_signs = false,
        diagnostics = false,
        inlay_hints = false,
      },
      zoom = {
        toggles = {
          dim = false,
          git_signs = false,
          mini_diff_signs = false,
          diagnostics = false,
          inlay_hints = false,
        },
      },
      on_open = function()
        vim.opt.showtabline = 0
        vim.opt.cmdheight = 0
        vim.cmd "Gitsigns toggle_signs"
      end,
      on_close = function()
        vim.opt.showtabline = 1
        vim.opt.cmdheight = 1
        vim.cmd "Gitsigns toggle_signs"
      end,
    },
  },
  keys = {
    --stylua: ignore start
    -- files
    { "<C-n>", function() Snacks.picker.explorer() end, desc = "Explorer"},
    { "<C-f>", function() Snacks.picker.smart() end, desc = "Smart Files"},
    { "<leader>so", function() Snacks.picker() end, desc = "Open Picker"},
    { "<leader>sf", function() Snacks.picker.files() end, desc = "Files"},
    { "<leader>st", function() Snacks.picker.grep() end, desc = "Text"},
    { "<leader>sr", function() Snacks.picker.recent() end, desc = "Recent"},
    { "<leader>sp", function() Snacks.picker.projects() end, desc = "Projects"},
    { "<leader>lR", function() Snacks.rename.rename_file() end, desc = "Rename File"},
    -- text
    { "<leader>sT", function() Snacks.picker.grep_buffers() end, desc = "Text in Buffers"},
    { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Word", mode = {"n", "x"}},
    -- vim
    { "<leader>sh", function() Snacks.picker.command_history() end, desc = "Command History"},
    { "<leader>sH", function() Snacks.picker.help() end, desc = "Help Pages"},
    { "<leader>sc", function() Snacks.picker.commands() end, desc = "Commands"},
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps"},
    { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History"},
    -- others
    { "<leader>sn", function() Snacks.notifier.show_history() end, desc = "Notifications"},
    { "<leader>z", function() Snacks.zen.zoom() end, desc = "Zen Zoom"},
    { "<leader>Z", function() Snacks.zen.zen() end, desc = "Zen Mode"},
    { "<leader>.", function() Snacks.scratch() end, desc = "Scratch"},
    { "<leader>S", function() Snacks.scratch.select() end, desc = "Scratch Select"},
    { "<C-/>", function() Snacks.terminal() end, desc = "Terminal"},
    { "<c-_>",  function() Snacks.terminal() end, desc = "which_key_ignore" },
    { "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
    { "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
    --stylua: ignore end
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command
        Snacks.toggle.diagnostics():map "<leader>td"
        Snacks.toggle.treesitter():map "<leader>tt"
        Snacks.toggle.inlay_hints():map "<leader>th"
        Snacks.toggle.indent():map "<leader>tg"
        Snacks.toggle.dim():map "<leader>tD"
      end,
    })
  end,
}
