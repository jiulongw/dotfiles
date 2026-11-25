local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font = wezterm.font("Iosevka NFM")
-- config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 19
config.color_scheme = "catppuccin-mocha"

-- config.enable_tab_bar = false

config.window_decorations = "RESIZE"

config.window_background_opacity = 0.85
config.macos_window_background_blur = 16

local act = wezterm.action
config.keys = {
  -- Rebind OPT-Left, OPT-Right as ALT-b, ALT-f respectively to match Terminal.app behavior
  {
    key = 'LeftArrow',
    mods = 'OPT',
    action = act.SendKey {
      key = 'b',
      mods = 'ALT',
    },
  },
  {
    key = 'RightArrow',
    mods = 'OPT',
    action = act.SendKey { key = 'f', mods = 'ALT' },
  },
}

return config
