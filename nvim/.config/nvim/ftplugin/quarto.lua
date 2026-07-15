if vim.env.NVIM_PROFILE ~= "nvim_ide" then
  return
end

local ok, runner = pcall(require, "quarto.runner")
if not ok then
	return
end

local opts = { silent = true, buffer = true }

vim.keymap.set("n", "<localleader>rc", runner.run_cell, vim.tbl_extend("force", opts, { desc = "Quarto: run cell" }))
vim.keymap.set(
	"n",
	"<localleader>rl",
	runner.run_line,
	vim.tbl_extend("force", opts, { desc = "Quarto: run line" })
)
vim.keymap.set(
	"v",
	"<localleader>r",
	runner.run_range,
	vim.tbl_extend("force", opts, { desc = "Quarto: run visual range" })
)
vim.keymap.set("n", "<localleader>rA", function()
	runner.run_all(true)
end, vim.tbl_extend("force", opts, { desc = "Quarto: run all cells (multi-lang)" }))
