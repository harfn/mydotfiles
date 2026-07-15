require("config.base")

local profile = require("config.profile").current()
local plugin_imports = {
  { import = "plugins.base" },
}

if profile == "nvim_ide" then
  require("config.profiles.nvim_ide")
  table.insert(plugin_imports, { import = "plugins.profiles.nvim_ide" })
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(plugin_imports)
