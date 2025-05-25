local set = require "utils.set"

return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        lazy = true,
      },
      {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
          local tsc = require "treesitter-context"
          Snacks.toggle({
            name = "Treesitter Context",
            get = tsc.enabled,
            set = function(state)
              if state then
                tsc.enable()
              else
                tsc.disable()
              end
            end,
          }):map "<leader>tc"
          vim.keymap.set("n", "[c", function()
            tsc.go_to_context(vim.v.count1)
          end, { desc = "Previous Context", silent = true })
        end,
      },
    },

    event = require "utils.lazyfile",
    cmd = {
      "TSBufDisable",
      "TSBufEnable",
      "TSBufToggle",
      "TSDisable",
      "TSEnable",
      "TSToggle",
      "TSInstall",
      "TSInstallInfo",
      "TSInstallSync",
      "TSModuleInfo",
      "TSUninstall",
      "TSUpdate",
      "TSUpdateSync",
    },
    keys = {
      { "<c-space>", desc = "Increment Selection" },
      { "<bs>", desc = "Decrement Selection", mode = "x" },
    },

    lazy = vim.fn.argc(-1) == 0,

    init = function(plugin)
      -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
      -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
      -- no longer trigger the **nvim-treesitter** module to be loaded in time.
      -- Luckily, the only things that those plugins need are the custom queries, which we make available
      -- during startup.
      require("lazy.core.loader").add_to_rtp(plugin)
      require "nvim-treesitter.query_predicates"
    end,

    build = set ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = {
      auto_install = set(true, false),
      highlight = {
        enable = true,
        disable = { "latex" },
      },
      indent = { enable = false },
      textobjects = {
        lsp_interop = {
          enable = true,
        },
        select = {
          -- Enabling this greatly increases the startup time on
          -- zig files
          -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects/issues/461
          enable = true,

          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["]s"] = "@parameter.inner",
          },
          swap_previous = {
            ["[s"] = "@parameter.inner",
          },
        },
      },
    },
  },
}
