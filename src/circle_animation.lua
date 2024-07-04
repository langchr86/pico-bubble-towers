-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class CircleAnim
---@field max_r number
---@field r number
---@field inc number
CircleAnim = {}
CircleAnim.__index = CircleAnim

---@return CircleAnim
function CircleAnimNew()
  local o = {
    r = 0,
  }

  return setmetatable(o, CircleAnim)
end

---@param max number
function CircleAnim:Start(max)
  if self.r == 0 then
    self.max_r = max
    self.r = kTileSize
    self.inc = (self.max_r - self.r) / 6 + 1
  end
end

---@param center Point
function CircleAnim:Animate(center)
  if self.r == 0 or self.r >= self.max_r then
    self.r = 0
    return
  end

  DrawRealCircle(center, self.r - 2, 15)
  DrawRealCircle(center, self.r - 1, 10)
  DrawRealCircle(center, self.r, 9)

  self.r += self.inc
end
