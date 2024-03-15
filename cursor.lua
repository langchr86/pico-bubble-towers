-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class Cursor
---@field sprite number
---@field pos Point
---@field min Point
---@field max Point
---@field inc number
Cursor = {
  sprite=64,
  pos=Point:New(8, 16),
  min=Point:New(0, 8),
  max=Point:New(112, 112),
  inc=kTileSize,
}
Cursor.__index = Cursor

---@return Cursor
function Cursor:New()
  local o = {
  }
  return --[[---@type Cursor]] setmetatable(o, self)
end

function Cursor:MoveUp()
  self.pos.y -= self.inc
  if (self.pos.y < self.min.y) then
    self.pos.y = self.min.y
  end
end

function Cursor:MoveDown()
  self.pos.y += self.inc
  if (self.pos.y > self.max.y) then
    self.pos.y = self.max.y
  end
end

function Cursor:MoveLeft()
  self.pos.x -= self.inc
  if (self.pos.x < self.min.x) then
    self.pos.x = self.min.x
  end
end

function Cursor:MoveRight()
  self.pos.x += self.inc
  if (self.pos.x > self.max.x) then
    self.pos.x = self.max.x
  end
end

---@return boolean
function Cursor:IsFree()
  local tile_pos = Point:New(self.pos.x / self.inc, self.pos.y / self.inc)
  return Map:CanBuildOnTile4(tile_pos)
end

function Cursor:Draw()
  if self.pos then
    spr(self.sprite, self.pos.x, self.pos.y, 2, 2)

    ---@type number
    cursor_sprite = Map:GetSprite(Point:New(self.pos.x / self.inc, self.pos.y / self.inc))
    print(cursor_sprite, 2, 121, 10)
    print(fget(cursor_sprite, 0), 17, 121, 10)
  end
end
