local set = require "utils.set"

return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = set(function()
      vim.fn["mkdp#util#install"]()
    end),
  },
  {
    "OXY2DEV/markview.nvim",
    ft = "markdown",

    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
