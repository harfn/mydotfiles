return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "pyright", "beancount", "marksman", "r_language_server" },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
            })
            lspconfig.pyright.setup({
                capabilities = capabilities,
            })
            lspconfig.beancount.setup({
                capabilities = capabilities,
            })
            lspconfig.marksman.setup({
                capabilities = capabilities,
            })
            lspconfig.r_language_server.setup({
                capabilities = capabilities,
                settings = {
                    r = {
                        rpath = {
                            linux = "/usr/bin/R", -- Setze hier den Pfad, den du mit "which R" erhalten hast
                        },
                    },
                },
            })
            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
        end,
    },
}
