-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

Cursor = {
  sprite=16,
  pos=nil,
  min=nil,
  max=nil,
  increment=1,
}
Cursor.__index = Cursor

function Cursor:New(pos, min, max, increment)
  o = {
    pos=pos:Clone(),
    min=min:Clone(),
    max=max:Clone(),
    increment=increment,
  }
  return setmetatable(o, self)
end

function Cursor:Set(pos)
  self.pos = pos
end

function Cursor:MoveUp()
  self.pos.y -= self.increment
  if (self.pos.y < self.min.y) then
    self.pos.y = self.min.y
  end
end

function Cursor:MoveDown()
  self.pos.y += self.increment
  if (self.pos.y > self.max.y) then
    self.pos.y = self.max.y
  end
end

function Cursor:MoveLeft()
  self.pos.x -= self.increment
  if (self.pos.x < self.min.x) then
    self.pos.x = self.min.x
  end
end

function Cursor:MoveRight()
  self.pos.x += self.increment
  if (self.pos.x > self.max.x) then
    self.pos.x = self.max.x
  end
end

function Cursor:Draw()
  if self.pos then
    spr(self.sprite, self.pos.x, self.pos.y, 2, 2)
  end
end
