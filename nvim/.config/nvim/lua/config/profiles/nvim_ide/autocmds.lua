vim.api.nvim_create_autocmd("FileType", {
  pattern = "quarto",
  callback = function()
    vim.keymap.set("n", "<Tab>", function()
      require("config.profiles.nvim_ide.quarto").goto_next_code_block()
    end, { buffer = true, desc = "Next code chunk" })
  end,
})
