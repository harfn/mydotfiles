return {
    "vimwiki/vimwiki", -- Name des Plugins
    lazy = false,      -- Das Plugin wird sofort geladen (optional)
    init = function()
        -- VimWiki-Konfiguration
        vim.g.vimwiki_list = {
            {
                path = '~/wiki/',  -- Standardverzeichnis für dein Wiki
                syntax = 'markdown', -- Markdown-Syntax verwenden
                ext = 'md',          -- Dateiendung für die Notizen
            }
        }
        vim.g.vimwiki_global_ext = 0 -- Aktiviert VimWiki nur in dem definierten Verzeichnis
    end,
}
