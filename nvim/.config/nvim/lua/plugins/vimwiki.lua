return {
	"vimwiki/vimwiki", -- Name des Plugins
	lazy = false, -- Das Plugin wird sofort geladen (optional)
	init = function()
		-- VimWiki-Konfiguration
		vim.g.vimwiki_list = {
			{
				path = "~/wiki/", -- Standardverzeichnis für dein Wiki
				syntax = "markdown", -- Markdown-Syntax verwenden
				ext = "md", -- Dateiendung für die Notizen
			},
			{
				path = "/home/tobias/uni/statistik/wiki/", -- sonder Wiki
				syntax = "markdown", -- Markdown-Syntax verwenden
				ext = "md", -- Dateiendung für die Notizen
                index = "home"
			},
		}
		vim.g.vimwiki_global_ext = 0 -- Aktiviert VimWiki nur in dem definierten Verzeichnis
		-- Nur für Vimwiki-Dateien: <leader>wl fügt [[ ein und startet Omni-Completion
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "vimwiki",
			callback = function()
				vim.keymap.set("n", "<leader>wl", function()
					local termcodes = vim.api.nvim_replace_termcodes("<C-x><C-o>", true, false, true)
					local keys = "i[[" .. termcodes
					vim.api.nvim_feedkeys(keys, "n", false)
				end, { buffer = true, desc = "Vimwiki: Link zu bestehender Seite einfügen" })
			end,
		})
	end,
}
