local M = {}

local cmp_enabled = true
local spell_enabled = false

local function get_sources(cmp)
  local sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }
  if spell_enabled then
    table.insert(sources, { name = "spell" })
  end
  return cmp.config.sources(sources, {
    { name = "buffer" },
  })
end

function M.setup()
  local cmp = require("cmp")
  local luasnip = require("luasnip")

  require("luasnip.loaders.from_vscode").lazy_load()

  cmp.setup({
    enabled = function()
      local ft = vim.bo.filetype
      if ft == "markdown" or ft == "vimwiki" then
        if vim.b.cmp_markdown_enabled ~= nil then
          return vim.b.cmp_markdown_enabled
        end
        return false
      end
      return cmp_enabled
    end,
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = false }),
      ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    }),
    sources = get_sources(cmp),
  })
end

function M.toggle_completion()
  local ft = vim.bo.filetype
  if ft == "markdown" or ft == "vimwiki" then
    vim.b.cmp_markdown_enabled = not (vim.b.cmp_markdown_enabled or false)
    vim.notify("cmp for " .. ft .. ": " .. (vim.b.cmp_markdown_enabled and "on" or "off"))
    return
  end

  cmp_enabled = not cmp_enabled
  vim.notify("cmp global: " .. (cmp_enabled and "on" or "off"))
end

function M.toggle_spell_source()
  local cmp = require("cmp")
  spell_enabled = not spell_enabled
  cmp.setup({ sources = get_sources(cmp) })
  vim.notify("cmp spell: " .. (spell_enabled and "on" or "off"))
end

function M.tab()
  local luasnip = require("luasnip")
  if luasnip.jumpable(1) then
    luasnip.jump(1)
    return ""
  end
  return "    "
end

function M.shift_tab()
  require("luasnip").jump(-1)
end

function M.select_tab()
  require("luasnip").jump(1)
end

return M
