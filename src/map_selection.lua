-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class MapSelection
---@field map_index number
---@field map_count number
---@field minimaps Minimap[]
---@field next_game_session GameSession
MapSelection = {}
MapSelection.__index = MapSelection

---@return MapSelection
function MapSelection:New()
  local o = {
    map_index = 0,
    map_count = 4,
    minimaps = {},
    next_game_session = nil,
  }

  local instance = --[[---@type MapSelection]] setmetatable(o, self)
  instance:Init()
  return instance
end

function MapSelection:Init()
  for l = 0, self.map_count - 1 do
    local top_left_tile = self.CalculateLevelOrigin(l)
    top_left_tile.y = top_left_tile.y + 1
    self.minimaps[l] = Minimap:New(top_left_tile, kMapSizeInTiles, kMapSizeInTiles - 1)
  end
end

function MapSelection:MoveUp()
end

function MapSelection:MoveDown()
end

function MapSelection:MoveLeft()
  self.map_index = self.map_index - 1
  if self.map_index < 0 then
    self.map_index = self.map_count - 1
  end
end

function MapSelection:MoveRight()
  self.map_index = self.map_index + 1
  if self.map_index >= self.map_count then
    self.map_index = 0
  end
end

function MapSelection:PressO()
end

function MapSelection:PressX()
  local top_left_tile = self.CalculateLevelOrigin(self.map_index)
  Map:SetOffset(top_left_tile)

  self.next_game_session = GameSession:New()
  self.next_game_session:AddWaves(CreateWaveList(100))
end

function MapSelection:Update()
  if self.next_game_session then
    return self.next_game_session
  else
    return self
  end
end

function MapSelection:Draw()
  rectfill(0, 0, 128, 128, 6)
  PrintCenterX("select map", 4, 5)

  local minimap_offsets = kMapSizeInTiles + kTileSize

  local map_pos = Point:New(20, 32)

  local cursor_pos = Point:New(map_pos.x + kTileSize / 2 + self.map_index * minimap_offsets, map_pos.y - kTileSize)
  spr(7, cursor_pos.x, cursor_pos.y)

  for l = 0, self.map_count - 1 do
    self.minimaps[l]:Draw(map_pos)
    map_pos.x = map_pos.x + minimap_offsets
  end
end

---@param level_index number
---@return Point
function MapSelection.CalculateLevelOrigin(level_index)
  return Point:New((level_index % kMapRowSize) * kMapSizeInTiles, flr(level_index / kMapRowSize) * kMapSizeInTiles)
end
