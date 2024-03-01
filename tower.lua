-- Copyright 2024 by Christian Lang is lluaTowericensed under CC BY-NC-SA 4.0

Tower = {
  sprite_n=8,
  pos=nil,
  radius=16,
  charge_threshold=20,
  charge_level=0,
}
Tower.__index = Tower

function Tower:New(pos)
  o = {
    pos=pos:Clone(),
    charge_level=self.charge_threshold,
  }
  mset(pos.x / 8, pos.y / 8, self.sprite_n)
  return setmetatable(o, self)
end

function Tower:Destroy()
  mset(self.pos.x / 8, self.pos.y / 8, 0)
end

function Tower:Update(enemy_list)
  self:ShotOnNearestEnemy(enemy_list)
end

function Tower:Draw()
  --spr(self.sprite_n, self.pos.x, self.pos.y)
  --circ(self.pos.x + 4, self.pos.y + 4, self.radius, 8)
end

function Tower:ShotOnNearestEnemy(enemy_list)
  if self.charge_level < self.charge_threshold then
    self.charge_level += 1
    return
  end

  local nearest_enemy_in_reach = nil
  local nearest_distance = nil

  for enemy in all(enemy_list) do
    local distance = self.pos:Distance(enemy.pos)

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
    local bullet = Bullet:New(self.pos, nearest_enemy_in_reach.pos)
    nearest_enemy_in_reach:Shot(bullet)
    self.charge_level = 0
  end
end
