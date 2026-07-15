local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<leader>vd", function()
  require("config.theme").toggle_ide_theme()
end, { desc = "Toggle theme" })

map("n", "K", vim.lsp.buf.hover, opts)
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
map("n", "gd", vim.lsp.buf.definition, opts)
map("n", "gD", vim.lsp.buf.declaration, opts)
map("n", "gr", vim.lsp.buf.references, opts)
map("n", "gi", vim.lsp.buf.implementation, opts)
map("n", "<leader>rn", vim.lsp.buf.rename, opts)
map("n", "<leader>gf", vim.lsp.buf.format, opts)

map("t", "<C-h>", "<C-\\><C-N><C-w>h", opts)
map("t", "<C-j>", "<C-\\><C-N><C-w>j", opts)
map("t", "<C-k>", "<C-\\><C-N><C-w>k", opts)
map("t", "<C-l>", "<C-\\><C-N><C-w>l", opts)

map("n", "<leader>mp", "<cmd>MarkdownPreview<CR>", { desc = "Markdown preview" })
map("n", "<leader>ms", "<cmd>MarkdownPreviewStop<CR>", { desc = "Stop markdown preview" })
map("n", "<leader>mc", ":!pandoc % -o %:r.pdf<CR>", { desc = "Markdown to PDF" })

map("n", "<leader>qp", "<cmd>QuartoPreviewToggle<CR>", { desc = "Quarto preview" })
map({ "n", "v" }, "<leader>qip", function()
  require("config.profiles.nvim_ide.quarto").insert_py_chunk()
end, { desc = "Insert Python chunk" })
map({ "n", "v" }, "<leader>qir", function()
  require("config.profiles.nvim_ide.quarto").insert_r_chunk()
end, { desc = "Insert R chunk" })
map({ "n", "v" }, "<leader>qib", function()
  require("config.profiles.nvim_ide.quarto").insert_bash_chunk()
end, { desc = "Insert Bash chunk" })
map({ "n", "v" }, "<leader>qio", function()
  require("config.profiles.nvim_ide.quarto").insert_ojs_chunk()
end, { desc = "Insert OJS chunk" })

map("n", "<leader><CR>", function()
  if vim.bo.filetype == "quarto" then
    require("config.profiles.nvim_ide.quarto").send_cell()
    return
  end

  local keys = vim.api.nvim_replace_termcodes("<Plug>SlimeLineSend", true, false, true)
  vim.api.nvim_feedkeys(keys, "n", false)
end, { desc = "Send cell or line" })
map("v", "<leader><CR>", "<Plug>SlimeRegionSend", { desc = "Send selection" })
map("n", "<leader>sf", "ggVG:SlimeSend<CR>", { remap = true, desc = "Send full buffer" })
map("n", "<leader>sl", "<Plug>SlimeLineSend", { remap = true, desc = "Send line" })
map("n", "<leader>sp", "<Plug>SlimeParagraphSend", { remap = true, desc = "Send paragraph" })
map("n", "<leader>s<CR>", "<Plug>SlimeConfig", { remap = true, desc = "Slime config" })

map("n", "<leader>th", function()
  require("neo-tree.command").execute({ toggle = false, action = "show", source = "filesystem" })
  local manager = require("neo-tree.sources.manager")
  local state = manager.get_state("filesystem")
  state.filtered_items.hide_dotfiles = not state.filtered_items.hide_dotfiles
  require("neo-tree.sources.filesystem").refresh(state)
end, { desc = "Toggle hidden files" })
map("n", "<leader>tw", "<cmd>Neotree toggle reveal_force_cwd<CR>", { desc = "Toggle file tree" })
map("n", "<leader>tt", "<cmd>Neotree<CR>", { desc = "Open file tree" })
