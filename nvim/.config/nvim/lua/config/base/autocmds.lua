vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "txt", "gitcommit", "text" },
  callback = function()
    vim.opt_local.spell = true
  end,
})
