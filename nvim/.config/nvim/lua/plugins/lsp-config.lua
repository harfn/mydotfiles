return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  {
    -- wenn bei dir noch "williamboman/mason-lspconfig.nvim" steht, kannst du das auch lassen
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- 🔹 Default-Einstellungen für alle LSPs
      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      -- 🔹 Spezielle Einstellungen für Lua
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })

      -- 🔹 Spezielle Einstellungen für R
      vim.lsp.config("r_language_server", {
        settings = {
          r = {
            rpath = { linux = "/usr/bin/R" }, -- an dein System angepasst
          },
        },
      })

      -- Mason-LSPConfig: installiert & aktiviert die Server
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "pyright",
          "marksman",
          "r_language_server",
          "bashls",
        },
        -- automatic_enable = true ist default, wir müssen es nicht extra setzen
      })
    end,
  },
}
