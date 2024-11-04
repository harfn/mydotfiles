-- plugins/markdown.lua

return {
	{
		"plasticboy/vim-markdown",
		ft = "markdown",
		config = function()
			vim.g.vim_markdown_folding_disabled = 1
			vim.g.vim_markdown_conceal = 2
			vim.g.vim_markdown_frontmatter = 1
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		ft = "markdown",
		config = function()
			vim.g.mkdp_auto_start = 1
			vim.g.mkdp_auto_close = 1
		end,
	},
	{
		"dhruvasagar/vim-table-mode",
		ft = "markdown",
		config = function()
			vim.g.table_mode_corner = "|"
			vim.api.nvim_set_keymap("n", "<leader>tm", ":TableModeToggle<CR>", { noremap = true, silent = true })
		end,
	},
}
