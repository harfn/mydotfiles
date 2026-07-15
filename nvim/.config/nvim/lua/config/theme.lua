local M = {}

local function set_lualine_theme(theme)
  local ok, lualine = pcall(require, "lualine")
  if ok then
    lualine.setup({
      options = {
        theme = theme,
      },
    })
  end
end

function M.apply_base_theme()
  vim.opt.termguicolors = true
  vim.g.ayucolor = "dark"
  vim.opt.background = "dark"
  vim.cmd.colorscheme("ayu")
  set_lualine_theme("auto")
end

function M.apply_ide_theme(variant)
  local target = variant or vim.g.nvim_ide_theme or "gruvbox_dark"

  if target == "gruvbox_light" then
    vim.opt.background = "light"
  else
    target = "gruvbox_dark"
    vim.opt.background = "dark"
  end

  vim.g.nvim_ide_theme = target
  vim.g.gruvbox_contrast_light = "soft"
  vim.cmd.colorscheme("gruvbox")
  set_lualine_theme("auto")
end

function M.toggle_ide_theme()
  if vim.g.nvim_ide_theme == "gruvbox_light" then
    M.apply_ide_theme("gruvbox_dark")
  else
    M.apply_ide_theme("gruvbox_light")
  end
end

return M
