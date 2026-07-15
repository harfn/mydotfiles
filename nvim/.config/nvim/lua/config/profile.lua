local M = {}

local VALID_PROFILES = {
  base = true,
  nvim_ide = true,
}

function M.current()
  local profile = vim.env.NVIM_PROFILE or "base"
  if VALID_PROFILES[profile] then
    return profile
  end

  vim.notify(
    string.format("Unknown NVIM_PROFILE=%s, falling back to base", profile),
    vim.log.levels.WARN
  )
  return "base"
end

return M
