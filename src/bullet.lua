-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class Bullet
---@field pos Point
---@field dest Point
---@field damage number
Bullet = {}
Bullet.__index = Bullet

---@param pos Point
---@param dest Point
---@param damage number
---@return Bullet
function BulletNew(pos, dest, damage)
  local o = {
    pos = pos:Clone(),
    dest = dest, -- this is a always updated reference to the target
    damage = damage,
  }
  return setmetatable(o, Bullet)
end

---@return boolean
function Bullet:InTarget()
  return self.pos:IsNear(self.dest, 2)
end

function Bullet:Update()
  self.pos:Move(self.dest, 3)
end

function Bullet:Draw()
  spr(20, self.pos.x, self.pos.y)
end
