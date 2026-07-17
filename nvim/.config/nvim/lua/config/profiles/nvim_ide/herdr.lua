local M = {}
local ESC = string.char(27)
local BRACKETED_PASTE_START = ESC .. "[200~"
local BRACKETED_PASTE_END = ESC .. "[201~"

local function target_pane()
  local pane = vim.g.herdr_repl_pane
  if pane == nil or pane == "" then
    vim.notify("Kein Herdr-Zielpane gesetzt. Erst :HerdrSetPane ausfuehren.", vim.log.levels.WARN)
    return nil
  end
  return pane
end

local function send_text(text)
  local pane = target_pane()
  if not pane then
    return false
  end

  vim.fn.system({
    "herdr",
    "pane",
    "send-text",
    pane,
    text,
  })

  if vim.v.shell_error ~= 0 then
    vim.notify("Herdr send-text fehlgeschlagen", vim.log.levels.ERROR)
    return false
  end

  return true
end

local function send_keys(keys)
  local pane = target_pane()
  if not pane then
    return false
  end

  local cmd = { "herdr", "pane", "send-keys", pane }
  vim.list_extend(cmd, keys)
  vim.fn.system(cmd)

  if vim.v.shell_error ~= 0 then
    vim.notify("Herdr send-keys fehlgeschlagen", vim.log.levels.ERROR)
    return false
  end

  return true
end

local function send_payload(text, use_bracketed_paste)
  if use_bracketed_paste then
    local ok = send_text(BRACKETED_PASTE_START .. text .. BRACKETED_PASTE_END)
    if not ok then
      return false
    end
    return send_keys({ "enter" })
  end
  return send_text(text)
end

local function with_trailing_newline(text)
  if text:sub(-1) == "\n" then
    return text
  end
  return text .. "\n"
end

function M.set_pane()
  local pane = vim.fn.input("Herdr pane id: ", vim.g.herdr_repl_pane or "")
  if pane == "" then
    vim.notify("Aborted.")
    return
  end

  vim.g.herdr_repl_pane = pane
  vim.notify("Herdr target pane -> " .. pane)
end

function M.send_text(text)
  return send_payload(with_trailing_newline(text), false)
end

function M.send_line()
  local line = vim.api.nvim_get_current_line()
  if line == "" then
    return
  end
  send_text(line .. "\n")
end

function M.send_visual()
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  if #lines == 0 then
    return
  end
  send_payload(table.concat(lines, "\n"), true)
end

function M.send_paragraph()
  local start_line = vim.fn.search("^\\s*$", "bnW")
  local end_line = vim.fn.search("^\\s*$", "nW")

  if start_line == 0 then
    start_line = 1
  else
    start_line = start_line + 1
  end

  if end_line == 0 then
    end_line = vim.api.nvim_buf_line_count(0)
  else
    end_line = end_line - 1
  end

  if end_line < start_line then
    return
  end

  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  if #lines == 0 then
    return
  end
  send_payload(table.concat(lines, "\n"), true)
end

function M.send_buffer()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  if #lines == 0 then
    return
  end
  send_payload(table.concat(lines, "\n"), true)
end

function M.send_cell()
  local cursor = vim.api.nvim_win_get_cursor(0)[1]
  local start_line = vim.fn.search("^```", "bnW")
  local end_line = vim.fn.search("^```", "nW")

  if start_line == 0 or end_line == 0 or end_line <= start_line then
    M.send_line()
    return
  end

  if cursor == start_line then
    start_line = start_line + 1
  end

  local lines = vim.api.nvim_buf_get_lines(0, start_line, end_line - 1, false)
  if #lines == 0 then
    return
  end
  send_payload(table.concat(lines, "\n"), true)
end

function M.run_repl(cmd)
  return M.send_text(cmd)
end

function M.run_python_file(path)
  if path == nil or path == "" then
    vim.notify("Datei erst speichern, bevor sie im Herdr-Panel ausgefuehrt wird.", vim.log.levels.WARN)
    return false
  end

  return M.send_text("python " .. vim.fn.shellescape(path))
end

function M.setup()
  vim.api.nvim_create_user_command("HerdrSetPane", M.set_pane, {})
  vim.api.nvim_create_user_command("ReplPy", function()
    M.run_repl("ipython")
  end, {})
  vim.api.nvim_create_user_command("ReplR", function()
    M.run_repl("R")
  end, {})
  vim.api.nvim_create_user_command("ReplBash", function()
    M.run_repl("bash")
  end, {})
end

return M
