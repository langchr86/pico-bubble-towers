-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class Point
---@field x number
---@field y number
Point = {}
Point.__index = Point

---@param x number
---@param y number
---@return Point
function Point:New(x, y)
  local o = {
    x = x;
    y = y;
  }
  return --[[---@type Point]] setmetatable(o, self)
end

---@return Point
function Point:Zero()
  return Point:New(0, 0)
end

---@return Point
function Point:Clone()
  return Point:New(self.x, self.y)
end

---@param other Point
function Point:Assign(other)
  self.x = other.x
  self.y = other.y
end

---@param dest Point
---@param speed number
function Point:Move(dest, speed)
  ---@type Point
  local diff = dest - self

  ---@type number
  local alpha = atan2(diff.x, -diff.y)

  self.x = self.x + cos(alpha) * speed
  self.y = self.y + cos(0.25 - alpha) * speed
end

---@return Point
function Point:Floor()
  return Point:New(flr(self.x), flr(self.y))
end

---@param other Point
---@param radius number
---@return boolean
function Point:IsNear(other, radius)
  return self:Distance(other) <= radius
end

---@param other Point
---@param distance number
---@return boolean
function Point:Is8Adjacent(other, distance)
  return self.x <= other.x + distance
      and self.x >= other.x - distance
      and self.y <= other.y + distance
      and self.y >= other.y - distance
end

---@param other Point
---@return number
function Point:Distance(other)
  ---@type Point
  local diff = other - self
  return sqrt(diff.x * diff.x + diff.y * diff.y)
end

---@param lhs Point
---@param rhs Point
---@return Point
function Point.__add(lhs, rhs)
  return Point:New(lhs.x + rhs.x, lhs.y + rhs.y)
end

---@param lhs Point
---@param rhs Point
---@return Point
function Point.__sub(lhs, rhs)
  return Point:New(lhs.x - rhs.x, lhs.y - rhs.y)
end

---@param scalar number
---@param point Point
---@return Point
function Point.__mul(scalar, point)
  return Point:New(scalar * point.x, scalar * point.y)
end

---@param lhs Point
---@param rhs Point
---@return boolean
function Point.__eq(lhs, rhs)
  return lhs.x == rhs.x and lhs.y == rhs.y
end
