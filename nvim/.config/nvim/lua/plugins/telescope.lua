return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.6",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
            },
        },
        config = function()
            require("telescope").setup({
                extensions = {
                    fzf = {
                        fuzzy = true, -- Fuzzy-Matching aktivieren
                        override_generic_sorter = true, -- Standard-Sorter durch FZF ersetzen
                        override_file_sorter = true, -- Datei-Sorter durch FZF ersetzen
                        case_mode = "smart_case", -- Groß-/Kleinschreibung intelligent behandeln
                    },
                },
            })
            require("telescope").load_extension("fzf") -- fzf laden
        end,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" }, -- Sicherstellen, dass telescope.nvim geladen ist
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })
            require("telescope").load_extension("ui-select") -- ui-select laden
        end,
    },
}
