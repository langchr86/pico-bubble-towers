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

function Point.__sub(lhs, rhs)
  return Point:New(lhs.x - rhs.x, lhs.y - rhs.y)
end

function Point.__eq(lhs, rhs)
    return lhs.x == rhs.x and lhs.y == rhs.y
  end
