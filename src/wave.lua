-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class Wave
---@field enemy_count number
---@field enemy_template Enemy
Wave = {}
Wave.__index = Wave

---@param enemy_count number
---@param enemy_template Enemy
---@return Wave
function Wave:New(enemy_count, enemy_template)
  local o = {
    enemy_count=enemy_count,
    enemy_template=enemy_template,
  }

  return --[[---@type Wave]] setmetatable(o, self)
end

---@param wave_count number
---@return Wave[]
function CreateWaveList(wave_count)
  ---@type number
  local type = 0
  ---@type Wave[]
  local list = {}
  for i=1,wave_count do
    add(list, Wave:New(4, Enemy:New(type)))
    type = type + 1
    if type > 1 then
      type = 0
    end
  end
  return list
end
