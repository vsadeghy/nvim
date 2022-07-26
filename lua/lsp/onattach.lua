local wk = require "which-key"

local conf = {}
function conf.on_attach(client, buffer)
  wk.register({
    ["<leader>"] = {
      l = {
        name = "+LSP",
        a = { "<cmd>Lspsaga code_action<CR>", "action" },
        d = { "<cmd>Telescope lsp_document_diagnostics<cr>", "Document Diagnostics" },
        D = { "<cmd>Telescope lsp_workspace_diagnostics<cr>", "Workspace Diagnostics" },
        f = { "<cmd>lua vim.lsp.buf.formatting_sync()<CR>", "Format Document" },
        F = { "<cmd>Lspsaga lsp_finder<CR>", "definition/refrence" },
        h = { "<cmd>Lspsaga hover_doc<CR>", "hover" },
        l = { "<cmd>Lspsaga show_line_diagnostics<cr>", "Line Diagnostics" },
        L = { "<cmd>lua require('lsp_lines').toggle()<cr>", "toggle lsp_lines" },
        p = { "<cmd>Lspsaga preview_definition<cr>", "Preview Definition" },
        r = { "<cmd>Lspsaga rename<CR>", "rename" },
        R = { "<cmd>vim.lsp.buf.references()<CR>", "references" },
        s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
        S = { "<cmd>Telescope lsp_workspace_symbols<cr>", "Workspace Symbols" },
        x = { "<cmd>cclose<cr>", "Close Quickfix" },
      },
    },
    g = {
      d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "definition" },
      D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "declaration" },
      h = { "<cmd>Lspsaga hover_doc<CR>", "definition" },
      i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "implementation" },
      r = { "<cmd>lua vim.lsp.buf.references()<CR>", "refrences" },
      R = {
        name = "+rename",
        r = { "<cmd>Lspsaga rename<CR>", "rename" },
      },
    },
    d = {
      name = "+Debug",
      b = { "<cmd> lua require('dap').toggle_breakopint()<CR>", "toggle breakpoint" },
      c = { "<cmd> lua require('dap').continue()<CR>", "continue" },
      o = { "<cmd> lua require('dap').step_over()<CR>", "step over" },
      i = { "<cmd> lua require('dap').step_into()<CR>", "step into" },
    },
    ["<f2>"] = { "<cmd>Lspsaga rename<CR>", "rename" },
    ["<C-b>"] = { "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", "scroll back" },
    ["<C-f>"] = { "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", "scroll forward" },
    ["<C-j>"] = { "<cmd>Lspsaga diagnostic_jump_next<CR>", "jump next" },
    ["<C-k>"] = { "<cmd>Lspsaga diagnostic_jump_prev<CR>", "jump prev" },
  }, { buffer = buffer })

  if client.resolved_capabilities.document_formatting then
    vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()"
  end
end

return conf
