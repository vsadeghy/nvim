local set = function(nonNix, nix)
  if vim.g.nix then
    return nix
  else
    return nonNix
  end
end

return set
