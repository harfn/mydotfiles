local M = {}

function M.is_code_chunk()
  local current = require("otter.keeper").get_current_language_context()
  return current ~= nil
end

function M.insert_code_chunk(lang)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
  local keys
  if M.is_code_chunk() then
    keys = [[o```<cr><cr>```{]] .. lang .. [[}<esc>o]]
  else
    keys = [[o```{]] .. lang .. [[}<cr>```<esc>O]]
  end
  keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
  vim.api.nvim_feedkeys(keys, "n", false)
end

function M.wrap_visual_code_chunk(lang)
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  vim.api.nvim_buf_set_lines(0, start_line - 1, start_line - 1, false, { "```{" .. lang .. "}" })
  vim.api.nvim_buf_set_lines(0, end_line + 1, end_line + 1, false, { "```" })
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
end

function M.smart_insert_code_chunk(lang)
  local mode = vim.fn.mode()
  if mode == "V" or mode == "v" then
    return M.wrap_visual_code_chunk(lang)
  end
  return M.insert_code_chunk(lang)
end

function M.insert_r_chunk()
  return M.smart_insert_code_chunk("r")
end

function M.insert_py_chunk()
  return M.smart_insert_code_chunk("python")
end

function M.insert_bash_chunk()
  return M.smart_insert_code_chunk("bash")
end

function M.insert_ojs_chunk()
  return M.smart_insert_code_chunk("ojs")
end

function M.send_cell()
  if vim.b.quarto_is_r_mode == nil then
    require("config.profiles.nvim_ide.herdr").send_cell()
    return
  end

  if vim.b.quarto_is_r_mode == true then
    local is_python = require("otter.tools.functions").is_otter_language_context("python")
    if is_python and not vim.b.reticulate_running then
      require("config.profiles.nvim_ide.herdr").send_text("reticulate::repl_python()")
      vim.b.reticulate_running = true
    elseif not is_python and vim.b.reticulate_running then
      require("config.profiles.nvim_ide.herdr").send_text("exit")
      vim.b.reticulate_running = false
    end
    require("config.profiles.nvim_ide.herdr").send_cell()
  end
end

function M.goto_next_code_block()
  local next_pos = vim.fn.search("^```{", "W")
  if next_pos == 0 then
    vim.notify("Kein weiterer Codeblock gefunden.")
  end
end

return M
