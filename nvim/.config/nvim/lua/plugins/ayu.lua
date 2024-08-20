return {
    {
        "Shatur/neovim-ayu",
        config = function()
            -- Konfiguriere das Ayu Farbschema
            vim.cmd("colorscheme ayu-mirage")
            vim.opt.termguicolors = true -- Aktiviere True Color Unterstützung
            vim.g.ayucolor = "mirage" -- Globale Variable für die Farbauswahl
        end,
    },
    {
        "altercation/vim-colors-solarized",
        config = function()
            -- Optional: Hier kannst du weitere Konfigurationen hinzufügen
        end,
    },
    {
        "morhetz/gruvbox",
        config = function()
            vim.g.gruvbox_contrast_light = "soft" -- Weicher Kontrast für einen wärmeren Look
        end,
    },
}
