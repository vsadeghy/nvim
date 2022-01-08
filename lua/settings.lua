for k, v in pairs(O or {}) do
  vim.o[k] = v
end

for k, v in pairs(G or {}) do
  vim.g[k] = v
end

vim.cmd [[
  silent! command Bd bp|bd #
  silent! command BD bp|bd #
  silent! command PI PackerInstall
  silent! command BON silent! %bd|edit #|normal `"
]]
