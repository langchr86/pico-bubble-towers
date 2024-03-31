-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class TowerAreaAnimation
---@field area_radius number
---@field animation_radius number
---@field animation_increment number
TowerAreaAnimation = {}
TowerAreaAnimation.__index = TowerAreaAnimation

---@return TowerAreaAnimation
function TowerAreaAnimation:New()
  local o = {
    animation_radius = 0,
  }

  local instance = --[[---@type TowerAreaAnimation]] setmetatable(o, self)
  return instance
end

---@param radius number
function TowerAreaAnimation:Start(radius)
  if self.animation_radius == 0 then
    self.area_radius = radius
    self.animation_radius = kTileSize
    self.animation_increment = (self.area_radius - self.animation_radius) / 6 + 1
  end
end

---@param center Point
function TowerAreaAnimation:Animate(center)
  if self.animation_radius == 0 then
    return
  end

  if self.animation_radius >= self.area_radius then
    self.animation_radius = 0
    return
  end

  DrawRealCircle(center, self.animation_radius - 2, 15)
  DrawRealCircle(center, self.animation_radius - 1, 10)
  DrawRealCircle(center, self.animation_radius, 9)

  self.animation_radius = self.animation_radius + self.animation_increment
end
