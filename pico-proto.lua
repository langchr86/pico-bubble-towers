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
session:Init()
session:AddWaves(CreateWaveList(5))
cursor = Cursor:New()

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
    session:PlaceTower(cursor)
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
