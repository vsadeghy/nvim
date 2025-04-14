local on_attach = require "utils.on_attach"
local set = require "utils.set"

local servers = {
  -- ts_ls = { filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" } },
  html = { filetypes = { "html" } },
  cssls = { fileypes = { "css" } },
  tailwindcss = { filetypes = { "css" } },
  jsonls = { filetypes = { "json", "jsonc", "json5" } },
  -- nil_ls = { filetypes = { "nix" }, cmd = { "nil" } },
  nixd = { filetypes = { "nix" }, cmd = { "nixd" } },
  -- pyright = {filetypes = {"python"}},
  marksman = { filetypes = { "markdown" } },
  lua_ls = {
    filetypes = { "lua" },
    cmd = { "lua-language-server" },
    settings = {
      Lua = {
        completion = { callSnippet = "Replace" },
        runtime = { version = "LuaJIT" },
        path = vim.split(package.path, ";"),
      },
      workspace = {
        checkThirdParty = false,
        library = {
          "${3rd}/luv/library",
          unpack(vim.api.nvim_get_runtime_file("", true)),
        },
      },
      diagonstics = {
        global = { "vim" },
        disable = { "missing-fields" },
      },
      format = {
        enable = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "folke/lazydev.nvim",
      "j-hui/fidget.nvim",
      "saghen/blink.cmp",
      {
        "williamboman/mason.nvim",
        enabled = set(true, false),
        config = true,
      },
      {
        "williamboman/mason-lspconfig.nvim",
        enabled = set(true, false),
      },
      {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        enabled = set(true, false),
      },
    },
    ft = {
      "lua",
      "markdown",
      "nix",
      "python",
      "html",
      "css",
      "javascript",
      "typescript",
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(e)
          local client = vim.lsp.get_client_by_id(e.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = e.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = e.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
              callback = function(e2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = "lsp-highlight", buffer = e2.buf }
              end,
            })
          end

          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            vim.keymap.set("n", "<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = e.buf })
            end, { buffer = e.buf, desc = "[T]oggle Inlay [H]ints" })
          end
        end,
      })

      -- local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
      local capabilities = require("blink.cmp").get_lsp_capabilities({}, true)
      local lspconfig = require "lspconfig"
      set(function()
        require("mason").setup()
        local ensure_installed = vim.tbl_keys(servers)
        vim.list_extend(ensure_installed, {
          "stylua",
        })
        require("mason-tool-installer").setup {
          ensure_installed = ensure_installed,
        }
        require("mason-lspconfig").setup {
          handlers = {
            function(server_name)
              local server = servers[server_name] or {}
              server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
              lspconfig[server_name].setup(server)
            end,
          },
        }
      end, function()
        for server_name, server in pairs(servers) do
          server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
          server.on_attach = on_attach
          local function server_setup()
            lspconfig[server_name].setup(server)
          end
          for _, ft in ipairs(server.filetypes or {}) do
            if ft == vim.bo.filetype then
              server_setup()
            end
          end
          -- vim.api.nvim_create_autocmd("FileType", {
          --   pattern = server.filetypes,
          --   callback = server_setup,
          -- })
        end
      end)()
    end,
  },
  {
    "pmizio/typescript-tools.nvim",
    ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        on_attach(client, bufnr)
      end,
      settings = {
        expose_as_code_actions = "all",
        -- expose_as_code_actions = {
        --   "add_missing_imports",
        --   "organize_imports",
        --   "remove_unused_imports",
        --   "remove_unused",
        -- },
      },
    },
  },

  -- -- Rust
  -- {
  --   "mrcjkb/rustaceanvim",
  --   version = "^4", -- Recommended
  --   dependencies = {
  --     "folke/lazydev.nvim",
  --     "j-hui/fidget.nvim",
  --     "neovim/nvim-lspconfig",
  --     "saghen/blink.cmp",
  --   },
  --   ft = { "rust" },
  --   init = function()
  --     vim.g.rustaceanvim = {
  --       tools = {
  --         enable_clippy = true,
  --       },
  --       server = {
  --         on_attach = on_attach,
  --         default_settings = {
  --           ["rust-analyzer"] = {
  --             cargo = {
  --               allFeatures = true,
  --               features = "all",
  --               loadOutDirsFromCheck = true,
  --               runBuildScripts = true,
  --             },
  --             -- Add clippy lints for Rust
  --             checkOnSave = {
  --               allFeatures = true,
  --               allTargets = true,
  --               command = "clippy",
  --               extraArgs = {
  --                 "--",
  --                 "--no-deps",
  --                 "-Dclippy::pedantic",
  --                 "-Dclippy::nursery",
  --                 "-Dclippy::unwrap_used",
  --                 "-Dclippy::enum_glob_use",
  --                 "-Wclippy::complexity",
  --                 "-Wclippy::perf",
  --                 -- Shitty lints imo
  --                 "-Aclippy::module_name_repetitions",
  --               },
  --             },
  --             procMacro = {
  --               enable = true,
  --               ignored = {
  --                 ["async-trait"] = { "async_trait" },
  --                 ["napi-derive"] = { "napi" },
  --                 ["async-recursion"] = { "async_recursion" },
  --               },
  --             },
  --           },
  --         },
  --       },
  --     }
  --   end,
  -- },
}
