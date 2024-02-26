-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

Enemy = {
  sprite_n=2,
  pos=nil,
  dest_pos=nil,
  speed=1,
  life=100,
  last_path_index=1,
  bullet_list={},
}
Enemy.__index = Enemy

function Enemy:New(init_pos)
  o = {
    pos=init_pos,
    bullet_list={},
  }
  return setmetatable(o, self)
end

function Enemy:Reset(start)
  self.pos = start
  self.dest_pos = nil
  self.last_path_index = 1
end

function Enemy:DefineMoveDestination(dest)
  if self.pos == dest then
    return false
  end
  self.dest_pos = dest
  return true
end

function Enemy:Shot(bullet)
  add(self.bullet_list, bullet)
end

function Enemy:Hit(bullet)
  del(self.bullet_list, bullet)
  self.life -= bullet.damage
end

function Enemy:IsDead()
  return self.life <= 0
end

function Enemy:Update()
  if (not self.dest_pos) return
  self.pos:Move(self.dest_pos, self.speed)

  for bullet in all(self.bullet_list) do
    if bullet:InTarget() then
      self:Hit(bullet)
    else
      bullet:Update()
    end
  end
end

function Enemy:Draw()
  local rounded = self.pos:Floor()
  spr(self.sprite_n, rounded.x, rounded.y)

  local life_bar = self.life / 100 * 6
  line(self.pos.x + 1, self.pos.y, self.pos.x + life_bar, self.pos.y, 12)

  for bullet in all(self.bullet_list) do
    bullet:Draw()
  end
end
