-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class Wave
---@field enemy_count number
---@field enemy_type number
Wave = {}
Wave.__index = Wave

---@param enemy_count number
---@param enemy_type number
---@return Wave
function Wave:New(enemy_count, enemy_type)
  local o = {
    enemy_count=enemy_count,
    enemy_type=enemy_type,
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
    add(list, Wave:New(4, type))
    type += 1
    if type > 1 then
      type = 0
    end
  end
  return list
end
