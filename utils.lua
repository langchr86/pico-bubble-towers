-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

kTileSize = 8

function ConvertTileToPixel(tile_pos)
  return Point:New(tile_pos.x * kTileSize, tile_pos.y * kTileSize)
end

function ConvertPixelToTile(pos)
  return Point:New(pos.x / kTileSize, pos.y / kTileSize)
end

function IsTileFree(tile_pos)
  local massive = fget(mget(tile_pos.x, tile_pos.y), 0)
  return not massive
end
