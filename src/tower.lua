-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class Tower
---@field sprite number
---@field pos Point
---@field logical_pos Point
---@field type TT
---@field level number
---@field spent_cash number
---@field damage ModVal
---@field range ModVal
---@field reload ModVal
---@field reload_level number
---@field modifiers TowerModifiers
---@field is_area_damage boolean
---@field can_attack_ghost boolean
---@field can_attack_normal boolean
---@field area_animation CircleAnimation
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
    sprite = 64,
    pos = pos:Clone(),
    logical_pos = pos + Point:New(4, 4),
    type = TT.BASE,
    level = 0,
    spent_cash = 10,
    damage = ModVal:New(10),
    range = ModVal:New(16),         --- divisor 3.75
    reload = ModVal:New(10),        --- divisor 1.5
    reload_level = 0,
    modifiers = TowerModifiers:New(),
    is_area_damage = false,
    can_attack_ghost = true,
    can_attack_normal = true,
    area_animation = CircleAnimation:New(),
  }

  local instance = --[[---@type Tower]] setmetatable(o, self)

  instance:UpdateMap()

  return instance
end

function Tower:Destroy()
  local tile_pos = Point:New(self.pos.x / kTileSize, self.pos.y / kTileSize)
  Map:TileClear4(tile_pos, 3)
end

---@param upgrade_type TT
function Tower:Upgrade(upgrade_type)
  ---@type TowerUpgrade
  local upgrade = UPGRADE_TABLE[self.type][upgrade_type]

  self.type = upgrade_type
  self.level = self.level + 1
  self.spent_cash = self.spent_cash + flr(upgrade.cost * 0.75)

  if upgrade.sprite then
    self.sprite = upgrade.sprite
  end

  if upgrade.damage then
    self.damage:SetBase(upgrade.damage)
  end
  if upgrade.range then
    self.range:SetBase(upgrade.range)
  end
  if upgrade.reload then
    self.reload:SetBase(upgrade.reload)
  end

  if IsAreaDamageUpgrade(upgrade_type) then
    self.is_area_damage = true
    self.can_attack_normal = false
    self.can_attack_ghost = false
  end

  if IsNoGhostUpgrade(upgrade_type) then
    self.can_attack_ghost = false
  end

  if IsGhostOnlyUpgrade(upgrade_type) then
    self.can_attack_normal = false
  end

  self.modifiers:Upgrade(upgrade)

  self:UpdateMap()
end

---@return boolean
function Tower:HasMaxLevel()
  return self.level >= Tower.MaxLevel
end

---@class TowerMenu
---@field cost number
---@field sprite number
---@field type TT

---@param menu_index number
---@return TowerMenu|nil
function Tower:GetUpgradeMenuEntry(menu_index)
  assert(menu_index < 5)

  for type, upgrade in pairs(UPGRADE_TABLE[self.type]) do
    local calculated_menu_index = 0
    if self.type == TT.BASE then
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
  return 96
end

---@return number
function Tower:GetValue()
  return self.spent_cash
end

---@param enemy_list Enemy[]
function Tower:Update(enemy_list)
  if self.modifiers.enemy_mods then
    self:ModifyEnemies(enemy_list)
  else
    self:Shot(enemy_list)
  end
end

function Tower:ClearModifications()
  self.damage:Reset()
  self.range:Reset()
  self.reload:Reset()
end

function Tower:UpdateMap()
  local tile_pos = Point:New(self.pos.x / kTileSize, self.pos.y / kTileSize)
  Map:TileSet4(tile_pos, self.sprite)
end

function Tower:Draw(cursor)
  local tile_size = Point:New(kTileSize, kTileSize)
  local center = self.pos + tile_size
  if cursor.pos == self.pos then
    if self.modifiers.tower_mods then
      local top_left = self.pos - tile_size
      local bottom_right = self.pos + 3 * tile_size
      rect(top_left.x, top_left.y, bottom_right.x - 1, bottom_right.y - 1, 6)
    else
      DrawRealCircle(center, self.range:Get(), 6)
    end
    self:DrawDebug()
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

function Tower:DrawDebug()
  --if not g_show_debug_info then
  --  return
  --end
  --
  --local x = 2
  --local y = 86
  --x = print("damg: ", x, y, 6)
  --x = print(self.damage:Get(), x, y, 6)
  --x = print(" *", x, y, 6)
  --x = print(self.modifiers.damage, x, y, 6)
  --
  --x = print(" norm:", x, y, 6)
  --x = print(self.can_attack_normal, x, y, 6)
  --
  --x = 2
  --y = 93
  --x = print("rang: ", x, y, 6)
  --x = print(self.range:Get(), x, y, 6)
  --x = print(" *", x, y, 6)
  --x = print(self.modifiers.range, x, y, 6)
  --
  --x = print(" ghst:", x, y, 6)
  --x = print(self.can_attack_ghost, x, y, 6)
  --
  --x = 2
  --y = 100
  --x = print("reld: ", x, y, 6)
  --x = print(self.reload:Get(), x, y, 6)
  --x = print(" *", x, y, 6)
  --x = print(self.modifiers.reload, x, y, 6)
  --
  --x = print(" area:", x, y, 6)
  --x = print(self.is_area_damage, x, y, 6)
  --
  --x = 2
  --y = 107
  --x = print("weak: ", x, y, 6)
  --x = print(self.modifiers.weaken, x, y, 6)
  --
  --x = 2
  --y = 114
  --x = print("slow: ", x, y, 6)
  --x = print(self.modifiers.slow_down, x, y, 6)
end

---@param enemy_list Enemy[]
function Tower:ModifyEnemies(enemy_list)
  for enemy in all(enemy_list) do
    if self.logical_pos:IsNear(enemy.pos, self.range:Get()) then
      enemy:Modify(self.modifiers)
    end
  end
end

---@param tower_list Tower[]
function Tower:ModifyTowers(tower_list)
  for tower in all(tower_list) do
    if tower.pos:Is8Adjacent(self.pos, kTowerSize) then
      tower:Modify(self.modifiers)
    end
  end
end

---@param modifiers TowerModifiers
function Tower:Modify(modifiers)
  self.damage:Modify(modifiers.damage)
  self.range:Modify(modifiers.range)
  self.reload:Modify(modifiers.reload)
end

---@param enemy_list Enemy[]
function Tower:Shot(enemy_list)
  if self.reload_level < self.reload:Get() then
    self.reload_level = self.reload_level + 1
    return
  end

  local triggered = false
  if self.is_area_damage then
    triggered = self:DamageEnemiesInRange(enemy_list)
    if triggered then
      self.area_animation:Start(self.range:Get())
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
    if (not enemy:IsGhost() and self.can_attack_normal) or (enemy:IsGhost() and self.can_attack_ghost) then
      local distance = self.logical_pos:Distance(enemy.pos)

      if distance <= self.range:Get() then
        if not nearest_distance then
          nearest_distance = distance
          nearest_enemy_in_reach = enemy
        elseif distance < nearest_distance then
          nearest_distance = distance
          nearest_enemy_in_reach = enemy
        end
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
    if not enemy:IsGhost() and self.logical_pos:IsNear(enemy.pos, self.range:Get()) then
      enemy:Damage(self.damage:Get())
      triggered = true
    end
  end

  return triggered
end
