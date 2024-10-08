return{
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.6",
        dependencies = {"nvim-lua/plenary.nvim"},
        config = function()
            -- Konfiguriere Tastenkombinationen für Telescope
            vim.keymap.set('n', '<Leader>ff', '<cmd>Telescope find_files<cr>', { noremap = true, silent = true })
            vim.keymap.set('n', '<Leader>fo', '<cmd>Telescope oldfiles<cr>', { noremap = true, silent = true })
            vim.keymap.set('n', '<Leader>fl', '<cmd>Telescope live_grep<cr>', { noremap = true, silent = true })

        end},
    {
        'nvim-telescope/telescope-ui-select.nvim',

        config = function()
            require("telescope").setup {
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {
                        }
                    }
                }
            }
            require("telescope").load_extension("ui-select")

        end
    }

}
