-- Grundlegende Einstellungen vor dem Laden der Plugins
vim.g.mapleader = " "
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set encoding=UTF-8")
vim.cmd("set background=light")
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set softtabstop=4")

function ToggleColorscheme()
    if vim.g.colors_name == "ayu" then
        vim.opt.background = "light"
        vim.cmd("colorscheme gruvbox")
    else
        vim.opt.background = "dark"
        vim.cmd("colorscheme ayu-mirage")
    end
end

-- Füge die Tastenkombination hinzu
vim.api.nvim_set_keymap("n", "<leader>d", ":lua ToggleColorscheme()<CR>", { noremap = true, silent = true })
