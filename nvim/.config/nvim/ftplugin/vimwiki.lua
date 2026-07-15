if vim.env.NVIM_PROFILE ~= "nvim_ide" then
  return
end

vim.keymap.set("n", "<leader>wl", function()
  local termcodes = vim.api.nvim_replace_termcodes("<C-x><C-o>", true, false, true)
  vim.api.nvim_feedkeys("i[[" .. termcodes, "n", false)
end, { buffer = true, desc = "Insert link to existing wiki page" })
