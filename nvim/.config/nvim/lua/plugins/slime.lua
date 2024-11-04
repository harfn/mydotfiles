-- slime-config.lua
return {
    "jpalardy/vim-slime",
    config = function()
        -- Setze das Ziel für vim-slime auf WezTerm
        vim.g.slime_target = "wezterm"

        -- Standardkonfiguration für das WezTerm-Pane (Richtung rechts)
        vim.g.slime_default_config = {
            pane_direction = "right",
        }

        -- Aktivieren von bracketed-paste für korrekten Textversand
        vim.g.slime_bracketed_paste = 1
    end,




}
