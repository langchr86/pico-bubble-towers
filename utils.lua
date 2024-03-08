-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

kTileSize = 8
kMapSizeInTiles = 16
kMapRowSize = 8

function ConvertTileToPixel(tile_pos)
  return Point:New(tile_pos.x * kTileSize, tile_pos.y * kTileSize)
end

function ConvertPixelToTile(pos)
  return Point:New(pos.x / kTileSize, pos.y / kTileSize)
end

Map = {
  offset=nil,
}
Map.__index = Map

function Map:SetOffset(offset)
  self.offset = offset:Clone()
end

function Map:Draw()
  map(self.offset.x, self.offset.y)
end

function Map:IsTileFree(tile_pos)
  local massive = fget(Map:GetSprite(tile_pos), 0)
  return not massive
end

function Map:CanBuildOnTile4(tile_pos)
  return self:IsTileFree(tile_pos)
  and self:IsTileFree(tile_pos + Point:New(1, 0))
  and self:IsTileFree(tile_pos + Point:New(0, 1))
  and self:IsTileFree(tile_pos + Point:New(1, 1))
  and not self:IsTileStart(tile_pos)
  and not self:IsTileStart(tile_pos + Point:New(1, 0))
  and not self:IsTileStart(tile_pos + Point:New(0, 1))
  and not self:IsTileStart(tile_pos + Point:New(1, 1))
  and not self:IsTileGoal(tile_pos)
  and not self:IsTileGoal(tile_pos + Point:New(1, 0))
  and not self:IsTileGoal(tile_pos + Point:New(0, 1))
  and not self:IsTileGoal(tile_pos + Point:New(1, 1))
end

function Map:IsTileStart(tile_pos)
  return fget(Map:GetSprite(tile_pos), 6)
end

function Map:IsTileGoal(tile_pos)
  return fget(Map:GetSprite(tile_pos), 7)
end

function Map:GetSprite(tile_pos)
  local pos = tile_pos + self.offset
  return mget(pos.x, pos.y)
end

function Map:TileSet4(tile_pos, sprite)
  local x = tile_pos.x + self.offset.x
  local y = tile_pos.y + self.offset.y
  mset(x, y, sprite)
  mset(x + 1, y, sprite + 1)
  mset(x, y + 1, sprite + 16)
  mset(x + 1, y + 1, sprite + 17)
end

function Map:TileClear4(tile_pos, sprite)
  local x = tile_pos.x + self.offset.x
  local y = tile_pos.y + self.offset.y
  mset(x, y, sprite)
  mset(x + 1, y, sprite)
  mset(x, y + 1, sprite)
  mset(x + 1, y + 1, sprite)
end
