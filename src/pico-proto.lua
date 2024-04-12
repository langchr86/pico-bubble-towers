-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

local menu = Menu:New()

function _init()
  cls()

  -- custom cursor speed for btnp()
  poke(0x5f5c, 8) -- set the initial delay before repeating. 255 means never repeat.
  poke(0x5f5d, 2) -- set the repeating delay.

  menu:Update()
end

local active_session = LevelSelectionSession:New()

---@type boolean
g_show_debug_info = false
local function ToggleDebugInfo()
  g_show_debug_info = not g_show_debug_info
end
menu:SetDebugInfoHandler(ToggleDebugInfo)

function _update()
  if btnp(⬆️) then
    active_session:MoveUp()
  end

  if btnp(⬇️) then
    active_session:MoveDown()
  end

  if btnp(⬅️) then
    active_session:MoveLeft()
  end

  if btnp(➡️) then
    active_session:MoveRight()
  end

  if btn(🅾️) then
    if not menu.running then
      active_session:Update()
    end
  end

  if btnp(🅾️) then
    active_session:PressO()
  end

  if btnp(❎) then
    active_session:PressX()
  end

  if menu.running then
    active_session = active_session:Update()
  end
end

function _draw()
  cls()

  active_session:Draw()

  if not g_show_debug_info then
    return
  end

  fps = stat(7)
  print(fps, 119, 121, 10)
end
