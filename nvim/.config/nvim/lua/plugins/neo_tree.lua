
return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons", -- zuvor falsch benannt, sollte kyazdani42/nvim-web-devicons sein
            "MunifTanjim/nui.nvim",
        },
        config = function()
            -- Setup für NeoTree
            require("neo-tree").setup({
              sources = {
                "filesystem", "buffers", "git_status"
              },
              filesystem = {
                filtered_items = {
                  hide_dotfiles = false,  -- Default-Zustand auf "false" setzen, um versteckte Dateien zu sehen
                  hide_gitignored = true,
                },
                follow_current_file = {
                    enabled = true  -- Neue Struktur
                }
              },
              -- Weitere Konfigurationen...
            })

            -- Funktion zur Umschaltung der Sichtbarkeit versteckter Dateien
            local function ToggleHiddenFiles()
                local nt_config = require("neo-tree.sources.manager").get_source("filesystem").config.filtered_items
                nt_config.hide_dotfiles = not nt_config.hide_dotfiles
                require("neo-tree").refresh("filesystem")
            end

            -- Tastenkombinationen
            vim.api.nvim_set_keymap('n', '<Leader>th', '<cmd>lua ToggleHiddenFiles()<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<Leader>tw', ':Neotree toggle reveal_force_cwd<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<Leader>tt', ':Neotree <CR>', { noremap = true, silent = true })
        end
    }
}

