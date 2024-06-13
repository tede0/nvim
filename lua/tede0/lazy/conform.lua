return {
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        config = function()
            local options = {
                formatters_by_ft = {
                    lua = { "stylua" },
                    css = { "prettier" },
                    html = { "prettier" },
                    javascript = { "prettier" },
                    javascriptreact = { "prettier" },
                    typescript = { "prettier" },
                    typescriptreact = { "prettier" },
                    python = { "black", "isort" },
                    go = { "goimports-reviser", "gofmt" },
                    sql = { "sql_formatter" },
                    php = { "pint", "blade-formatter" },
                    elixir = { "mix" },
                },

                format_on_save = {
                    timeout_ms = 500,
                    lsp_fallback = true,
                },
            }

            require("conform").setup(options)
        end,
    },
}
