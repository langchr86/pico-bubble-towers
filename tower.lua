-- Copyright 2024 by Christian Lang is lluaTowericensed under CC BY-NC-SA 4.0

Tower = {
  sprite_n=8,
  pos=nil,
  radius=16,
  shot_interval=30,
  nearest_enemy_in_reach=nil,
}
Tower.__index = Tower

function Tower:New(pos)
  o = {
    pos=pos:Clone(),
  }
  return setmetatable(o, self)
end

function Tower:Update(enemy_list)
  self:ShotOnNearestEnemy(enemy_list)
end

function Tower:Draw()
  spr(self.sprite_n, self.pos.x, self.pos.y)
  --circ(self.pos.x + 4, self.pos.y + 4, self.radius, 8)

  if self.nearest_enemy_in_reach then
    circfill(self.pos.x + 4, self.pos.y + 4, 2, 8)
    line(self.pos.x + 4, self.pos.y + 4,self. nearest_enemy_in_reach.x + 4, self.nearest_enemy_in_reach.y + 4, 8)
  end
end

function Tower:ShotOnNearestEnemy(enemy_list)
  self.nearest_enemy_in_reach = nil
  nearest_distance = nil

  for enemy in all(enemy_list) do
    distance = enemy.pos - self.pos

    quad_dist = distance.x * distance.x + distance.y * distance.y
    quad_radius = self.radius * self.radius

    if quad_dist <= quad_radius then
      if not nearest_distance then
        nearest_distance = quad_dist
        self.nearest_enemy_in_reach = enemy.pos
      elseif quad_dist < nearest_distance then
        nearest_distance = quad_dist
        self.nearest_enemy_in_reach = enemy.pos
      end
    end
  end
end
