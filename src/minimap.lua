-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class Minimap
---@field width number
---@field height number
---@field color_data number[][]
Minimap = {}
Minimap.__index = Minimap

---@param top_left_tile Point
---@param width number
---@param height number
---@return Minimap
function Minimap:New(top_left_tile, width, height)
  local o = {
    width = width,
    height = height,
    color_data = {},
  }

  local instance = --[[---@type Minimap]] setmetatable(o, self)
  instance:Init(top_left_tile)
  return instance
end

---@param top_left_tile Point
function Minimap:Init(top_left_tile)
  Map:SetOffset(top_left_tile)

  for x = 0, self.width - 1 do
    self.color_data[x] = {}
    for y = 0, self.height - 1 do
      local tile_pos = Point:New(x, y)
      local sprite = Map:GetSprite(tile_pos)
      local color = Map:GetSpriteMainColor(sprite)
      self.color_data[x][y] = color
    end
  end
end

---@param pixel_pos Point
function Minimap:Draw(pixel_pos)
  for x = 0, self.width - 1 do
    for y = 0, self.height - 1 do
      local color = self.color_data[x][y]
      pset(x + pixel_pos.x, y + pixel_pos.y, color)
    end
  end
end
