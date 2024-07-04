-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class TowerMods
---@field damage number
---@field range number
---@field reload number
---@field weaken number
---@field slow_down number
---@field tower_mods boolean
---@field enemy_mods boolean
TowerMods = {}
TowerMods.__index = TowerMods

---@return TowerMods
function TowerModsNew()
  local o = {
    damage = 0,
    range = 0,
    reload = 0,
    weaken = 0,
    slow_down = 0,
    tower_mods = false,
    enemy_mods = false,
  }
  return setmetatable(o, TowerMods)
end

---@param upgrade TowerUpgrade
function TowerMods:Upgrade(upgrade)
  if upgrade.damage_f then
    self.damage = upgrade.damage_f
  end
  if upgrade.range_f then
    self.range = upgrade.range_f
  end
  if upgrade.reload_f then
    self.reload = upgrade.reload_f
  end
  if upgrade.weak_f then
    self.weaken = upgrade.weak_f
  end
  if upgrade.slow_f then
    self.slow_down = upgrade.slow_f
  end

  self:CheckModificationTypes()
end

function TowerMods:CheckModificationTypes()
  if self.damage ~= 0 or self.range ~= 0 or self.reload ~= 0 then
    self.tower_mods = true
  end
  if self.weaken ~= 0 or self.slow_down ~= 0 then
    self.enemy_mods = true
  end
end
