-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class Particle
---@field pos Point
---@field speed Point
---@field age number
---@field colors number[]
---@field rad number
Particle = {}
Particle.__index = Particle

Particle.kDuration = 18

---@param pos Point
---@return Particle
function Particle:New(pos)
  local o = {
    pos = pos:Clone(),
    speed = Point:New(rnd(1) - 0.5, rnd(1) - 0.5),
    age = 0,
    colors = { 7, 10, 9, 8, 2, 5 },
    rad = rnd(2)
  }
  return setmetatable(o, self)
end

function Particle:Update()
  self.pos += self.speed
  self.age += 1
end

function Particle:Draw()
  circfill(self.pos.x, self.pos.y, self.rad, self.colors[1 + self.age \ 3])
end
