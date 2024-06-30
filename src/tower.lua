-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class Tower
---@field sprite number
---@field pos Point
---@field logical_pos Point
---@field type TT
---@field level number
---@field damage ModVal
---@field range ModVal
---@field reload ModVal
---@field reload_level number
---@field best_enemy Enemy
---@field canon_angle number
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
function TowerNew(pos)
  local o = {
    sprite = 34,
    pos = pos:Clone(),
    logical_pos = pos + PointNew(4, 4),
    type = TT_BASE,
    level = 0,
    damage = ModValNew(10),
    range = ModValNew(16),         --- divisor 3.75
    reload = ModValNew(10),        --- divisor 1.5
    reload_level = 0,
    canon_angle = 0,
    modifiers = TowerModifiersNew(),
    is_area_damage = false,
    can_attack_ghost = true,
    can_attack_normal = true,
    area_animation = CircleAnimationNew(),
  }

  local instance = --[[---@type Tower]] setmetatable(o, Tower)

  instance:UpdateMap()

  return instance
end

function Tower:Destroy()
  local tile_pos = PointNew(self.pos.x / kTileSize, self.pos.y / kTileSize)
  Map:TileClear4(tile_pos, 3)
end

---@param upgrade_type TT
function Tower:Upgrade(upgrade_type)
  ---@type TowerUpgrade
  local upgrade = UPGRADE_TABLE[self.type][upgrade_type]

  self.type = upgrade_type
  self.level += 1

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
    if self.type == TT_BASE then
      calculated_menu_index = type \ 100
    else
      calculated_menu_index = (type % 100) \ 10
    end

    if calculated_menu_index == menu_index then
      local menu = --[[---@type TowerMenu]] {
        cost = upgrade.cost,
        sprite = upgrade.psprite,
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
  local tile_pos = PointNew(self.pos.x / kTileSize, self.pos.y / kTileSize)
  Map:TileSet4(tile_pos, self.sprite)
end

function Tower:Draw(cursor)
  local tile_size = PointNew(kTileSize, kTileSize)
  local center = self.pos + tile_size
  if cursor.pos == self.pos then
    if self.modifiers.tower_mods then
      local top_left = self.pos - tile_size
      local bottom_right = self.pos + 3 * tile_size
      rect(top_left.x, top_left.y, bottom_right.x - 1, bottom_right.y - 1, 6)
    else
      DrawRealCircle(center, self.range:Get(), 6)
    end
  end

  if self.level > 0 then
    local x = self.pos.x + 5
    local y = self.pos.y + 14
    for i = 1, self.level do
      pset(x + i, y, 1)
    end
  end

  if self.is_area_damage then
    self.area_animation:Animate(center)
  elseif not self.modifiers.tower_mods and not self.modifiers.enemy_mods then
    if self.best_enemy then
      self.canon_angle = self.logical_pos:Angle(self.best_enemy.pos)
    end

    local pos = self.logical_pos + PointNew(3, 3)
    DrawDoubleLine(pos, pos:Trajectory(self.canon_angle, 4), 9)
  end
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
  if not self.is_area_damage then
    self:UpdateBestEnemy(enemy_list)
  end

  if self.reload_level < self.reload:Get() then
    self.reload_level += 1
    return
  end

  local triggered = false
  if self.is_area_damage then
    triggered = self:DamageEnemiesInRange(enemy_list)
    if triggered then
      self.area_animation:Start(self.range:Get())
    end
  else
    triggered = self:ShotBulletOnBestEnemy()
  end

  if triggered then
    self.reload_level = 0
  end
end

---@param enemy_list Enemy[]
function Tower:UpdateBestEnemy(enemy_list)
  self.best_enemy = nil

  ---@type number
  local best_score

  for enemy in all(enemy_list) do
    if (not enemy:IsGhost() and self.can_attack_normal) or (enemy:IsGhost() and self.can_attack_ghost) then
      if not enemy:IsGoingToDie() then
        local dist_to_tower = self.logical_pos:Distance(enemy.pos)

        if dist_to_tower <= self.range:Get() then
          local dist_to_goal = enemy:DistanceToGoal()
          local health = enemy.life

          local score = dist_to_tower + dist_to_goal + health / 8

          if not best_score then
            best_score = score
            self.best_enemy = enemy
          elseif score < best_score then
            best_score = score
            self.best_enemy = enemy
          end
        end
      end
    end
  end
end

---@return boolean
function Tower:ShotBulletOnBestEnemy()
  local best_enemy = self.best_enemy
  if best_enemy then
    local bullet = BulletNew(self.logical_pos, best_enemy.pos, self.damage:Get())
    bullet:Update()
    best_enemy:Shot(bullet)
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
