-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class CircleAnimation
---@field max_radius number
---@field radius number
---@field inc number
CircleAnimation = {}
CircleAnimation.__index = CircleAnimation

---@return CircleAnimation
function CircleAnimation:New()
  local o = {
    radius = 0,
  }

  return setmetatable(o, self)
end

---@param radius number
function CircleAnimation:Start(radius)
  if self.radius == 0 then
    self.max_radius = radius
    self.radius = kTileSize
    self.inc = (self.max_radius - self.radius) / 6 + 1
  end
end

---@param center Point
function CircleAnimation:Animate(center)
  if self.radius == 0 or self.radius >= self.max_radius then
    self.radius = 0
    return
  end

  DrawRealCircle(center, self.radius - 2, 15)
  DrawRealCircle(center, self.radius - 1, 10)
  DrawRealCircle(center, self.radius, 9)

  self.radius += self.inc
end
