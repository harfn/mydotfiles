local M = {}

-- Prüft, ob der Cursor in einem Code-Chunk ist.
M.is_code_chunk = function()
	local current, _ = require("otter.keeper").get_current_language_context()
	return current ~= nil
end

-- Fügt im Normalmode einen Code-Chunk ein. Wird der Cursor bereits in einem Chunk verwendet, wird der Chunk gesplittet.
M.insert_code_chunk = function(lang)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "n", true)
	local keys
	if M.is_code_chunk() then
		keys = [[o```<cr><cr>```{]] .. lang .. [[}<esc>o]]
	else
		keys = [[o```{]] .. lang .. [[}<cr>```<esc>O]]
	end
	keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
	vim.api.nvim_feedkeys(keys, "n", false)
end

-- Umhüllt im Visualmode (Zeilen- oder Zeichenmodus) die ausgewählte Region mit einem Code-Chunk.
M.wrap_visual_code_chunk = function(lang)
	local start_line = vim.fn.line("'<")
	local end_line = vim.fn.line("'>")
	vim.api.nvim_buf_set_lines(0, start_line - 1, start_line - 1, false, { "```{" .. lang .. "}" })
	vim.api.nvim_buf_set_lines(0, end_line + 1, end_line + 1, false, { "```" })
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "n", true)
end

-- Entscheidet, ob im Visualmode oder im Normalmode der entsprechende Ansatz genutzt wird.
M.smart_insert_code_chunk = function(lang)
	local mode = vim.fn.mode()
	if mode == "V" or mode == "v" then
		return M.wrap_visual_code_chunk(lang)
	else
		return M.insert_code_chunk(lang)
	end
end

-- Convenience-Funktionen für verschiedene Sprachen:
M.insert_r_chunk = function()
	return M.smart_insert_code_chunk("r")
end
M.insert_py_chunk = function()
	return M.smart_insert_code_chunk("python")
end
M.insert_lua_chunk = function()
	return M.smart_insert_code_chunk("lua")
end
M.insert_julia_chunk = function()
	return M.smart_insert_code_chunk("julia")
end
M.insert_bash_chunk = function()
	return M.smart_insert_code_chunk("bash")
end
M.insert_ojs_chunk = function()
	return M.smart_insert_code_chunk("ojs")
end

-- Sendet den aktuellen Code-Cell via vim-slime.
-- Falls kein R-Modus gesetzt ist, wird die Standardfunktion von vim-slime verwendet.
function M.send_cell()
	if vim.b.quarto_is_r_mode == nil then
		vim.fn["slime#send_cell"]()
		return
	end

	if vim.b.quarto_is_r_mode == true then
		vim.g.slime_python_ipython = 0
		local is_python = require("otter.tools.functions").is_otter_language_context("python")
		if is_python and not vim.b.reticulate_running then
			vim.fn["slime#send"]("reticulate::repl_python()\r")
			vim.b.reticulate_running = true
		elseif not is_python and vim.b.reticulate_running then
			vim.fn["slime#send"]("exit\r")
			vim.b.reticulate_running = false
		end
		vim.fn["slime#send_cell"]()
	end
end

-- Sendet die aktuell markierte visuelle Region via vim-slime.
function M.send_region()
	local cmd = ":<C-u>call slime#send_op(visualmode(), 1)<CR>"
	cmd = vim.api.nvim_replace_termcodes(cmd, true, false, true)
	if vim.bo.filetype ~= "quarto" or vim.b.quarto_is_r_mode == nil then
		vim.cmd("normal " .. cmd)
		return
	end

	if vim.b.quarto_is_r_mode == true then
		vim.g.slime_python_ipython = 0
		local is_python = require("otter.tools.functions").is_otter_language_context("python")
		if is_python and not vim.b.reticulate_running then
			vim.fn["slime#send"]("reticulate::repl_python()\r")
			vim.b.reticulate_running = true
		elseif not is_python and vim.b.reticulate_running then
			vim.fn["slime#send"]("exit\r")
			vim.b.reticulate_running = false
		end
		vim.cmd("normal " .. cmd)
	end
end

function M.goto_next_code_block()
  local next_pos = vim.fn.search("^```{", "W")
  if next_pos == 0 then
    print("Kein weiterer Codeblock gefunden.")
  end
end

return M
