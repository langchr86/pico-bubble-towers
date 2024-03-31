-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class Enemy
---@field type number
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
---@field damage_factor number
---@field speed_factor number
---@field value number
---@field bullet_list Bullet[]
Enemy = {}
Enemy.__index = Enemy

---@param type number
---@param life number
---@return Enemy
function Enemy:New(type, life)
  local o = {
    type = type,
    sprite = 0,
    sprite_count = 1,
    sprite_index = 0,
    frame_count = 10,
    frame_index = 0,
    pos = Point:Zero(),
    path = {},
    next_pos = pos,
    next_pos_index = 1,
    speed = 1,
    max_life = life,
    life = life,
    damage_factor = 1,
    speed_factor = 1,
    value = 10,
    bullet_list = {},
  }

  local e = --[[---@type Enemy]] o

  if type == 0 then
    e.sprite = 32
    e.sprite_count = 2
    e.frame_count = 10
    e.speed = 1.0
    e.value = flr(e.speed * e.life / 10)
  elseif type == 1 then
    e.sprite = 34
    e.sprite_count = 4
    e.frame_count = 6
    e.speed = 1.4
    e.value = flr(e.speed * e.life / 10)
  end

  return setmetatable(e, self)
end

---@return Enemy
function Enemy:Clone()
  return Enemy:New(self.type, self.life)
end

---@param pos Point
---@param path Point[]
function Enemy:Activate(pos, path)
  self.pos = pos:Clone()
  self.path = path
  self.next_pos = path[1]
end

function Enemy:Shot(bullet)
  add(self.bullet_list, bullet)
end

---@param bullet Bullet
function Enemy:Hit(bullet)
  del(self.bullet_list, bullet)
  self:Damage(bullet.damage)
end

---@param damage number
function Enemy:Damage(damage)
  self.life = self.life - damage * self.damage_factor
  if self.life < 0 then
    self.life = 0
  end
end

---@param factor number
function Enemy:Weaken(factor)
  self.damage_factor = self.damage_factor * factor
end

---@param factor number
function Enemy:SlowDown(factor)
  self.speed_factor = self.speed_factor * factor
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

  self.pos:Move(self.next_pos, self.speed * self.speed_factor)

  for bullet in all(self.bullet_list) do
    if bullet:InTarget() then
      self:Hit(bullet)
    else
      bullet:Update()
    end
  end

  self:ClearModification()
end

function Enemy:ClearModification()
  self.speed_factor = 1
  self.damage_factor = 1
end

function Enemy:Draw()
  ---@type Point
  local rounded = self.pos:Floor()
  spr(self:Animate(), rounded.x, rounded.y)

  local life_bar_length = 5
  local life_bar = self.life / self.max_life * life_bar_length

  local start_x = rounded.x + 1
  local corrected_y = rounded.y
  if corrected_y == kTopRowYCoordinate then
    corrected_y = kTopRowYCoordinate + 1
  end

  line(start_x, corrected_y, start_x + life_bar_length, corrected_y, 8)
  line(start_x, corrected_y, start_x + life_bar, corrected_y, 12)

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
