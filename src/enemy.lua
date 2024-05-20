-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class Enemy
---@field type EnemyType
---@field props EnemyProperties
---@field sprite_index number
---@field frame_index number
---@field regenerate_index number
---@field pos Point
---@field path Point[]
---@field next_pos Point
---@field next_pos_index number
---@field life number
---@field damage_factor ModifiableValue
---@field speed_factor ModifiableValue
---@field bullet_list Bullet[]
Enemy = {}
Enemy.__index = Enemy

---@param type EnemyType
---@param props EnemyProperties
---@return Enemy
function Enemy:New(type)
  local o = {
    type = type,
    props = ENEMY_TABLE[type],
    sprite_index = 0,
    frame_index = 0,
    regenerate_index = 0,
    pos = Point:Zero(),
    path = {},
    next_pos = Point:Zero(),
    next_pos_index = 1,
    life = ENEMY_TABLE[type].life,
    damage_factor = ModifiableValue:New(1),
    speed_factor = ModifiableValue:New(1),
    bullet_list = {},
  }

  local e = --[[---@type Enemy]] o

  return setmetatable(e, self)
end

---@return Enemy
function Enemy:Clone()
  return Enemy:New(self.type)
end

---@param x number
---@param y number
function Enemy:DrawWaveSprite(x, y)
  spr(self.props.sprite, x, y)
end

---@return boolean
function Enemy:IsGhost()
  return self.type == EnemyType.GHOST
      or self.type == EnemyType.GHOST_BOSS
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
  sfx(0x12, -1)
end

---@param damage number
function Enemy:Damage(damage)
  self.life = self.life - damage * self.damage_factor:Get()
  if self.life < 0 then
    self.life = 0
  end
end

function Enemy:Regenerate()
  if self.regenerate_index < 60 then
    self.regenerate_index = self.regenerate_index + 1
    return
  end
  self.regenerate_index = 0

  self.life = self.life + self.props.life / 10
  if self.life > self.props.life then
    self.life = self.props.life
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
  local base_value = flr(self.props.speed * self.props.life / 10)
  return base_value + self.props.value_bonus
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

  self.pos:Move(self.next_pos, self.props.speed * self.speed_factor:Get())

  for bullet in all(self.bullet_list) do
    if bullet:InTarget() then
      self:Hit(bullet)
    else
      bullet:Update()
    end
  end

  if self.type == EnemyType.REGENERATE or self.type == EnemyType.REGENERATE_BOSS then
    self:Regenerate()
  end
end

---@param modifiers TowerModifiers
function Enemy:Modify(modifiers)
  self.damage_factor:Modify(modifiers.weaken)
  self.speed_factor:Modify(modifiers.slow_down)
end

function Enemy:ClearModifications()
  self.speed_factor:Reset()
  self.damage_factor:Reset()
end

function Enemy:Draw()
  ---@type Point
  local rounded = self.pos:Floor()
  spr(self:Animate(), rounded.x, rounded.y)

  local life_bar_length = 5
  local life_bar = self.life / self.props.life * life_bar_length

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
  if self.frame_index >= self.props.frame_count then
    self.frame_index = 0
    self.sprite_index = self.sprite_index + 1
    if self.sprite_index >= self.props.sprite_count then
      self.sprite_index = 0
    end
  end
  return self.props.sprite + self.sprite_index
end
