-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

Point = {
  x=0,
  y=0,
}
Point.__index = Point

function Point:New(init_x, init_y)
  o = {
    x=init_x,
    y=init_y,
  }
  return setmetatable(o, self)
end

function Point:Clone()
  return Point:New(self.x, self.y)
end

function Point:Assign(other)
  self.x = other.x
  self.y = other.y
end

function Point:Move(dest, speed)
  local diff = dest - self

  local alpha = atan2(diff.x, -diff.y)

  self.x += cos(alpha) * speed
  self.y += cos(0.25 - alpha) * speed
end

function Point:Floor()
  return Point:New(flr(self.x), flr(self.y))
end

function Point:IsNear(other, radius)
  return self:Distance(other) <= radius
end

function Point:Distance(other)
  local diff = other - self
  return sqrt(diff.x * diff.x + diff.y * diff.y)
end

function Point:IsColliding(other, size)
  return self.x < other.x + size
    and self.x + size > other.x
    and self.y < other.y + size
    and self.y + size > other.y
end

function Point.__add(lhs, rhs)
  return Point:New(lhs.x + rhs.x, lhs.y + rhs.y)
end

function Point.__sub(lhs, rhs)
  return Point:New(lhs.x - rhs.x, lhs.y - rhs.y)
end

function Point.__eq(lhs, rhs)
  return lhs.x == rhs.x and lhs.y == rhs.y
end
