return {
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},
	{
		"f3fora/cmp-spell",
		dependencies = {
			"hrsh7th/nvim-cmp",
		},
	},

	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			local ls = require("luasnip")

			require("luasnip.loaders.from_vscode").lazy_load()
			ls.filetype_extend("vimwiki", { "markdown" })

			-- Zustand (Flags)
			local cmp_enabled = true -- global an/aus
			local spell_enabled = false -- spell-Quelle an/aus

			-- Quellen dynamisch zusammenbauen
			local function get_sources()
				local sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}
				if spell_enabled then
					table.insert(sources, { name = "spell" })
				end
				return cmp.config.sources(sources, {
					{ name = "buffer" },
				})
			end

			cmp.setup({
				-- hier steuern wir, ob cmp überhaupt läuft
				enabled = function()
					local ft = vim.bo.filetype

					-- markdown & vimwiki: standardmäßig AUS
					if ft == "markdown" or ft == "vimwiki" then
						if vim.b.cmp_markdown_enabled ~= nil then
							return vim.b.cmp_markdown_enabled
						end
						return false
					end

					-- alle anderen Filetypes: globales Flag
					return cmp_enabled
				end,

				snippet = {
					expand = function(args)
						ls.lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = false }),
					["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				}),
				sources = get_sources(),
			})

			-- <leader>vc : cmp an/aus
			vim.keymap.set("n", "<leader>vc", function()
				local ft = vim.bo.filetype

				-- in markdown/vimwiki: buffer-lokal toggeln
				if ft == "markdown" or ft == "vimwiki" then
					vim.b.cmp_markdown_enabled = not (vim.b.cmp_markdown_enabled or false)
					vim.notify("cmp für " .. ft .. ": " .. (vim.b.cmp_markdown_enabled and "AN" or "AUS"))
				else
					-- sonst: global toggeln
					cmp_enabled = not cmp_enabled
					vim.notify("cmp global: " .. (cmp_enabled and "AN" or "AUS"))
				end
			end, { desc = "[v]im: Toggle [c]ompletion" })

			-- <leader>vS : spell-Quelle in cmp an/aus
			vim.keymap.set("n", "<leader>vS", function()
				spell_enabled = not spell_enabled
				cmp.setup({ sources = get_sources() })
				vim.notify("cmp spell: " .. (spell_enabled and "AN" or "AUS"))
			end, { desc = "[v]im: Toggle cmp [S]pell source" })
		end,
	},
	{
		--[[
        Überprüft beim Drücken von <Tab> im Insertmode, ob ein Snippet-Sprung möglich ist. Wenn ja,
        wird zum nächsten Platzhalter gewechselt, andernfalls werden 4 Leerzeichen eingefügt.Dies
        passt das Verhalten der <Tab>-Taste kontextsensitiv an (Snippets vs. normalen Einzug).
        --]]
		vim.keymap.set("i", "<Tab>", function()
			if require("luasnip").jumpable(1) then
				require("luasnip").jump(1)
				return ""
			else
				return "    " -- 4 Leerzeichen als Fallback
			end
		end, { expr = true, noremap = true }),
	},
}
