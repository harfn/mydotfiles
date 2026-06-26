local opts = { silent = true, buffer = true }

-- Standard-Slime-Shortcut für Python: Ctrl-c Ctrl-c
vim.keymap.set("n", "<C-c><C-c>", "<Plug>SlimeLineSend", opts)
vim.keymap.set("v", "<C-c><C-c>", "<Plug>SlimeRegionSend", opts)

-- Lokale Convenience-Mappings für Slime
vim.keymap.set("n", "<localleader>ss", ":SlimeConfig<CR>", opts)
vim.keymap.set("n", "<localleader>rr", "<Plug>SlimeLineSend", opts)
vim.keymap.set("v", "<localleader>rr", "<Plug>SlimeRegionSend", opts)

