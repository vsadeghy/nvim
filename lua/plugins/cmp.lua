local cmp = require "cmp"
local luasnip = require "luasnip"
local lspkind = require "lspkind"
require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

local cmpconf = {
  kind_icons = {
    Text = " ",
    Function = " ",
    Method = " ",
    Constructor = " ",
    Field = " ",
    Variable = " ",
    Class = " ",
    Interface = " ",
    Module = " ",
    Property = " ",
    Unit = " ",
    Value = " ",
    Enum = " ",
    Keyword = " ",
    Snippet = " ",
    Color = " ",
    File = " ",
    Reference = " ",
    Folder = " ",
    EnumMember = " ",
    Constant = " ",
    Struct = " ",
    Event = " ",
    Operator = " ",
    TypeParameter = " ",
  },
  source_names = {
    nvim_lsp = "(LSP)",
    emoji = "(Emoji)",
    path = "(Path)",
    calc = "(Calc)",
    cmp_tabnine = "(Tabnine)",
    vsnip = "(vsnip)",
    luasnip = "(luasnip)",
    buffer = "(Buffer)",
  },
  duplicates = {
    buffer = 1,
    path = 1,
    nvim_lsp = 0,
    luasnip = 1,
  },
  duplicates_default = 0,
}

local format = {
  lspkind = lspkind.cmp_format {
    with_text = false,
    maxwidth = 50,
    before = function(entry, vim_item)
      vim_item.menu = cmpconf.source_names[entry.source.name]
      vim_item.dup = cmpconf.duplicates[entry.source.name] or cmpconf.duplicates_default
      return vim_item
    end,
  },
  normal = function(entry, vim_item)
    vim_item.kind = cmpconf.kind_icons[vim_item.kind]
    vim_item.menu = cmpconf.source_names[entry.source.name]
    vim_item.dup = cmpconf.duplicates[entry.source.name] or cmpconf.duplicates_default
    return vim_item
  end,
}

cmp.setup {
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  completion = {
    keyword_length = 1,
  },
  experimental = {
    ghost_text = true,
    native_menu = false,
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    kind_icons = cmpconf.kind_icons,
    source_names = cmpconf.source_names,
    duplicates = cmpconf.duplicates,
    duplicates_default = cmpconf.duplicates_default,
    format = format.normal
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "cmp_tabnine" },
    { name = "nvim_lua" },
    { name = "buffer" },
    { name = "path" },
    { name = "calc" },
    { name = "emoji" },
    { name = "treesitter" },
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  -- documentation = false,
  window = {
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    }
  },
  mapping = {
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-u>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<C-e>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm { select = true },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
}
