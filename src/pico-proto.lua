-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

local menu = Menu:New()

function _init()
  cls()

  -- custom cursor speed for btnp()
  poke(0x5f5c, 8) -- set the initial delay before repeating. 255 means never repeat.
  poke(0x5f5d, 2) -- set the repeating delay.

  menu:Update()
end

map_index = 0
Map:SetOffset(Point:New((map_index % kMapRowSize) * kMapSizeInTiles, flr(map_index / kMapRowSize) * kMapSizeInTiles))

local cursor = Cursor:New()
local session = Session:New(cursor)
session:AddWaves(CreateWaveList(5))

local function AddNewWaves()
  session:AddWaves(CreateWaveList(5))
end
menu:SetWaveHandler(AddNewWaves)

---@type boolean
g_show_debug_info = false
local function ToggleDebugInfo()
  g_show_debug_info = not g_show_debug_info
end
menu:SetDebugInfoHandler(ToggleDebugInfo)

function _update()
  if btnp(⬆️) then
    cursor:MoveUp()
  end

  if btnp(⬇️) then
    cursor:MoveDown()
  end

  if btnp(⬅️) then
    cursor:MoveLeft()
  end

  if btnp(➡️) then
    cursor:MoveRight()
  end

  if btn(🅾️) then
    if not menu.running then
      session:Update()
    end
  end

  if btnp(🅾️) then
    session:StartNextWave()
  end

  if btnp(❎) then
    cursor:Press()
  end

  if menu.running then
    session:Update()
  end
end

function _draw()
  cls()

  session:Draw(cursor)
  cursor:Draw()

  if not g_show_debug_info then
    return
  end

  fps = stat(7)
  print(fps, 119, 121, 10)
end
