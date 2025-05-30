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
			require("luasnip.loaders.from_vscode").lazy_load()
			local ls = require("luasnip")
			ls.filetype_extend("vimwiki", { "markdown" })

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
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
					["<CR>"] = cmp.mapping.confirm({ select = false }), -- Enter fügt nur ein, wenn etwas ausgewählt ist
					["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" }, -- For luasnip users.
					{ name = "spell" }, -- <== Neu: Spell-Vorschläge
				}, {
					{ name = "buffer" },
				}),
			})
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
