-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@type boolean
g_show_debug_info = false
local function ToggleDebugInfo()
  g_show_debug_info = not g_show_debug_info
end

function _init()
  cls()

  -- custom cursor speed for btnp()
  poke(0x5f5c, 8) -- set the initial delay before repeating. 255 means never repeat.
  poke(0x5f5d, 2) -- set the repeating delay.

  -- menu
  menuitem(1, "toggle debg info", ToggleDebugInfo)

  -- decompress title image from spritemap and store in general purpose memory 0x8000
  px9_decomp(0, 0, 0x1000, pget, pset)
  memcpy(0x8000, 0x6000, 128 * 64)
end

local active_session = StartScreen:New()

function _update()
  if btnp(⬆️) and active_session.MoveUp then
    active_session:MoveUp()
  end

  if btnp(⬇️) and active_session.MoveDown then
    active_session:MoveDown()
  end

  if btnp(⬅️) and active_session.MoveLeft then
    active_session:MoveLeft()
  end

  if btnp(➡️) and active_session.MoveRight then
    active_session:MoveRight()
  end

  if btnp(🅾️) and active_session.PressO then
    active_session:PressO()
  end

  if btnp(❎) and active_session.PressX then
    active_session:PressX()
  end

  active_session = active_session:Update()
end

function _draw()
  cls()

  active_session:Draw()

  if not g_show_debug_info then
    return
  end

  local fps = stat(7)
  print(fps, 119, 121, 10)
end
