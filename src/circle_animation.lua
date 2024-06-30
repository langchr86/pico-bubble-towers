-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class CircleAnimation
---@field max_r number
---@field r number
---@field inc number
CircleAnimation = {}
CircleAnimation.__index = CircleAnimation

---@return CircleAnimation
function CircleAnimationNew()
  local o = {
    r = 0,
  }

  return setmetatable(o, CircleAnimation)
end

---@param max number
function CircleAnimation:Start(max)
  if self.r == 0 then
    self.max_r = max
    self.r = kTileSize
    self.inc = (self.max_r - self.r) / 6 + 1
  end
end

---@param center Point
function CircleAnimation:Animate(center)
  if self.r == 0 or self.r >= self.max_r then
    self.r = 0
    return
  end

  DrawRealCircle(center, self.r - 2, 15)
  DrawRealCircle(center, self.r - 1, 10)
  DrawRealCircle(center, self.r, 9)

  self.r += self.inc
end
