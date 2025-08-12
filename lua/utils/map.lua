local map = function(mode, key, func, desc, opts)
  local options = { silent = true }
  if desc then
    options = vim.tbl_extend("force", options, { desc = desc })
  end
  options = vim.tbl_extend("force", options, opts or {})
  vim.keymap.set(mode, key, func, options)
end

return map
