-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

menu = Menu:New()

function _init()
  cls()

  -- custom cursor speed for btnp()
  poke(0x5f5c, 8) -- set the initial delay before repeating. 255 means never repeat.
  poke(0x5f5d, 2) -- set the repeating delay.

  menu:Update()
end

map_index = 0
Map:SetOffset(Point:New((map_index % kMapRowSize) * kMapSizeInTiles, (map_index \ kMapRowSize) * kMapSizeInTiles))

session = Session:New()
session:AddWaves(CreateWaveList(5))
cursor = Cursor:New()

---@param selected_menu number
local function CursorMenuHandler(menu_index)
  if menu_index == 0 then
    return session:PlaceTower(cursor)
  elseif menu_index == 1 then
    return false
  end
  return true
end

local function CursorMenuSpriteGetter(menu_index)
  if menu_index == 0 then
    return 128
  elseif menu_index == 1 then
    return 66
  elseif menu_index == 2 then
    return 67
  elseif menu_index == 3 then
    return 68
  elseif menu_index == 4 then
    return 69
  end
end

cursor:RegisterMenuHandler(CursorMenuHandler, CursorMenuSpriteGetter)

local function AddNewWaves()
  session:AddWaves(CreateWaveList(5))
end
menu:SetWaveHandler(AddNewWaves)

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

  fps = stat(7)
  print(fps, 119, 121, 10)
end
