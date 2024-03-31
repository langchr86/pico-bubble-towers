-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class Bullet
---@field pos Point
---@field dest Point
---@field sprite number
---@field speed number
---@field damage number
Bullet = {}
Bullet.__index = Bullet

---@param pos Point
---@param dest Point
---@param damage number
---@return Bullet
function Bullet:New(pos, dest, damage)
  local o = {
    pos = pos:Clone(),
    dest = dest, -- this is a always updated reference to the target
    sprite = 48,
    speed = 3,
    damage = damage,
  }
  return --[[---@type Bullet]] setmetatable(o, self)
end

---@return boolean
function Bullet:InTarget()
  return self.pos:IsNear(self.dest, 2)
end

function Bullet:Update()
  self.pos:Move(self.dest, self.speed)
end

function Bullet:Draw()
  ---@type Point
  local rounded = self.pos:Floor()
  spr(self.sprite, rounded.x, rounded.y)
end
