require("lsp_lines").setup()
vim.diagnostic.config {
  virtual_text = false,
  -- signs = true,
  -- underline = false,
  update_in_insert = false,
}

vim.diagnostic.open_float()
