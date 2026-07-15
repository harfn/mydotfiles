return {
  {
    "morhetz/gruvbox",
    lazy = false,
    priority = 1100,
    config = function()
      require("config.theme").apply_ide_theme()
    end,
  },
  {
    "plasticboy/vim-markdown",
    ft = "markdown",
    config = function()
      vim.g.vim_markdown_folding_disabled = 1
      vim.g.vim_markdown_conceal = 2
      vim.g.vim_markdown_frontmatter = 1
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = "markdown",
    config = function()
      vim.g.mkdp_auto_start = 1
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_browser = "firefox"
    end,
  },
  {
    "dhruvasagar/vim-table-mode",
    ft = "markdown",
    config = function()
      vim.g.table_mode_corner = "|"
      vim.keymap.set("n", "<leader>tm", ":TableModeToggle<CR>", { noremap = true, silent = true })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "python",
          "lua",
          "markdown",
          "r",
          "javascript",
          "typescript",
          "json",
        },
        highlight = { enable = true },
      })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        sources = { "filesystem", "buffers", "git_status" },
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = true,
          },
          follow_current_file = {
            enabled = true,
          },
        },
      })
    end,
  },
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

      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })

      vim.lsp.config("r_language_server", {
        settings = {
          r = {
            rpath = { linux = "/usr/bin/R" },
          },
        },
      })

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
        automatic_enable = {
          exclude = { "fortitude" },
        },
      })
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
  },
  {
    "f3fora/cmp-spell",
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      require("luasnip.loaders.from_vscode").lazy_load()

      local cmp_enabled = true
      local spell_enabled = false

      local function get_sources()
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
        sources = get_sources(),
      })

      vim.keymap.set("n", "<leader>vc", function()
        local ft = vim.bo.filetype
        if ft == "markdown" or ft == "vimwiki" then
          vim.b.cmp_markdown_enabled = not (vim.b.cmp_markdown_enabled or false)
          vim.notify("cmp for " .. ft .. ": " .. (vim.b.cmp_markdown_enabled and "on" or "off"))
          return
        end

        cmp_enabled = not cmp_enabled
        vim.notify("cmp global: " .. (cmp_enabled and "on" or "off"))
      end, { desc = "Toggle completion" })

      vim.keymap.set("n", "<leader>vS", function()
        spell_enabled = not spell_enabled
        cmp.setup({ sources = get_sources() })
        vim.notify("cmp spell: " .. (spell_enabled and "on" or "off"))
      end, { desc = "Toggle cmp spell source" })

      vim.keymap.set("i", "<Tab>", function()
        if luasnip.jumpable(1) then
          luasnip.jump(1)
          return ""
        end
        return "    "
      end, { expr = true, noremap = true })

      vim.keymap.set("s", "<Tab>", function()
        luasnip.jump(1)
      end, { silent = true })
      vim.keymap.set("i", "<S-Tab>", function()
        luasnip.jump(-1)
      end, { silent = true })
      vim.keymap.set("s", "<S-Tab>", function()
        luasnip.jump(-1)
      end, { silent = true })
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.isort,
        },
      })
    end,
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "jay-babu/mason-nvim-dap.nvim",
      "leoluz/nvim-dap-go",
    },
    keys = {
      {
        "<F5>",
        function()
          require("dap").continue()
        end,
        desc = "Debug continue",
      },
      {
        "<F1>",
        function()
          require("dap").step_into()
        end,
        desc = "Debug step into",
      },
      {
        "<F2>",
        function()
          require("dap").step_over()
        end,
        desc = "Debug step over",
      },
      {
        "<F3>",
        function()
          require("dap").step_out()
        end,
        desc = "Debug step out",
      },
      {
        "<leader>b",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle breakpoint",
      },
      {
        "<leader>B",
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "Set conditional breakpoint",
      },
      {
        "<F7>",
        function()
          require("dapui").toggle()
        end,
        desc = "Toggle debug UI",
      },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      require("mason-nvim-dap").setup({
        automatic_installation = true,
        handlers = {},
      })

      dapui.setup({
        icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
        controls = {
          icons = {
            pause = "⏸",
            play = "▶",
            step_into = "⏎",
            step_over = "⏭",
            step_out = "⏮",
            step_back = "b",
            run_last = "▶▶",
            terminate = "⏹",
            disconnect = "⏏",
          },
        },
      })

      dap.listeners.after.event_initialized.dapui_config = dapui.open
      dap.listeners.before.event_terminated.dapui_config = dapui.close
      dap.listeners.before.event_exited.dapui_config = dapui.close

      dap.adapters.python = {
        type = "executable",
        command = "python",
        args = { "-m", "debugpy.adapter" },
      }

      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch current file",
          program = "${file}",
          console = "integratedTerminal",
          justMyCode = true,
        },
        {
          type = "python",
          request = "launch",
          name = "Launch with arguments",
          program = "${file}",
          console = "integratedTerminal",
          justMyCode = true,
          args = function()
            return vim.split(vim.fn.input("Arguments: "), " ")
          end,
        },
      }
    end,
  },
  {
    "quarto-dev/quarto-nvim",
    dev = false,
    opts = {
      lspFeatures = {
        enabled = true,
        chunks = "curly",
      },
      codeRunner = {
        enabled = true,
        default_method = "molten",
      },
    },
    dependencies = {
      "jmbuhr/otter.nvim",
    },
  },
  {
    "GCBallesteros/jupytext.nvim",
    opts = {
      custom_language_formatting = {
        python = {
          extension = "qmd",
          style = "quarto",
          force_ft = "quarto",
        },
        r = {
          extension = "qmd",
          style = "quarto",
          force_ft = "quarto",
        },
      },
    },
  },
  {
    "benlubas/molten-nvim",
    build = ":UpdateRemotePlugins",
    ft = { "quarto", "python", "r" },
  },
  {
    "jpalardy/vim-slime",
    config = function()
      vim.g.slime_target = "tmux"
      vim.g.slime_bracketed_paste = 1
      vim.g.slime_no_mappings = 1
      vim.g.slime_dont_ask_default = 1

      vim.api.nvim_create_user_command("SlimeSetTmuxPane", function()
        local pane = vim.fn.input("tmux pane (for example :.1 or 0:1.0): ")
        if pane == "" then
          vim.notify("Aborted.")
          return
        end

        vim.g.slime_default_config = {
          socket_name = "default",
          target_pane = pane,
        }
        vim.notify("Slime target pane -> " .. pane)
      end, {})

      local function slime_tmux_send_raw(cmd)
        local cfg = vim.g.slime_default_config or {}
        if not cfg.target_pane then
          vim.notify("Kein tmux target_pane gesetzt. Erst :SlimeSetTmuxPane ausfuehren.")
          return
        end

        local full_cmd = string.format(
          "tmux send-keys -t %s %s C-m",
          cfg.target_pane,
          vim.fn.shellescape(cmd)
        )
        os.execute(full_cmd)
      end

      vim.api.nvim_create_user_command("ReplPy", function()
        slime_tmux_send_raw("ipython")
      end, {})

      vim.api.nvim_create_user_command("ReplR", function()
        slime_tmux_send_raw("R")
      end, {})

      vim.api.nvim_create_user_command("ReplBash", function()
        slime_tmux_send_raw("bash")
      end, {})
    end,
  },
  {
    "vimwiki/vimwiki",
    lazy = false,
    init = function()
      vim.g.vimwiki_list = {
        {
          path = "~/wiki/",
          syntax = "markdown",
          ext = "md",
        },
        {
          path = "/home/tobias/uni/statistik/wiki/",
          syntax = "markdown",
          ext = "md",
          index = "home",
        },
      }
      vim.g.vimwiki_global_ext = 0
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "vimwiki",
        callback = function()
          vim.keymap.set("n", "<leader>wl", function()
            local termcodes = vim.api.nvim_replace_termcodes("<C-x><C-o>", true, false, true)
            vim.api.nvim_feedkeys("i[[" .. termcodes, "n", false)
          end, { buffer = true, desc = "Insert link to existing wiki page" })
        end,
      })
    end,
  },
}
