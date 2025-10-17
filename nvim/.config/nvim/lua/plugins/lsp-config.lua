return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"pyright",
					"marksman",
					"r_language_server",
					"r_language_server",
					"bashls",
				},
			})
		end,
	},



{
  "neovim/nvim-lspconfig",
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    local servers = {
      lua_ls = {},
      pyright = {},
      beancount = {},
      marksman = {},
      bashls = {},
      r_language_server = {
        settings = {
          r = {
            rpath = { linux = "/usr/bin/R" },
          },
        },
      },
    }

    -- Prüfen, welche API verfügbar ist
    local has_new_api = vim.lsp and vim.lsp.config and type(vim.lsp.config) == "table"

    if has_new_api then
      -- 🌟 neue, zukunftssichere API
      for name, opts in pairs(servers) do
        opts.capabilities = capabilities
        if vim.lsp.config[name] then
          vim.lsp.config[name].setup(opts)
        else
          vim.notify("No config for LSP server: " .. name, vim.log.levels.WARN)
        end
      end
    else
      -- 🧩 fallback: alte API (keine Fehler, nur Warnung)
      local ok, lspconfig = pcall(require, "lspconfig")
      if not ok then
        vim.notify("nvim-lspconfig not found!", vim.log.levels.ERROR)
        return
      end

      for name, opts in pairs(servers) do
        opts.capabilities = capabilities
        if lspconfig[name] and lspconfig[name].setup then
          lspconfig[name].setup(opts)
        else
          vim.notify("LSP server not available: " .. name, vim.log.levels.WARN)
        end
      end
    end
  end,
},


}
