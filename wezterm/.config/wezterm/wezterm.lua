local wezterm = require("wezterm")
local colors = require("colors")

local config = {}

config.enable_tab_bar = false
config.color_scheme = colors.scheme

config.font = wezterm.font_with_fallback({
  { family = "NotoMono Nerd Font" },
  { family = "Noto Color Emoji" },
})

config.font_size = 20.0
config.audible_bell = "Disabled"
config.window_background_opacity = 0.8

return config

