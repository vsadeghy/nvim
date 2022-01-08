local null_ls = require "null-ls"
local actions = null_ls.builtins.code_actions
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting
null_ls.setup {
  sources = {
    actions.gitsigns,
    actions.eslint_d,
    diagnostics.eslint_d,
    formatting.prettier,
    -- formatting.prettier_d_slim,
    formatting.stylua.with {
      extra_args = { "--config-path", vim.fn.expand "~/.config/stylua.toml" },
    },
  },
  on_attach = require("lsp.utils").on_attach,
}
