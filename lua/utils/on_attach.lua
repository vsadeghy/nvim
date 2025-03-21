local on_attach = function(client, bufnr)
  require("utils.border").update_border()

  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  -- Supports
  local supp = function(method)
    return client:supports_method(method)
  end

  -- Conditional normal map
  local cnmap = function(method, keys, func, desc)
    if supp(method) then
      nmap(keys, func, desc)
    end
  end

  cnmap("textDocument/hover", "K", vim.lsp.buf.hover, "Hover Docs")
  cnmap("textDocument/definition", "gd", vim.lsp.buf.definition, "Definition")
  cnmap("textDocument/declaration", "gD", vim.lsp.buf.declaration, "Declaration")
  cnmap("textDocument/implementation", "gI", vim.lsp.buf.implementation, "Implementation")
  cnmap("textDocument/typeDefinition", "<leader>gT", vim.lsp.buf.type_definition, "Type Definition")
  cnmap("textDocument/rename", "<leader>lr", vim.lsp.buf.rename, "Rename")
  cnmap("textDocument/codeAction", "<leader>la", vim.lsp.buf.code_action, "Code Action")
  cnmap("textDocument/documentSymbol", "<leader>ls", vim.lsp.buf.document_symbol, "Document Symbols")
  cnmap("workspace/symbol", "<leader>lS", vim.lsp.buf.workspace_symbol, "Workspace Symbols")

  vim.lsp.inlay_hint.enable(false)

  -- local inlay_hints_group = vim.api.nvim_create_augroup("LSP_inlayHints", { clear = false })
  -- vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  --     group = inlay_hints_group,
  --     desc = "Update inlay hints on line change",
  --     buffer = bufnr,
  --     callback = function()
  --         vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  --     end,
  -- })
end

return on_attach
