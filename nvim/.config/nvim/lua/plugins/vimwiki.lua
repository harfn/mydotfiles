return {
    "vimwiki/vimwiki", -- Name des Plugins
    lazy = false,      -- Das Plugin wird sofort geladen (optional)
    init = function()
        -- VimWiki-Konfiguration
        vim.g.vimwiki_list = {
            {
                path = '~/vimwiki/',  -- Standardverzeichnis für dein Wiki
                syntax = 'markdown', -- Markdown-Syntax verwenden
                ext = 'md',          -- Dateiendung für die Notizen
            }
        }
    end,
}
