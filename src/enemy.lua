-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class Enemy
---@field sprite number
---@field sprite_count number
---@field sprite_index number
---@field frame_count number
---@field frame_index number
---@field pos Point
---@field path Point[]
---@field next_pos Point
---@field next_pos_index number
---@field speed number
---@field max_life number
---@field life number
---@field value number
---@field bullet_list Bullet[]
Enemy = {}
Enemy.__index = Enemy

---@param pos Point
---@param path Point[]
---@param type number
---@return Enemy
function Enemy:New(pos, path, type)
  local o = {
    sprite=0,
    sprite_count=1,
    sprite_index=0,
    frame_count=10,
    frame_index=0,
    pos=pos:Clone(),
    path=path,
    next_pos=path[1],
    next_pos_index=1,
    speed=1,
    max_life=100,
    life=100,
    value=20,
    bullet_list={},
  }

  local e = --[[---@type Enemy]] o

  if type == 0 then
    e.sprite = 32
    e.sprite_count = 2
    e.frame_count = 10
    e.speed = 1.0
  elseif type == 1 then
    e.sprite = 34
    e.sprite_count = 4
    e.frame_count = 6
    e.speed = 1.4
  end

  return setmetatable(e, self)
end

function Enemy:Shot(bullet)
  add(self.bullet_list, bullet)
end

---@param bullet Bullet
function Enemy:Hit(bullet)
  del(self.bullet_list, bullet)
  self.life = self.life - bullet.damage
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

---@return number
function Enemy:GetValue()
  return self.value
end

function Enemy:Update()
  if self:InTarget() then
    return
  end

  if self.pos:IsNear(self.next_pos, 0.5) then
    self.pos:Assign(self.next_pos)
    self.next_pos_index = self.next_pos_index + 1
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
  spr(self:Animate(), rounded.x, rounded.y)

  local life_bar_length = 5
  local life_bar = self.life / self.max_life * life_bar_length
  local start_x = rounded.x + 1
  line(start_x, rounded.y, start_x + life_bar_length, rounded.y, 8)
  line(start_x, rounded.y, start_x + life_bar, rounded.y, 12)

  for bullet in all(self.bullet_list) do
    bullet:Draw()
  end
end

---@return number
function Enemy:Animate()
  self.frame_index = self.frame_index + 1
  if self.frame_index >= self.frame_count then
    self.frame_index = 0
    self.sprite_index = self.sprite_index + 1
    if self.sprite_index >= self.sprite_count then
      self.sprite_index = 0
    end
  end
  return self.sprite + self.sprite_index
end
