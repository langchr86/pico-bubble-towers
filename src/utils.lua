-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

kSpriteSize = 8
kSpriteRowSize = 16
kTileSize = 8
kTowerSize = 16
kMapSizeInTiles = 16
kMapRowSize = 8
kTopRowYCoordinate = 8

---@param tile_path Point[]|boolean
---@return Point[]
function ConvertTileToPixelPath(tile_path)
  local pixel_path = {}
  for pos in all(tile_path) do
    local pixel_pos = ConvertTileToPixel(pos)
    add(pixel_path, pixel_pos)
  end
  return pixel_path
end

---@param tile_pos Point
---@return Point
function ConvertTileToPixel(tile_pos)
  return PointNew(tile_pos.x * kTileSize, tile_pos.y * kTileSize)
end

---@param pos Point
---@return Point
function ConvertPixelToTile(pos)
  return PointNew(pos.x / kTileSize, pos.y / kTileSize)
end

function PrintRight(text, x, y, color)
  local length = print(text, 0, -kTileSize)
  print(text, x - length, y, color)
end

function PrintCenterX(text, y, color)
  local length = print(text, 0, -kTileSize)
  print(text, 64 - length / 2, y, color)
end

function DrawBackground()
  camera(0, 0)
  rectfill(0, 0, 127, 127, 1)
  rect(0, 0, 127, 127, 12)
end

---@param center Point
---@param radius number
---@param color number
function DrawRealCircle(center, radius, color)
  oval(center.x - radius - 1, center.y - radius - 1, center.x + radius, center.y + radius, color)
end

---@param orig Point
---@param dest Point
---@param color number
function DrawDoubleLine(orig, dest, color)
  line(orig.x, orig.y, dest.x, dest.y, color)
  line(orig.x + 1, orig.y + 1, dest.x + 1, dest.y + 1, color)
  line(orig.x, orig.y + 1, dest.x, dest.y + 1, color)
  line(orig.x + 1, orig.y, dest.x + 1, dest.y, color)
end

function StartFullTheme()
  if not stat(57) then
    music(0, 250)
  end
end
