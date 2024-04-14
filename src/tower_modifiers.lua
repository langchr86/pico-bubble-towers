-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class TowerModifiers
---@field damage number
---@field range number
---@field reload number
---@field weaken number
---@field slow_down number
---@field has_tower_modifications boolean
---@field has_enemy_modifications boolean
TowerModifiers = {}
TowerModifiers.__index = TowerModifiers

---@return TowerModifiers
function TowerModifiers:New()
  local o = {
    damage = 0,
    range = 0,
    reload = 0,
    weaken = 0,
    slow_down = 0,
    has_tower_modifications = false,
    has_enemy_modifications = false,
  }

  local instance = --[[---@type TowerModifiers]] setmetatable(o, self)
  return instance
end

---@param upgrade TowerUpgrade
function TowerModifiers:Upgrade(upgrade)
  if upgrade.damage_factor then
    self.damage = upgrade.damage_factor
  end
  if upgrade.range_factor then
    self.range = upgrade.range_factor
  end
  if upgrade.reload_factor then
    self.reload = upgrade.reload_factor
  end
  if upgrade.weaken_factor then
    self.weaken = upgrade.weaken_factor
  end
  if upgrade.slow_down_factor then
    self.slow_down = upgrade.slow_down_factor
  end

  self:CheckModificationTypes()
end

function TowerModifiers:CheckModificationTypes()
  if self.damage ~= 0 or self.range ~= 0 or self.reload ~= 0 then
    self.has_tower_modifications = true
  end
  if self.weaken ~= 0 or self.slow_down ~= 0 then
    self.has_enemy_modifications = true
  end
end

---@return boolean
function TowerModifiers:HasTowerModifications()
  return self.has_tower_modifications
end

---@return boolean
function TowerModifiers:HasEnemyModifications()
  return self.has_enemy_modifications
end
