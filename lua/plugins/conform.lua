local set = require "utils.set"

local prettier = { "prettierd", "prettier", stop_after_first = true }
local function find_config(bufnr, config_files)
  return vim.fs.find(config_files, {
    upward = true,
    stop = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)),
    path = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)),
  })[1]
end
local function biome_or_prettier(bufnr)
  local has_biome = find_config(bufnr, { "biome.json", "biome.jsonc" })
  if has_biome then
    return { "biome" }
  end
  local has_prettier = find_config(bufnr, {
    -- https://prettier.io/docs/en/configuration.html
    ".prettierrc",
    ".prettierrc.json",
    ".prettierrc.yml",
    ".prettierrc.yaml",
    ".prettierrc.json5",
    ".prettierrc.js",
    ".prettierrc.cjs",
    ".prettierrc.mjs",
    ".prettierrc.toml",
    ".prettierrc.ts",
    ".prettierrc.cts",
    ".prettierrc.mts",
    "prettier.config.js",
    "prettier.config.cjs",
    "prettier.config.ts",
    "prettier.config.mjs",
  })
  if has_prettier then
    return prettier
  end

  -- default
  return { "biome", "prettierd", "prettier", stop_after_first = true }
end

local lspfiles = vim.fn.stdpath "config" .. "/lua/plugins/lspfiles/"
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
    formatters_by_ft = {
      javascript = biome_or_prettier,
      typescript = biome_or_prettier,
      javascriptreact = biome_or_prettier,
      typescreact = biome_or_prettier,
      html = prettier,
      css = biome_or_prettier,
      less = prettier,
      scss = prettier,
      json = biome_or_prettier,
      jsonc = biome_or_prettier,
      yaml = prettier,
      markdown = prettier,
      svelte = prettier,
      bash = { "shfmt" },
      sh = { "shfmt" },
      nix = { "alejandra" },
      lua = { "stylua" },
      rust = { "rustfmt" },
    },
    formatters = {
      prettierd = {},
      shfmt = {
        args = { "-i", "4" },
      },
      biome = {
        append_args = { "--config-path", set(lspfiles .. "biome.json", [[biome.json-path]]) },
      },
      stylua = {
        -- append_args = { "--config-path", set(lspfiles .. "stylua.toml", [[stylua.toml-path]]) },
        append_args = function()
          return { "--config-path", set(lspfiles .. "stylua.toml", [[stylua.toml-path]]) }
        end,
      },
    },
  },
}
