-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

Cursor = {
  sprite=16,
  pos=nil,
  min=nil,
  max=nil,
  inc=0,
}
Cursor.__index = Cursor

function Cursor:New(pos, min, max, inc)
  o = {
    pos=pos:Clone(),
    min=min:Clone(),
    max=max:Clone(),
    inc=inc,
  }
  return setmetatable(o, self)
end

function Cursor:Set(pos)
  self.pos = pos
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

function Cursor:Draw()
  if self.pos then
    spr(self.sprite, self.pos.x, self.pos.y, 2, 2)

    cursor_sprite = mget(self.pos.x / self.inc, self.pos.y / self.inc)
    print(cursor_sprite, 1, 121, 10)
    print(fget(cursor_sprite, 0), 17, 121, 10)
  end
end
