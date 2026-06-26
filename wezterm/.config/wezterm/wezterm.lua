
local wezterm = require("wezterm")
local colors = require("colors") -- Importiere das Farbschema

-- Initialisiere die Konfigurationsvariable
local config = {}

-- Konfiguration
config = {
    enable_tab_bar =false,
    -- Die restlichen Einstellungen
    color_scheme = colors.scheme, -- Verwende das importierte Farbschema
    -- window_background_image = "/home/tobias/mydotfiles/wezterm/.config/wezterm/rebel-princess-ian-king.jpg",
    font = wezterm.font_with_fallback({
    --"OpenDyslexicMono",   -- Primary font
   
-- { family = "Sylexiad Serif Medium", weight = "Bold" },
  { family = "NotoMono Nerd Font" },
  { family = "Noto Color Emoji" },
}),

    font_size = 20.0,
    audible_bell = "Disabled",
    keys = config.keys, -- Sicherstellen, dass die Schlüssel in die Konfiguration aufgenommen werden
window_background_opacity = 0.8, -- Setze die Opazität auf 80%
}

return config

