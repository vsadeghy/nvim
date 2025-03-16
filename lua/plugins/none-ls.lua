local on_attach = require("utils.on_attach")

return {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    ft = {
        -- ltrs
        "markdown",
        "txt",
    },
    config = function()
        local none_ls = require("null-ls")
        local bi = none_ls.builtins
        none_ls.setup({
            defaults = {
                update_in_insert = true,
            },
            sources = {
                -- Diagnostics
                bi.diagnostics.checkstyle.with({
                    extra_args = { "-c", "/checkstyle.xml" },
                }),

                bi.diagnostics.ltrs.with({
                    diagnostic_config = {
                        underline = true,
                        virtual_text = false,
                        signs = true,
                        update_in_insert = true,
                    },
                }),
            },
            on_attach = on_attach,
        })
    end,
}
