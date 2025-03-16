local border = {
  { "╭", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╮", "FloatBorder" },
  { "│", "FloatBorder" },
  { "╯", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╰", "FloatBorder" },
  { "│", "FloatBorder" },
}

local update_border = function()
  local orig_floating_preview = vim.lsp.util.open_floating_preview

  ---@diagnostic disable-next-line: duplicate-set-field
  function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    ---@class opts border
    opts = opts or {}
    opts.border = opts.border or border
    return orig_floating_preview(contents, syntax, opts, ...)
  end
end

return {
  border = border,
  update_border = update_border,
}
