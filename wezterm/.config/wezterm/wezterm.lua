local wezterm = require("wezterm")
-- Funktion zum Umschalten des Farbschemas
function toggle_color_scheme(window)
    local overrides = window:get_config_overrides() or {}
    if overrides.color_scheme == "Gruvbox (Gogh)" then
        overrides.color_scheme = "Ayu Mirage"
    else
        overrides.color_scheme = "Gruvbox (Gogh)"
    end
    window:set_config_overrides(overrides)
end

-- Tastenkombination zum Umschalten hinzufügen
--table.insert(config.keys or {}, {key="d", mods="ALT", action=wezterm.action_callback(toggle_color_scheme)})

return {
    --    color_scheme = "Gruvbox (Gogh)",
    color_scheme = "Ayu Mirage",
    --window_background_image = "/home/tobias/mydotfiles/wezterm/.config/wezterm/rebel-princess-ian-king.jpg",
    -- Optionale weitere Einstellungen
    font = wezterm.font("JetBrains Mono"), -- Beispielhafte Schriftart
    font_size = 18.0,
    audible_bell = "Disabled",
}
