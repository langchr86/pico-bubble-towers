-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class LevelSelectionSession
---@field level_index number
---@field level_count number
---@field minimaps Minimap[]
---@field next_game_session GameSession
LevelSelectionSession = {}
LevelSelectionSession.__index = LevelSelectionSession

---@return LevelSelectionSession
function LevelSelectionSession:New()
  local o = {
    level_index = 0,
    level_count = 4,
    minimaps = {},
    next_game_session = nil,
  }

  local instance = --[[---@type LevelSelectionSession]] setmetatable(o, self)
  instance:Init()
  return instance
end

function LevelSelectionSession:Init()
  for l = 0, self.level_count - 1 do
    local top_left_tile = self.CalculateLevelOrigin(l)
    top_left_tile.y = top_left_tile.y + 1
    self.minimaps[l] = Minimap:New(top_left_tile, kMapSizeInTiles, kMapSizeInTiles - 1)
  end
end

function LevelSelectionSession:MoveUp()
end

function LevelSelectionSession:MoveDown()
end

function LevelSelectionSession:MoveLeft()
  self.level_index = self.level_index - 1
  if self.level_index < 0 then
    self.level_index = self.level_count - 1
  end
end

function LevelSelectionSession:MoveRight()
  self.level_index = self.level_index + 1
  if self.level_index >= self.level_count then
    self.level_index = 0
  end
end

function LevelSelectionSession:PressO()
end

function LevelSelectionSession:PressX()
  local top_left_tile = self.CalculateLevelOrigin(self.level_index)
  Map:SetOffset(top_left_tile)

  self.next_game_session = GameSession:New()
  self.next_game_session:AddWaves(CreateWaveList(100))
end

function LevelSelectionSession:Update()
  if self.next_game_session then
    return self.next_game_session
  else
    return self
  end
end

function LevelSelectionSession:Draw()
  rectfill(0, 0, 128, 128, 6)
  PrintCenterX("select level", 4, 5)

  local minimap_offsets = kMapSizeInTiles + kTileSize

  local map_pos = Point:New(20, 32)

  local cursor_pos = Point:New(map_pos.x + kTileSize / 2 + self.level_index * minimap_offsets, map_pos.y - kTileSize)
  spr(7, cursor_pos.x, cursor_pos.y)

  for l = 0, self.level_count - 1 do
    self.minimaps[l]:Draw(map_pos)
    map_pos.x = map_pos.x + minimap_offsets
  end
end

---@param level_index number
---@return Point
function LevelSelectionSession.CalculateLevelOrigin(level_index)
  return Point:New((level_index % kMapRowSize) * kMapSizeInTiles, flr(level_index / kMapRowSize) * kMapSizeInTiles)
end
