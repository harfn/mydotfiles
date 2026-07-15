return {
  {
    "Shatur/neovim-ayu",
    lazy = false,
    priority = 1000,
    config = function()
      if require("config.profile").current() == "base" then
        require("config.theme").apply_base_theme()
      end
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
        },
      })
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release -DCMAKE_POLICY_VERSION_MINIMUM=3.5 && cmake --build build --config Release",
        cond = function()
          return vim.fn.executable("cmake") == 1
        end,
      },
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
          ["ui-select"] = require("telescope.themes").get_dropdown({}),
        },
      })

      pcall(telescope.load_extension, "fzf")
      pcall(telescope.load_extension, "ui-select")
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = function()
      local spec = {
        { "<leader>f", group = "Find" },
        { "<leader>p", group = "Path" },
        { "<leader>v", group = "Vim options" },
      }

      if require("config.profile").current() == "nvim_ide" then
        vim.list_extend(spec, {
          { "<leader>c", group = "Code" },
          { "<leader>m", group = "Markdown" },
          { "<leader>q", group = "Quarto" },
          { "<leader>qi", group = "Insert chunk" },
          { "<leader>s", group = "Send" },
          { "<leader>t", group = "Tree" },
        })
      end

      return {
        spec = spec,
      }
    end,
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer local keymaps",
      },
    },
  },
  {
    "paulbkim-dev/vim-herdr-navigation",
    lazy = false,
    dependencies = {
      {
        "christoomey/vim-tmux-navigator",
        lazy = false,
        init = function()
          vim.g.tmux_navigator_no_mappings = 1
        end,
      },
    },
    config = function()
      local plugin = require("lazy.core.config").plugins["vim-herdr-navigation"]
      dofile(plugin.dir .. "/editor/nvim.lua")
    end,
  },
}
