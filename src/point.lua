-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class Point
---@field x number
---@field y number
Point = {}
Point.__index = Point

---@param x number
---@param y number
---@return Point
function PointNew(x, y)
  local o = {
    x = x;
    y = y;
  }
  return setmetatable(o, Point)
end

---@return Point
function Point:Clone()
  return PointNew(self.x, self.y)
end

---@param other Point
function Point:Assign(other)
  self.x = other.x
  self.y = other.y
end

---@param dest Point
---@param speed number
function Point:Move(dest, speed)
  local next = self:Trajectory(self:Angle(dest), speed)
  self.x = next.x
  self.y = next.y
end

---@param dest Point
---@return number
function Point:Angle(dest)
  local diff = dest - self
  return atan2(diff.x, -diff.y)
end

---@param alpha number
---@param length number
---@return Point
function Point:Trajectory(alpha, length)
  local x = self.x + cos(alpha) * length
  local y = self.y + cos(0.25 - alpha) * length
  return PointNew(x, y)
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
  local diff = other - self
  return sqrt(diff.x * diff.x + diff.y * diff.y)
end

---@param lhs Point
---@param rhs Point
---@return Point
function Point.__add(lhs, rhs)
  return PointNew(lhs.x + rhs.x, lhs.y + rhs.y)
end

---@param lhs Point
---@param rhs Point
---@return Point
function Point.__sub(lhs, rhs)
  return PointNew(lhs.x - rhs.x, lhs.y - rhs.y)
end

---@param scalar number
---@param point Point
---@return Point
function Point.__mul(scalar, point)
  return PointNew(scalar * point.x, scalar * point.y)
end

---@param lhs Point
---@param rhs Point
---@return boolean
function Point.__eq(lhs, rhs)
  return lhs.x == rhs.x and lhs.y == rhs.y
end
