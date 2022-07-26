-- stylua: ignore start
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require("packer").startup(function(use)
  -- have packer manager itself
  use {"wbthomason/packer.nvim"}

  -- startup optimization
  use {"nathom/filetype.nvim"}
  use {"lewis6991/impatient.nvim"}
  use {"tweekmonster/startuptime.vim",
    cmd = "StartupTime",
  }

  -- neovim lua
  use {"nvim-lua/plenary.nvim", "nvim-lua/popup.nvim"}

  -- colorschemes
  use {"shaunsingh/moonlight.nvim",
    config = function() require("plugins.moonlight") end,
  }
  use {"folke/tokyonight.nvim"}
  use {"catppuccin/nvim", as = "catppuccin",
    config = function() require("catppuccin") end,
  }

  -- file explorer
  use {"kyazdani42/nvim-tree.lua",
    requires = {"kyazdani42/nvim-web-devicons"},
    config = function() require("plugins.nvimtree") end,
  }

  -- telescope finder
  use {"nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      {"nvim-telescope/telescope-fzf-native.nvim", run = "make"--[[ , cmd = "Telescope" ]]},
      {"nvim-telescope/telescope-media-files.nvim"--[[ , cmd = "Telescope" ]]},
      {"nvim-telescope/telescope-project.nvim"--[[ , cmd = "Telescope" ]]},
    },
    config = function() require("plugins.telescope") end,
  }

  use { "akinsho/toggleterm.nvim", tag = 'v2.*',
    config = function() require("plugins.toggleterm") end,
  }

  use { "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function() require("plugins.lsplines") end,
  }

  -- surround text
  use { "ur4ltz/surround.nvim",
    config = function()
      require("surround").setup {mappings_style = "surround"} -- mappings_style could be "surround" or "sandwich"
    end
  }
  -- don"t forget your bindings
  use {"folke/which-key.nvim",
    config = function() require("plugins.which-key") end,
    -- keys = "<leader>",
  }

  -- dashboard duh
  use {"glepnir/dashboard-nvim",
    config = function() require("plugins.dashboard") end,
  }

  -- colorize your colors
  use {"norcalli/nvim-colorizer.lua",
    cmd = "ColorizerToggle",
    config = function() require("plugins.colorizer") end,
  }

  -- HACK: add stylized comments
  use {"folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function() require("todo-comments").setup{} end,
  }

  use {"yamatsum/nvim-nonicons",
    requires = "kyazdani42/nvim-web-devicons",
  }

  -- search and replace in multiple files
  use {"windwp/nvim-spectre",
    event = {"BufRead", "BufNewFile"},
    requires = "nvim-lua/plenary.nvim",
    config = function() require("plugins.spectre") end,
  }

  use {"feline-nvim/feline.nvim",
    config = function() require("plugins.feline") end
  }

  -- jump anywhere
  use {"phaazon/hop.nvim",
    branch = "v1",
    after = "nvim-treesitter",
    event = {"BufRead", "BufNewFile"},
    config = function()
      require("hop").setup{keys = "etovxqpdygfblzhckisuran"}
    end
  }

  use {"numToStr/Comment.nvim",
    config = function() require("Comment").setup() end
  }

  use {"lewis6991/gitsigns.nvim",
    requires = {"nvim-lua/plenary.nvim"},
    event = {"BufRead", "BufReadPost", "BufNewFile"},
    config = function() require("gitsigns").setup() end
  }

  use { "TimUntersberger/neogit",
    requires = "nvim-lua/plenary.nvim",
    config = function() require("neogit").setup{} end
  }

  use { "NTBBloodbath/rest.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function() require("rest-nvim").setup() end
  }

  use { "folke/zen-mode.nvim",
    config = function() require("zen-mode").setup {} end
  }
  use { "windwp/nvim-autopairs",
    config = function() require("plugins.autopairs") end
  }

  use {"windwp/nvim-ts-autotag" }

  -- syntax highlighting
  use {"nvim-treesitter/nvim-treesitter",
    event = {"BufRead", "BufNewFile"},
    run = ":TSUpdate",
    config = function() require("plugins.treesitter") end,
  }
  use {"nvim-treesitter/playground",
    after = "nvim-treesitter",
    cmd = "TSPlaygroundToggle",
  }
  -- rainbow delimiters
  use {"p00f/nvim-ts-rainbow",
    requires = "nvim-treesitter/nvim-treesitter",
  }
  use {"JoosepAlviste/nvim-ts-context-commentstring",
    requires = "nvim-treesitter/nvim-treesitter",
  }


  -- LSPs
  use {"neovim/nvim-lspconfig",
    event = {
      "VimEnter",
      "BufWinEnter",
      "BufRead",
      "BufNewFile"
    },
    config = function() require("lsp") end,
  }
  use {"tami5/lspsaga.nvim",
    after = "nvim-lspconfig",
  }
  use {"williamboman/nvim-lsp-installer",
    requires = "neovim/nvim-lspconfig",
    config = function() require("lsp.installer") end,
    opt = false,
  }
  use {"anott03/nvim-lspinstall", opt = true}
  use { "mfussenegger/nvim-dap" }

  use {"folke/trouble.nvim",
    requires = {"kyazdani42/nvim-web-devicons"},
  }

  use {"jose-elias-alvarez/null-ls.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function() require("lsp.null-ls") end,
  }

  use {"jose-elias-alvarez/nvim-lsp-ts-utils",
    filetypes = {"javascript", "javascriptreact", "typescript", "typescriptreact"},
    requires = {"neovim/nvim-lspconfig", "nvim-lua/plenary.nvim"}
  }

  use {"hrsh7th/nvim-cmp",
    requires = {
      {"hrsh7th/cmp-buffer"--[[, after = "nvim-cmp"]]},
      {"hrsh7th/cmp-cmdline"--[[, after = "nvim-cmp"]]},
      {"hrsh7th/cmp-nvim-lsp"--[[, after = "nvim-cmp"]]},
      {"hrsh7th/cmp-nvim-lua"--[[, after = "nvim-cmp"]]},
      {"hrsh7th/cmp-path"--[[, after = "nvim-cmp"]]},
      {"saadparwaiz1/cmp_luasnip"--[[, after = "nvim-cmp"]]},
      {"onsails/lspkind-nvim"}
    },
    event = {"BufRead", "BufNewFile", "InsertEnter"},
    config = function() require("plugins.cmp") end
  }

  use {"L3MON4D3/LuaSnip",
    event = "InsertEnter"
  }
  use {"rafamadriz/friendly-snippets"}

  use {"mbbill/undotree",
    -- event = {"BufRead", "BufNewFile"},
    cmd = "UndotreeToggle"
  }
end)
-- stylua: ignore end
