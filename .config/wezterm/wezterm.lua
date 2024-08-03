-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.font_size = 12
config.color_scheme = 'iTerm2 Default'

config.leader = { key = 'b', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
    {
        key = 's',
        mods = 'LEADER',
        action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
        key = 'v',
        mods = 'LEADER',
        action = act.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
        key = 'd',
        mods = 'LEADER',
        action = act.CloseCurrentTab { confirm = true },
    },
    {
        key = 'd',
        mods = 'LEADER',
        action = act.CloseCurrentPane { confirm = true },
    },
    {
        key = 'n',
        mods = 'LEADER',
        action = act.SpawnTab 'CurrentPaneDomain',
    },
    {
        key = 'w',
        mods = 'LEADER',
        action = act.SpawnWindow
    },
    {
        key = 'h',
        mods = 'LEADER',
        action = act.ActivatePaneDirection 'Left',
    },
    {
        key = 'l',
        mods = 'LEADER',
        action = act.ActivatePaneDirection 'Right',
    },
    {
        key = 'k',
        mods = 'LEADER',
        action = act.ActivatePaneDirection 'Up',
    },
    {
        key = 'j',
        mods = 'LEADER',
        action = act.ActivatePaneDirection 'Down',
    },
    {
        key = ',',
        mods = 'LEADER',
        action = act.PromptInputLine {
            description = 'Enter new name for tab',
            action = wezterm.action_callback(function(window, pane, line)
                -- line will be `nil` if they hit escape without entering anything
                -- An empty string if they just hit enter
                -- Or the actual line of text they wrote
                if line then
                    window:active_tab():set_title(line)
                end
            end),
        },
    },
}

for i = 1, 8 do
    table.insert(config.keys, {
        key = tostring(i),
        mods = 'LEADER',
        action = act.ActivateTab(i - 1),
    })
end

-- and finally, return the configuration to wezterm
return config
