-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class Enemy
---@field sprite number
---@field pos Point
---@field path Point[]
---@field next_pos Point
---@field next_pos_index number
---@field speed number
---@field max_life number
---@field life number
---@field bullet_list Bullet[]
Enemy = {}
Enemy.__index = Enemy

---@param pos Point
---@param path Point[]
---@param type number
---@return Enemy
function Enemy:New(pos, path, type)
  ---@type number
  local base_sprite = 32
  local o = {
    sprite=base_sprite+type,
    pos=pos:Clone(),
    path=path,
    next_pos=path[1],
    next_pos_index=1,
    speed=1,
    max_life=100,
    life=100,
    bullet_list={},
  }
  return --[[---@type Enemy]] setmetatable(o, self)
end

function Enemy:Shot(bullet)
  add(self.bullet_list, bullet)
end

---@param bullet Bullet
function Enemy:Hit(bullet)
  del(self.bullet_list, bullet)
  self.life -= bullet.damage
  if self.life < 0 then
    self.life = 0
  end
end

---@return boolean
function Enemy:IsDead()
  return self.life <= 0
end

---@return boolean
function Enemy:InTarget()
  return self.pos:IsNear(self.path[#self.path], 0.5)
end

function Enemy:Update()
  if self:InTarget() then
    return
  end

  if self.pos:IsNear(self.next_pos, 0.5) then
    self.pos:Assign(self.next_pos)
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
  ---@type Point
  local rounded = self.pos:Floor()
  spr(self.sprite, rounded.x, rounded.y)

  local life_bar_length = 5
  local life_bar = self.life / self.max_life * life_bar_length
  local start_x = rounded.x + 1
  line(start_x, rounded.y, start_x + life_bar_length, rounded.y, 8)
  line(start_x, rounded.y, start_x + life_bar, rounded.y, 12)

  for bullet in all(self.bullet_list) do
    bullet:Draw()
  end
end
