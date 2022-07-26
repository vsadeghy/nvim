local null_ls = require "null-ls"
local actions = null_ls.builtins.code_actions
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting
null_ls.setup {
  sources = {
    actions.gitsigns,

    actions.eslint_d,
    diagnostics.eslint_d,
    formatting.prettierd.with {
      extra_filetypes = { "svelte" },
    },

    formatting.stylua.with {
      extra_args = { "--config-path", vim.fn.expand "~/.config/stylua.toml" },
    },

    formatting.shfmt,

    diagnostics.flake8,
    -- diagnostics.pylint,
    formatting.black,
    -- formatting.autopep8,
    -- formatting.yapf,
    -- formatting.rustfmt,
  },
  on_attach = require("lsp.onattach").on_attach,
}
