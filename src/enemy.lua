-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class Enemy
---@field type ET
---@field props EnemyProperties
---@field sprite_index number
---@field frame_index number
---@field regenerate_index number
---@field pos Point
---@field path Point[]
---@field next_pos Point
---@field next_pos_index number
---@field life number
---@field value_mul number
---@field damage_f ModVal
---@field speed_f ModVal
---@field bullet_list Bullet[]
---@field particle_list Particle[]
Enemy = {}
Enemy.__index = Enemy

---@param type ET
---@param value_mul number
---@return Enemy
function EnemyNew(type, value_mul)
  local o = {
    type = type,
    props = ENEMY_TABLE[type],
    sprite_index = 0,
    frame_index = 0,
    regenerate_index = 0,
    path = {},
    next_pos_index = 1,
    life = ENEMY_TABLE[type].life,
    value_mul = value_mul,
    damage_f = ModValNew(1),
    speed_f = ModValNew(1),
    bullet_list = {},
    particle_list = {}
  }
  return setmetatable(o, Enemy)
end

---@return Enemy
function Enemy:Clone()
  return EnemyNew(self.type, self.value_mul)
end

---@param x number
---@param y number
function Enemy:DrawWaveSprite(x, y)
  spr(self.props.sprite, x, y)
end

---@return boolean
function Enemy:IsGhost()
  return self.type == ET_GHOST
      or self.type == ET_GHOST_BOSS
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
  sfx(18)
end

---@param damage number
function Enemy:Damage(damage)
  self.life -= damage * self.damage_f:Get()
  if self.life <= 0 then
    self.life = -ParticleDuration

    for i = 1, 15 do
      add(self.particle_list, ParticleNew(self.pos + PointNew(3, 3)))
    end
    sfx(15)
  end
end

function Enemy:Regenerate()
  if self.regenerate_index < 45 then
    self.regenerate_index += 1
    return
  end
  self.regenerate_index = 0

  self.life = self.life + self.props.life / 10
  if self.life > self.props.life then
    self.life = self.props.life
  end
end

---@return number
function Enemy:DistanceToGoal()
  return (#self.path - self.next_pos_index) * kTileSize + self.pos:Distance(self.next_pos)
end

---@return boolean
function Enemy:IsGoingToDie()
  local bullet_sum = 0
  for bullet in all(self.bullet_list) do
    bullet_sum += bullet.damage * self.damage_f:Get()
  end
  return self.life - bullet_sum <= 0
end

---@return boolean
function Enemy:IsDead()
  return self.life == 0
end

---@return boolean
function Enemy:IsExploding()
  return self.life < 0
end

---@return boolean
function Enemy:InTarget()
  return self.pos:IsNear(self.path[#self.path], 0.5)
end

---@return number
function Enemy:GetValue()
  return flr(self.props.value * self.value_mul)
end

function Enemy:Update()
  if self:IsExploding() then
    for part in all(self.particle_list) do
      part:Update()
    end
    self.life += 1
    return
  end

  if self:InTarget() then
    return
  end

  if self.pos:IsNear(self.next_pos, 0.5) then
    self.pos:Assign(self.next_pos)
    self.next_pos_index += 1
    self.next_pos = self.path[self.next_pos_index]
  end

  self.pos:Move(self.next_pos, self.props.speed * self.speed_f:Get())

  for bullet in all(self.bullet_list) do
    if bullet:InTarget() then
      self:Hit(bullet)
    else
      bullet:Update()
    end
  end

  if self.type == ET_REGENERATE or self.type == ET_REGENERATE_BOSS then
    self:Regenerate()
  end
end

---@param modifiers TowerMods
function Enemy:Modify(modifiers)
  self.damage_f:Modify(modifiers.weaken)
  if not IsHeavyEnemy(self.type) then
    self.speed_f:Modify(modifiers.slow_down)
  end
end

function Enemy:ClearModifications()
  self.speed_f:Reset()
  self.damage_f:Reset()
end

function Enemy:Draw()
  if self:IsExploding() then
    for part in all(self.particle_list) do
      part:Draw()
    end
    return
  end

  spr(self:Animate(), self.pos.x, self.pos.y)

  local life_bar_length = 5
  local life_bar = self.life / self.props.life * life_bar_length

  local start_x = self.pos.x + 1
  local corrected_y = self.pos.y
  if corrected_y <= 8 then
    corrected_y = 9
  end

  line(start_x, corrected_y, start_x + life_bar_length, corrected_y, 8)
  line(start_x, corrected_y, start_x + life_bar, corrected_y, 12)

  for bullet in all(self.bullet_list) do
    bullet:Draw()
  end
end

---@return number
function Enemy:Animate()
  self.frame_index += 1
  if self.frame_index >= self.props.frame_cnt then
    self.frame_index = 0
    self.sprite_index += 1
    if self.sprite_index >= 4 then
      self.sprite_index = 0
    end
  end
  return self.props.sprite + self.sprite_index
end
