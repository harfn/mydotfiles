
-- Grundlegende Einstellungen vor dem Laden der Plugins
vim.g.mapleader = " "
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set encoding=UTF-8")
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set softtabstop=4")

-- Pfad zur Datei mit dem Theme-Status
local THEME_STATUS_FILE = vim.fn.expand("~/.config/current_theme")

-- Funktion zum Lesen des Inhalts der Datei
local function read_file(file_path)
    local file = io.open(file_path, "r")
    if not file then return nil end
    local content = file:read("*all")
    file:close()
    return content:gsub("%s+", "") -- Entfernt Leerzeichen und Zeilenumbrüche
end

-- Funktion, um das Colorscheme basierend auf der Datei anzupassen
local function SetColorschemeFromFile()
    local theme_status = read_file(THEME_STATUS_FILE)

    if theme_status == "light" then
        vim.opt.background = "light"
        -- Sicherstellen, dass das gruvbox-Schema vorhanden ist
        if pcall(vim.cmd, "colorscheme gruvbox") then
            require("lualine").setup({ options = { theme = "gruvbox" } })
        else
            print("Gruvbox-Colorscheme nicht gefunden.")
        end
    else
        vim.opt.background = "dark"
        if pcall(vim.cmd, "colorscheme ayu-mirage") then
            require("lualine").setup({ options = { theme = "ayu_mirage" } })
        else
            print("Ayu-Mirage-Colorscheme nicht gefunden.")
        end
    end
end

-- Füge eine Toggle-Funktion hinzu, um das Theme manuell zu wechseln
function ToggleColorscheme()
    if vim.g.colors_name == "gruvbox" then
        vim.opt.background = "dark"
        vim.cmd("colorscheme ayu-mirage")
        require("lualine").setup({ options = { theme = "ayu_mirage" } })
    else
        vim.opt.background = "light"
        vim.cmd("colorscheme gruvbox")
        require("lualine").setup({ options = { theme = "gruvbox" } })
    end
end

-- Stelle sicher, dass das Theme nach dem Start geladen wird
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        SetColorschemeFromFile()
    end
})

