-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

Tower = {
  sprite=128,
  pos=nil,
  logical_pos=nil,
  radius=16,
  reload_threshold=20,
  reload_level=0,
}
Tower.__index = Tower

function Tower:New(pos)
  o = {
    pos=pos:Clone(),
    logical_pos=pos+Point:New(4, 4),
    reload_level=self.reload_threshold,
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
  mset(x, y, 10)
  mset(x + 1, y, 10)
  mset(x, y + 1, 10)
  mset(x + 1, y + 1, 10)
end

function Tower:Update(enemy_list)
  self:ShotOnNearestEnemy(enemy_list)
end

function Tower:Draw()
  --circ(self.pos.x + 4, self.pos.y + 4, self.radius, 8)
end

function Tower:PlacedOn(other)
  return self.pos:IsColliding(other, 16)
end

function Tower:ShotOnNearestEnemy(enemy_list)
  if self.reload_level < self.reload_threshold then
    self.reload_level += 1
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
    self.reload_level = 0
  end
end
