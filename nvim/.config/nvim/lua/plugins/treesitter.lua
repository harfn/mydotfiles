return {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",  -- Automatische Aktualisierung der Tree-sitter Parsers
        config = function()
            local config = require('nvim-treesitter.configs')
            config.setup{
                ensure_installed = {"python", "lua", "markdown", "r"}, -- Installiere Parsers nur für diese Sprachen
                highlight = {enable = true} -- Aktiviere die Syntax-Hervorhebung
            }
 
    end


    }
