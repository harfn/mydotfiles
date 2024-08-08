
-- Datei: ~/.config/nvim/lua/ayu_setup.lua

return {
    {
        "Shatur/neovim-ayu",
        config = function()
            -- Konfiguriere das Ayu Farbschema
            vim.cmd("colorscheme ayu-mirage")
            vim.opt.termguicolors = true  -- Aktiviere True Color Unterstützung

            -- Setze das Ayu-Farbschema und die bevorzugte Farbvariante
            vim.g.ayucolor = "mirage"  -- Global variable for the theme color

        end
    }
}

