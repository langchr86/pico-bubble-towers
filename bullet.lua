-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

Bullet = {
  pos=nil,
  dest=nil,
  sprite=48,
  speed=3,
  damage=10,
}
Bullet.__index = Bullet

function Bullet:New(pos, dest)
  o = {
    pos=pos:Clone(),
    dest=dest,  -- this is a always updated reference to the target
  }
  return setmetatable(o, self)
end

function Bullet:InTarget()
  return self.pos:IsNear(self.dest, 2)
end

function Bullet:Update()
  self.pos:Move(self.dest, self.speed)
end

function Bullet:Draw()
  local rounded = self.pos:Floor()
  spr(self.sprite, rounded.x, rounded.y)
end
