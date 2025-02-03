-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

-- This table will hold the configuration.
local config = {}
-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- This is where you actually apply your config choices
config.keys = {
    -- Clears the scrollback and viewport leaving the prompt line the new first line.
    {
        key = 'k',
        mods = 'CMD',
        action = act.ClearScrollback 'ScrollbackAndViewport',
    },
    -- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
    { key = "LeftArrow",  mods = "OPT", action = wezterm.action { SendString = "\x1bb" } },
    -- Make Option-Right equivalent to Alt-f; forward-word
    { key = "RightArrow", mods = "OPT", action = wezterm.action { SendString = "\x1bf" } },
}
config.color_scheme = 'Vacuous 2 (terminal.sexy)'

config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"

-- and finally, return the configuration to wezterm
return config
