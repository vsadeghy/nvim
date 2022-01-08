local present, packer = pcall(require, "packer")
if not present then
  local packer_path = DATA_PATH .. "/site/pack/packer/opt/packer.nvim"

  print "Cloning packer.."
  -- remove the dir before cloning
  vim.fn.delete(packer_path, "rf")
  vim.fn.system {
    "git",
    "clone",
    "https://github.com/wbthomason/packer.nvim",
    "--depth",
    "1",
    packer_path,
  }

  present, packer = pcall(require, "packer")

  if present then
    print "Packer cloned successfully."
  else
    error("Couldn't clone packer !\nPacker path: " .. packer_path)
  end
end

packer.init {
  compile_path = vim.fn.stdpath "config" .. "/lua/packer_compiled.lua",
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
    prompt_border = "rounded",
  },
  git = {
    clone_timeout = 600, -- Timeout, in seconds, for git clones
  },
}

require "plugins"
