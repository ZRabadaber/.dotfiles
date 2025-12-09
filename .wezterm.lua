local wezterm = require 'wezterm'
local act = wezterm.action

local config = wezterm.config_builder()
config.color_scheme = 'AdventureTime'

config.default_prog = { 'pwsh.exe' }

--config.window_decorations = "RESIZE"
config.use_fancy_tab_bar = true

--config.animation_fps = 60
--config.prefer_egl = true

config.use_dead_keys = false

config.initial_rows = 32
config.initial_cols = 128

config.enable_kitty_graphics = true

config.font = wezterm.font 'Hack Nerd Font'

config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
    -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
    { key = 'a', mods = 'LEADER|CTRL', action = act.SendKey { key = 'a', mods = 'CTRL' } },
    { key = 'r', mods = 'LEADER', action = act.ActivateKeyTable { name = 'resize_pane', one_shot = false, } },
    
    { key = 'LeftArrow', mods = 'LEADER', action = act.ActivatePaneDirection 'Left' },
    { key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection 'Left' },
  
    { key = 'RightArrow', mods = 'LEADER', action = act.ActivatePaneDirection 'Right' },
    { key = 'l', mods = 'LEADER', action = act.ActivatePaneDirection 'Right' },
  
    { key = 'UpArrow', mods = 'LEADER', action = act.ActivatePaneDirection 'Up' },
    { key = 'k', mods = 'LEADER', action = act.ActivatePaneDirection 'Up' },
  
    { key = 'DownArrow', mods = 'LEADER', action = act.ActivatePaneDirection 'Down' },
    { key = 'j', mods = 'LEADER', action = act.ActivatePaneDirection 'Down' },
    
    { key = 'c', mods = 'LEADER', action = act.ActivateKeyTable { name = 'create_pane', one_shot = false, timeout_milliseconds = 1000, } },

    { key = 'w', mods = 'LEADER', action = act.CloseCurrentPane { confirm = true } },
    { key = 'w', mods = 'CTRL|SHIFT', action = act.CloseCurrentTab { confirm = true } },
}

config.key_tables = {
    resize_pane = {
      { key = 'LeftArrow', action = act.AdjustPaneSize { 'Left', 1 } },
      { key = 'h', action = act.AdjustPaneSize { 'Left', 1 } },
  
      { key = 'RightArrow', action = act.AdjustPaneSize { 'Right', 1 } },
      { key = 'l', action = act.AdjustPaneSize { 'Right', 1 } },
  
      { key = 'UpArrow', action = act.AdjustPaneSize { 'Up', 1 } },
      { key = 'k', action = act.AdjustPaneSize { 'Up', 1 } },
  
      { key = 'DownArrow', action = act.AdjustPaneSize { 'Down', 1 } },
      { key = 'j', action = act.AdjustPaneSize { 'Down', 1 } },
        -- Cancel the mode by pressing escape
      { key = 'Escape', action = 'PopKeyTable' },
    },
    create_pane = {
      { key = 'RightArrow', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
      { key = 'l', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  
      { key = 'DownArrow', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
      { key = 'j', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
      -- Cancel the mode by pressing escape
      { key = 'Escape', action = 'PopKeyTable' },
    },
  }

return config
