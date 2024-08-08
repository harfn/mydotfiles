
return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup {
                ensure_installed = { "lua_ls", "jedi_language_server", "matlab_ls", "marksman", "r_language_server" }
            }
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require('lspconfig')
            -- Konfigurieren des Lua Language Server
            lspconfig.lua_ls.setup({
                -- Hier können Einstellungen hinzugefügt werden, z.B.:
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' }
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true)
                        },
                        telemetry = {
                            enable = false
                        }
                    }
                }
            })
            -- Weitere Language Server können hier ebenfalls konfiguriert werden
            lspconfig.jedi_language_server.setup({})

        end

    }
}

