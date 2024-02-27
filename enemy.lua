-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

Enemy = {
  sprite_n=2,
  pos=nil,
  path=nil,
  next_pos=nil,
  next_pos_index=1,
  speed=1,
  life=100,
  bullet_list={},
}
Enemy.__index = Enemy

function Enemy:New(init_pos, path)
  o = {
    pos=init_pos,
    path=path,
    next_pos=path[1],
    next_pos_index=1,
    bullet_list={},
  }
  return setmetatable(o, self)
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

function Enemy:InTarget()
  return self.pos == self.path[#self.path]
end

function Enemy:Update()
  if (self:InTarget()) return

  if self.pos == self.next_pos then
    self.next_pos_index += 1
    self.next_pos = self.path[self.next_pos_index]
  end

  self.pos:Move(self.next_pos, self.speed)

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
