-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class Tower
---@field sprite number
---@field pos Point
---@field logical_pos Point
---@field type TowerType
---@field level number
---@field spent_cash number
---@field radius number
---@field reload_threshold number
---@field reload_level number
---@field damage ModifiableValue
---@field weaken_factor number
---@field slow_down_factor number
---@field damage_factor number
---@field is_area boolean
---@field area_animation TowerAreaAnimation
Tower = {}
Tower.__index = Tower

---@type number
Tower.BuyCost = 10

---@type number
Tower.MaxLevel = 4

---@param pos Point
---@return Tower
function Tower:New(pos)
  local o = {
    sprite = 128,
    pos = pos:Clone(),
    logical_pos = pos + Point:New(4, 4),
    type = TowerType.BASE,
    level = 0,
    spent_cash = 10,
    radius = 16,
    reload_threshold = 20,
    reload_level = 0,
    damage = ModifiableValue:New(10),
    weaken_factor = 0,
    slow_down_factor = 0,
    damage_factor = 0,
    is_area = false,
    area_animation = TowerAreaAnimation:New(),
  }

  local instance = --[[---@type Tower]] setmetatable(o, self)

  instance:UpdateMap()

  return instance
end

function Tower:Destroy()
  local tile_pos = Point:New(self.pos.x / kTileSize, self.pos.y / kTileSize)
  Map:TileClear4(tile_pos, 10)
end

---@param upgrade_type TowerType
function Tower:Upgrade(upgrade_type)
  ---@type TowerUpgrade
  local upgrade = UPGRADE_TABLE[self.type][upgrade_type]

  self.type = upgrade_type
  self.level = self.level + 1
  self.spent_cash = self.spent_cash + flr(upgrade.cost * 0.75)

  if upgrade.sprite then
    self.sprite = upgrade.sprite
  end
  if upgrade.radius then
    self.radius = upgrade.radius
  end
  if upgrade.reload then
    self.reload_threshold = upgrade.reload
  end
  if upgrade.damage then
    self.damage:SetBase(upgrade.damage)
  end
  if upgrade.weaken_factor then
    self.weaken_factor = upgrade.weaken_factor
  end
  if upgrade.slow_down_factor then
    self.slow_down_factor = upgrade.slow_down_factor
  end
  if upgrade.damage_factor then
    self.damage_factor = upgrade.damage_factor
  end
  if upgrade.is_area then
    self.is_area = upgrade.is_area
  end

  self:UpdateMap()
end

---@return boolean
function Tower:HasMaxLevel()
  return self.level >= Tower.MaxLevel
end

---@class TowerMenu
---@field cost number
---@field sprite number
---@field type TowerType

---@param menu_index number
---@return TowerMenu|nil
function Tower:GetUpgradeMenuEntry(menu_index)
  assert(menu_index < 5)

  for type, upgrade in pairs(UPGRADE_TABLE[self.type]) do
    local calculated_menu_index = 0
    if self.type == TowerType.BASE then
      calculated_menu_index = flr(type / 100)
    else
      calculated_menu_index = flr(type % 100 / 10)
    end

    if calculated_menu_index == menu_index then
      local menu = --[[---@type TowerMenu]] {
        cost = upgrade.cost,
        sprite = upgrade.preview_sprite,
        type = type,
      }
      return menu
    end
  end

  return nil
end

---@return number
function Tower.GetDestroySprite()
  return 160
end

---@return number
function Tower:GetValue()
  return self.spent_cash
end

---@param enemy_list Enemy[]
function Tower:Update(enemy_list)
  if self.weaken_factor ~= 0 or self.slow_down_factor ~= 0 then
    self:ModifyEnemies(enemy_list)
  else
    self:Shot(enemy_list)
  end
end

function Tower:ClearModifications()
  self.damage:Reset()
end

function Tower:UpdateMap()
  local tile_pos = Point:New(self.pos.x / kTileSize, self.pos.y / kTileSize)
  Map:TileSet4(tile_pos, self.sprite)
end

function Tower:Draw(cursor)
  local center = self.pos + Point:New(kTileSize, kTileSize)
  if cursor.pos == self.pos then
    DrawRealCircle(center, self.radius, 5)
  end

  if self.level > 0 then
    local x = self.pos.x + 5
    local y = self.pos.y + 14
    for i = 1, self.level do
      pset(x + i, y, 1)
    end
  end

  self.area_animation:Animate(center)
end

---@param enemy_list Enemy[]
function Tower:ModifyEnemies(enemy_list)
  for enemy in all(enemy_list) do
    local distance = self.logical_pos:Distance(enemy.pos)
    if distance <= self.radius then
      if self.weaken_factor ~= 0 then
        enemy:Weaken(self.weaken_factor)
      end
      if self.slow_down_factor ~= 0 then
        enemy:SlowDown(self.slow_down_factor)
      end
    end
  end
end

---@param tower_list Tower[]
function Tower:ModifyTowers(tower_list)
  for tower in all(tower_list) do
    if tower.pos:Is8Adjacent(self.pos, kTowerSize) then
      if self.damage_factor ~= 0 then
        tower.damage:Multiply(self.damage_factor)
      end
    end
  end
end

---@param enemy_list Enemy[]
function Tower:Shot(enemy_list)
  if self.reload_level < self.reload_threshold then
    self.reload_level = self.reload_level + 1
    return
  end

  local triggered = false
  if self.is_area then
    triggered = self:DamageEnemiesInRange(enemy_list)
    if triggered then
      self.area_animation:Start(self.radius)
    end
  else
    triggered = self:ShotOnNearestEnemy(enemy_list)
  end

  if triggered then
    self.reload_level = 0
  end
end

---@param enemy_list Enemy[]
---@return boolean
function Tower:ShotOnNearestEnemy(enemy_list)
  ---@type Enemy
  local nearest_enemy_in_reach
  ---@type number
  local nearest_distance

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
    local bullet = Bullet:New(self.logical_pos, nearest_enemy_in_reach.pos, self.damage:Get())
    nearest_enemy_in_reach:Shot(bullet)
    return true
  end

  return false
end

---@param enemy_list Enemy[]
---@return boolean
function Tower:DamageEnemiesInRange(enemy_list)
  local triggered = false

  for enemy in all(enemy_list) do
    local distance = self.logical_pos:Distance(enemy.pos)

    if distance <= self.radius then
      enemy:Damage(self.damage:Get())
      triggered = true
    end
  end

  return triggered
end
