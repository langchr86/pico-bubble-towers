-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class Wave
---@field enemy_count number
---@field enemy_template Enemy
---@field baby_list Enemy[]
---@field active_list Enemy[]
Wave = {}
Wave.__index = Wave

---@param enemy_count number
---@param enemy_template Enemy
---@return Wave
function Wave:New(enemy_count, enemy_template)
  local o = {
    enemy_count=enemy_count,
    enemy_template=enemy_template,
    baby_list={},
    active_list={},
  }

  return --[[---@type Wave]] setmetatable(o, self)
end

---@param start Point
---@param enemy_path Point[]
function Wave:Start(start, enemy_path)
  for i=1, self.enemy_count do
    local enemy = self.enemy_template:Clone()
    enemy:Activate(start, enemy_path)
    add(self.baby_list, enemy)
  end
end

---@return boolean
function Wave:IsActive()
  return #self.baby_list > 0
end

---@param existing_enemies Enemy[]
function Wave:TrySpawnBaby(existing_enemies)
  local function SpawnEnemy()
    ---@type Enemy
    local new_enemy = deli(self.baby_list, 1)
    add(existing_enemies, new_enemy)
    add(self.active_list, new_enemy)
  end

  if #self.active_list == 0 then
    SpawnEnemy()
    return
  end

  ---@type Enemy
  local last_enemy = self.active_list[#self.active_list]
  ---@type Enemy
  local new_enemy = self.baby_list[1]
  if not last_enemy.pos:IsNear(new_enemy.pos, 8) then
    SpawnEnemy()
  end
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
