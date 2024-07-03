-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class MapSelection
---@field map_index number
---@field map_cnt number
---@field minimaps Minimap[]
---@field wave_list Wave[]
---@field next_session any
MapSelection = {}
MapSelection.__index = MapSelection

---@return MapSelection
function MapSelectionNew(wave_list)
  local o = {
    map_index = 0,
    map_cnt = 16,
    minimaps = {},
    wave_list = wave_list
  }

  local instance = --[[---@type MapSelection]] setmetatable(o, MapSelection)
  instance:Init()
  return instance
end

function MapSelection:Init()
  for l = 0, self.map_cnt - 1 do
    local top_left_tile = self.CalculateLevelOrigin(l)
    top_left_tile.y += 1
    self.minimaps[l] = MinimapNew(top_left_tile, kMapSizeInTiles, kMapSizeInTiles - 1)
  end
end

function MapSelection:Up()
  if self.map_index > 3 then
    self.map_index -= 4
  end
end

function MapSelection:Down()
  if self.map_index < 12 then
    self.map_index += 4
  end
end

function MapSelection:Left()
  if self.map_index % 4 > 0 then
    self.map_index -= 1
  end
end

function MapSelection:Right()
  if self.map_index % 4 < 3 then
    self.map_index += 1
  end
end

function MapSelection:PressO()
  self.next_session = DifficultySelectionNew()
end

function MapSelection:PressX()
  local top_left_tile = self.CalculateLevelOrigin(self.map_index)
  Map:SetOffset(top_left_tile)

  self.next_session = GameSessionNew(self.wave_list)
end

function MapSelection:Update()
  if self.next_session then
    return self.next_session
  else
    return self
  end
end

function MapSelection:Draw()
  DrawBackground()
  PrintCenterX("select map", 4, 12)

  for m = 0, self.map_cnt - 1 do
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
function MapSelection.CalculateLevelOrigin(map_index)
  return PointNew((map_index % kMapRowSize) * kMapSizeInTiles, (map_index \ kMapRowSize) * kMapSizeInTiles)
end

---@param map_index number
---@return Point
function MapSelection.CalculateMinimapOrigin(map_index)
  local minimap_offset = kMapSizeInTiles + kTileSize
  return PointNew(20 + (map_index % 4) * minimap_offset, 24 + (map_index \ 4) * minimap_offset)
end
