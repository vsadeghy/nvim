local wk = require "which-key"

require("lspconfig").tsserver.setup {
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  root_dir = require("lspconfig/util").root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
  settings = { documentFormatting = false },
  on_attach = function(client, buffer)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
    local ts_utils = require "nvim-lsp-ts-utils"
    ts_utils.setup {
      print "setting up ts_utils",
      debug = true,
      disable_commands = false,
      enable_import_on_completion = true,
      import_all_timeout = 5000, -- ms

      -- eslint
      eslint_enable_code_actions = true,
      eslint_enable_disable_comments = true,
      eslint_bin = "eslint_d",
      eslint_config_fallback = nil,
      eslint_enable_diagnostics = true,

      -- formatting
      enable_formatting = true,
      formatter = "prettierd",
      formatter_config_fallback = ".prettierrc",

      -- parentheses completion
      complete_parens = true,
      signature_help_in_parens = true,

      -- update imports on file move
      update_imports_on_move = true,
      require_confirmation_on_move = false,
      watch_dir = nil,
    }
    ts_utils.setup_client(client)
    wk.register({
      ["<leader>lo"] = { "<cmd>TSLspOrganize<CR>", "organize" },
      ["<leader>lI"] = { "<cmd>TSLspImportAll<CR>", "import all" },
      ["gRf"] = { "rename file" },
    }, { buffer = buffer })
    require("lsp.onattach").on_attach(client, buffer)
  end,
}
