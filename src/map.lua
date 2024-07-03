-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class Map
---@field offset Point
---@field walk_way_mode boolean
Map = {
  walk_way_mode = false,
}
Map.__index = Map

---@param offset Point
function Map:SetOffset(offset)
  self.offset = offset:Clone()
end

---@param offset Point
function Map:SetWalkwayMode(walk_way)
  self.walk_way_mode = walk_way
end

function Map:Draw()
  map(self.offset.x, self.offset.y)
end

---@param tile_pos Point
---@return boolean
function Map:IsTileWalkable(tile_pos)
  if not self.walk_way_mode then
    return fget(Map:GetSprite(tile_pos), 0)
  else
    return fget(Map:GetSprite(tile_pos), 0) and not Map:IsTileBuildable(tile_pos)
  end
end

---@param tile_pos Point
---@return boolean
function Map:IsTileBuildable(tile_pos)
  return fget(Map:GetSprite(tile_pos), 1)
end

---@param tile_pos Point
---@return boolean
function Map:IsTileWalkWay(tile_pos)
  return Map:GetSprite(tile_pos) == 4
end

---@param tile_pos Point
---@return boolean
function Map:CanBuildOnTile4(tile_pos)
  return self:IsTileBuildable(tile_pos)
      and self:IsTileBuildable(tile_pos + PointNew(1, 0))
      and self:IsTileBuildable(tile_pos + PointNew(0, 1))
      and self:IsTileBuildable(tile_pos + PointNew(1, 1))
end

---@param tile_pos Point
---@return boolean
function Map:IsTileStart(tile_pos)
  return fget(Map:GetSprite(tile_pos), 6)
end

---@param tile_pos Point
---@return boolean
function Map:IsTileGoal(tile_pos)
  return fget(Map:GetSprite(tile_pos), 7)
end

---@param tile_pos Point
---@return number
function Map:GetSprite(tile_pos)
  ---@type Point
  local pos = tile_pos + self.offset
  return mget(pos.x, pos.y)
end

---@param sprite number
---@return number
function Map:GetSpriteMainColor(sprite)
  local x = (sprite % kSpriteRowSize) * kSpriteSize
  local y = (sprite \ kSpriteRowSize) * kSpriteSize
  return sget(x, y)
end

---@param tile_pos Point
---@param sprite number
function Map:TileSet4(tile_pos, sprite)
  local x = tile_pos.x + self.offset.x
  local y = tile_pos.y + self.offset.y
  mset(x, y, sprite)
  mset(x + 1, y, sprite + 1)
  mset(x, y + 1, sprite + 16)
  mset(x + 1, y + 1, sprite + 17)
end

---@param tile_pos Point
---@param sprite number
function Map:TileClear4(tile_pos, sprite)
  local x = tile_pos.x + self.offset.x
  local y = tile_pos.y + self.offset.y
  mset(x, y, sprite)
  mset(x + 1, y, sprite)
  mset(x, y + 1, sprite)
  mset(x + 1, y + 1, sprite)
end
