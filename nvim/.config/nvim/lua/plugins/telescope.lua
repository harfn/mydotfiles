return{
        "nvim-telescope/telescope.nvim",
        tag = "0.1.6",
        dependencies = {"nvim-lua/plenary.nvim"},
      config = function()
            -- Konfiguriere Tastenkombinationen für Telescope
        vim.keymap.set('n', '<Leader>ff', '<cmd>Telescope find_files<cr>', { noremap = true, silent = true })
        vim.keymap.set('n', '<Leader>fo', '<cmd>Telescope oldfiles<cr>', { noremap = true, silent = true })
        vim.keymap.set('n', '<Leader>fl', '<cmd>Telescope live_grep<cr>', { noremap = true, silent = true })

        end

    }
