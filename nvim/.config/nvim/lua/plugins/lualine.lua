
return {
    'nvim-lualine/lualine.nvim',
    config = function()
        require('lualine').setup {
            options = {
                theme = 'ayu_mirage'
                -- Weitere Optionen hier einfügen, wie z.B. Abschnittskonfigurationen
            }
        }
    end
}

