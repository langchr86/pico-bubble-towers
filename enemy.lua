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
  if self.pos and self.pos == dest then
    return false
  end
  self.dest_pos = dest
  return true
end

function Enemy:Move()
  if (not self.dest_pos) return
  self.pos:Move(self.dest_pos, self.speed)
end

function Enemy:Draw()
  if self.pos then
    local rounded = self.pos:Floor()
    spr(self.sprite_n, rounded.x, rounded.y)
  end
end
