local failed = {}
for _, l in pairs(PO.enabledLanguages or {}) do
  local loaded = pcall(require, "lsp." .. l)
  if not loaded then
    table.insert(failed, l)
  end
end

if vim.tbl_isempty(failed) then
  print "all LSPs loaded successfully"
else
  for _, f in pairs(failed) do
    print("failed to load lsp: " .. f)
  end
end
