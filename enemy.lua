-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

Enemy = {
  sprite_n=2,
  pos=nil,
  dest_pos=nil,
  speed=1,
  last_path_index=1,
}
Enemy.__index = Enemy

function Enemy:New(init_pos)
  o = {
    pos=init_pos,
  }
  return setmetatable(o, self)
end

function Enemy:Reset(start)
  self.pos = start
  self.dest_pos = nil
  self.last_path_index = 1
end

function Enemy:DefineMoveDestination(dest)
  if self.pos and self.pos.x == dest.x and self.pos.y == dest.y then
    return false
  end
  self.dest_pos = dest
  return true
end

function Enemy:Move()
  local function move_pixel(current, destination, speed)
    difference = destination - current
    if difference < 0 then
      return -speed
    elseif difference > 0 then
      return speed
    else
      return 0
    end
  end

  moved_x = move_pixel(self.pos.x, self.dest_pos.x, self.speed)
  moved_y = move_pixel(self.pos.y, self.dest_pos.y, self.speed)

  self.pos.x += moved_x
  self.pos.y += moved_y
end

function Enemy:Draw()
  if self.pos then
    spr(self.sprite_n, self.pos.x, self.pos.y)
  end
end
