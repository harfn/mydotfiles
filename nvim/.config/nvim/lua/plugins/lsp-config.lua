return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Default-Einstellungen für alle LSPs
      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      -- Lua
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })

      -- R
      vim.lsp.config("r_language_server", {
        settings = {
          r = {
            rpath = { linux = "/usr/bin/R" },
          },
        },
      })

      -- Fortran: erstmal fortls statt fortitude
      vim.lsp.config("fortls", {})

      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "pyright",
          "marksman",
          "r_language_server",
          "bashls",
          "fortls",
        },

        -- Wichtig:
        -- Fortitude ist bei dir installiert, aber deine Version kann kein "fortitude server".
        automatic_enable = {
          exclude = {
            "fortitude",
          },
        },
      })
    end,
  },
}
