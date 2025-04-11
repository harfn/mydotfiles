-- lua/keybindings.lua

-- Optionen für die Tastenkombinationen
local opts = { noremap = true, silent = true }

-- Kurzschreibweise für set_keymap
local keymap = vim.api.nvim_set_keymap

-- Leader key setzen
vim.g.mapleader = " " -- Leerzeichen als Leader

-- Normal mode Keybindings
-- Fenster-Navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Fenstergrößen ändern
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Buffer-Navigation
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Speichern und Beenden
--keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>q", ":q<CR>", opts)
keymap("n", "<leader>x", ":bp<bar>sp<bar>bn<bar>bd<CR>", opts)

-- Insert mode Keybindings
-- Mit 'jk' den Insert mode verlassen
keymap("i", "jk", "<ESC>", opts)
-- Visual mode Keybindings
-- In Indent-Modus bleiben
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Visual Block mode Keybindings
-- Text nach oben und unten verschieben
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

-- Keybindings für Plugins
local wk = require("which-key")
wk.add({

-- Telescope Bindings
	{ "<leader>f", group = "(F)ind with Telescope" },
	{
		"<leader>fb",
		"<cmd>Telescope buffers<cr>",
		desc = "Find Buffers",
	},
	{
		"<leader>ff",
		"<cmd>Telescope find_files<cr>",
		desc = "Find Files",
	},
	{
		"<leader>fg",
		"<cmd>Telescope live_grep<cr>",
		desc = "Live Grep",
	},
	{
		"<leader>fh",		"<cmd>Telescope find_files hidden=true<cr>",
		desc = "Find Hidden Files",
	},
	{
		"<leader>fo",
		"<cmd>Telescope oldfiles<cr>",
		desc = "Old Files",
	},
	{
		"<leader>fn",
		"<cmd>lua require('telescope.builtin').find_files({ cwd = vim.fn.stdpath('config') })<cr>",
		desc = "Find in Config",
	},
    -- Markdown
	{ "<leader>m", group = "Markdown", icon = '󰍔' },
    {
		"<leader>mp",
		"<cmd>MarkdownPreview<CR>",
		desc = "Start Preview",
	},
    {
		"<leader>ms",
		"<cmd>MarkdownPreviewStop<CR>",
		desc = "Stop Preview",
	},
    { "<leader>v", group = "(V)im Optionen" },
    {
		"<leader>vs",
		"<cmd>lua vim.wo.spell = not vim.wo.spell<CR>",
		desc = "(S)pell aktivieren/togglen",
	},

})

-- LSP Bindings
vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, opts)

-- Terminal mode Keybindings
-- Terminal-Navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", opts)

-- Keybindings für nvim-R
vim.api.nvim_set_keymap("n", "<leader>r<CR>", ":RStart<CR>", { noremap = true, silent = true }) -- Startet die R-REPL
vim.api.nvim_set_keymap("n", "<leader>rf", ":call RSendFile()<CR>", { noremap = true, silent = true }) -- Sendet die gesamte Datei an R
vim.api.nvim_set_keymap("n", "<leader>rl", ":call RSendLine()<CR>", { noremap = true, silent = true }) -- Sendet die aktuelle Linie an R
vim.api.nvim_set_keymap("n", "<leader>rr", ":call RSendSelection()<CR>", { noremap = true, silent = true }) -- Sendet die markierte Auswahl an R

-- Slime
keymap("n", "<leader>sf", "ggVG:SlimeSend<CR>", opts)
-- SlimeSend mit <Leader><Enter> im Normalmodus
--keymap("n", "<leader><CR>", [[:lua SlimeCeckSendPara()<CR>]], opts)
keymap("n", "<leader><CR>", "<Plug>SlimeParagraphSend))", opts)
keymap("n", "<leader>sl", "<Plug>SlimeLineSend", opts)
keymap("v", "<leader><CR>", "<Plug>SlimeRegionSend", opts)
keymap("n", "<leader>sp", "<Plug>SlimeParagraphSend", opts)
keymap("n", "<leader>s<CR>", "<Plug>SlimeConfig", opts)

-- Keybinding oder Command
--vim.api.nvim_set_keymap("n", "<leader>ss", [[:lua GetSlimePane()<CR>]], { noremap = true, silent = true })

-- Toggle Colorscheme
keymap("n", "<leader>d", ":lua ToggleColorscheme()<CR>", opts)

-- Konvertierung von Markdown zu PDF mit Pandoc
keymap("n", "<leader>mp", ":!pandoc % -o %:r.pdf<CR>", opts)


-- luasnip
-- Für Insert- und Select-Modus: 
keymap("i", "<Tab>", "v:lua.require'luasnip'.jump(1)", opts)
keymap("s", "<Tab>", "v:lua.require'luasnip'.jump(1)", opts)
keymap("i", "<S-Tab>", "v:lua.require'luasnip'.jump(-1)", opts)
keymap("s", "<S-Tab>", "v:lua.require'luasnip'.jump(-1)", opts)
