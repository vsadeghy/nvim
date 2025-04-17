local on_attach = function(client, bufnr)
  require("utils.border").update_border()
  local picker = require("snacks").picker

  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set({ "n", "v" }, keys, func, { buffer = bufnr, desc = desc })
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
  cnmap("textDocument/definition", "gd", picker.lsp_definitions, "Definition")
  cnmap("textDocument/declaration", "gD", picker.lsp_declarations, "Declaration")
  cnmap("textDocument/implementation", "gI", picker.lsp_implementations, "Implementation")
  cnmap("textDocument/typeDefinition", "gt", picker.lsp_type_definitions, "Type Definition")
  cnmap("textDocument/references", "gr", picker.lsp_references, "References")
  cnmap("textDocument/rename", "<leader>lr", vim.lsp.buf.rename, "Rename")
  cnmap("textDocument/codeAction", "<leader>la", vim.lsp.buf.code_action, "Code Action")
  cnmap("textDocument/documentSymbol", "<leader>ls", picker.lsp_symbols, "Document Symbols")
  cnmap("workspace/symbol", "<leader>lS", picker.lsp_workspace_symbols, "Workspace Symbols")

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
