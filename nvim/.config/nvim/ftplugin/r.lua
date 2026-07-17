if vim.env.NVIM_PROFILE ~= "nvim_ide" then
  return
end

local opts = { silent = true, buffer = true }

vim.keymap.set("n", "<C-c><C-c>", function()
  require("config.profiles.nvim_ide.herdr").send_line()
end, opts)
vim.keymap.set("v", "<C-c><C-c>", function()
  require("config.profiles.nvim_ide.herdr").send_visual()
end, opts)

vim.keymap.set("n", "<localleader>ss", "<cmd>HerdrSetPane<CR>", opts)
vim.keymap.set("n", "<localleader>rr", function()
  require("config.profiles.nvim_ide.herdr").send_line()
end, opts)
vim.keymap.set("v", "<localleader>rr", function()
  require("config.profiles.nvim_ide.herdr").send_visual()
end, opts)
