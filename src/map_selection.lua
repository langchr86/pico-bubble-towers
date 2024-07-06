-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class MapSelect
---@field map_index number
---@field minimaps Minimap[]
---@field level number
---@field next_session any
MapSelect = {}
MapSelect.__index = MapSelect

MapSelectLastIndex = 15

---@param level number
---@return MapSelect
function MapSelectNew(level)
  local o = {
    map_index = 0,
    minimaps = {},
    level = level
  }

  local instance = --[[---@type MapSelect]] setmetatable(o, MapSelect)
  instance:Init()
  return instance
end

function MapSelect:Init()
  for l = 0, MapSelectLastIndex do
    local top_left_tile = self.CalculateLevelOrigin(l)
    top_left_tile.y += 1
    self.minimaps[l] = MinimapNew(top_left_tile, kMapSizeInTiles, kMapSizeInTiles - 1)
  end
end

function MapSelect:Up()
  if self.map_index > 3 then
    self.map_index -= 4
  end
end

function MapSelect:Down()
  if self.map_index < 12 then
    self.map_index += 4
  end
end

function MapSelect:Left()
  if self.map_index % 4 > 0 then
    self.map_index -= 1
  end
end

function MapSelect:Right()
  if self.map_index % 4 < 3 then
    self.map_index += 1
  end
end

function MapSelect:PressO()
  self.next_session = DiffSelectNew()
end

function MapSelect:PressX()
  local top_left_tile = self.CalculateLevelOrigin(self.map_index)
  Map:SetOffset(top_left_tile)

  self.next_session = GameSessionNew(CreatePredefinedWaveList(self.level), self.level, self.map_index + 1)
end

function MapSelect:Update()
  if self.next_session then
    return self.next_session
  else
    return self
  end
end

function MapSelect:Draw()
  DrawBackground()
  PrintCenterX("select map", 4)

  for m = 0, MapSelectLastIndex do
    local map_pos = self.CalculateMinimapOrigin(m)
    self.minimaps[m]:Draw(map_pos)
  end

  local cursor_pos = self.CalculateMinimapOrigin(self.map_index) + PointNew(kTileSize / 2, -kTileSize)
  spr(7, cursor_pos.x, cursor_pos.y)

  local border_pos = self.CalculateMinimapOrigin(self.map_index) + PointNew(-1, -1)
  rect(border_pos.x, border_pos.y, border_pos.x + kMapSizeInTiles + 1, border_pos.y + kMapSizeInTiles, 12)
end

---@param map_index number
---@return Point
function MapSelect.CalculateLevelOrigin(map_index)
  return PointNew((map_index % 8) * kMapSizeInTiles, (map_index \ 8) * kMapSizeInTiles)
end

---@param map_index number
---@return Point
function MapSelect.CalculateMinimapOrigin(map_index)
  local minimap_offset = kMapSizeInTiles + kTileSize
  return PointNew(20 + (map_index % 4) * minimap_offset, 24 + (map_index \ 4) * minimap_offset)
end
