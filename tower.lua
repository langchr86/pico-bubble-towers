-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

Tower = {
  sprite=18,
  pos=nil,
  logical_pos=nil,
  radius=16,
  charge_threshold=20,
  charge_level=0,
}
Tower.__index = Tower

function Tower:New(pos)
  o = {
    pos=pos:Clone(),
    logical_pos=pos+Point:New(4, 4),
    charge_level=self.charge_threshold,
  }

  local x = pos.x / 8
  local y = pos.y / 8
  mset(x, y, self.sprite)
  mset(x + 1, y, self.sprite + 1)
  mset(x, y + 1, self.sprite + 16)
  mset(x + 1, y + 1, self.sprite + 17)

  return setmetatable(o, self)
end

function Tower:Destroy()
  local x = self.pos.x / 8
  local y = self.pos.y / 8
  mset(x, y, 0)
  mset(x + 1, y, 0)
  mset(x, y + 1, 0)
  mset(x + 1, y + 1, 0)
end

function Tower:Update(enemy_list)
  self:ShotOnNearestEnemy(enemy_list)
end

function Tower:Draw()
  --spr(self.sprite_n, self.pos.x, self.pos.y)
  --circ(self.pos.x + 4, self.pos.y + 4, self.radius, 8)
end

function Tower:PlacedOn(other)
  return self.pos:IsColliding(other, 16)
end

function Tower:ShotOnNearestEnemy(enemy_list)
  if self.charge_level < self.charge_threshold then
    self.charge_level += 1
    return
  end

  local nearest_enemy_in_reach = nil
  local nearest_distance = nil

  for enemy in all(enemy_list) do
    local distance = self.logical_pos:Distance(enemy.pos)

    if distance <= self.radius then
      if not nearest_distance then
        nearest_distance = distance
        nearest_enemy_in_reach = enemy
      elseif distance < nearest_distance then
        nearest_distance = distance
        nearest_enemy_in_reach = enemy
      end
    end
  end

  if nearest_enemy_in_reach then
    local bullet = Bullet:New(self.logical_pos, nearest_enemy_in_reach.pos)
    nearest_enemy_in_reach:Shot(bullet)
    self.charge_level = 0
  end
end
