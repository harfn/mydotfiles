return {
    {
        'jalvesaq/Nvim-R',
         enabled = false,
        --ft = { 'r', 'rmd' }, -- Lädt das Plugin nur bei R-Dateien oder RMarkdown
        config = function()
            -- vim.g.R_assign = 0   -- Deaktiviert das automatische Ersetzen von "<-" durch "=" (optional)
            vim.g.R_nvim_wd = 1   -- Setzt das Arbeitsverzeichnis von R auf das Neovim-Arbeitsverzeichnis
        end
    }
}

