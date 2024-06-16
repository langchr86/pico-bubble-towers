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
    enemy_count = enemy_count,
    enemy_template = enemy_template,
    baby_list = {},
    active_list = {},
  }

  return setmetatable(o, self)
end

---@param start Point
---@param enemy_path Point[]
---@param ghost_path Point[]
function Wave:Start(start, enemy_path, ghost_path)
  for _ = 1, self.enemy_count do
    local enemy = self.enemy_template:Clone()

    if enemy:IsGhost() then
      enemy:Activate(start, ghost_path)
    else
      enemy:Activate(start, enemy_path)
    end

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
  if last_enemy:IsDead() or not last_enemy.pos:IsNear(new_enemy.pos, 8) then
    SpawnEnemy()
  end
end

---@param level number
---@return Wave[]
function CreatePredefinedWaveList(level)
  ---@type Wave[]
  local list = {}

  if level == 0 then
    -- easy
    AddEnemy(list, 2, ET.NORMAL, 2)
    AddEnemy(list, 4, ET.NORMAL, 2)
    AddEnemy(list, 3, ET.FAST, 2)
    AddEnemy(list, 1, ET.HEAVY, 2)
    AddEnemy(list, 5, ET.FAST, 2)
    AddEnemy(list, 3, ET.GHOST, 2)
    AddEnemy(list, 6, ET.NORMAL, 2)
    AddEnemy(list, 5, ET.GHOST, 2)
    AddEnemy(list, 3, ET.REGENERATE, 2)
    AddEnemy(list, 2, ET.NORMAL_BOSS, 2)
  elseif level == 1 then
    -- medium
    AddEnemy(list, 2, ET.NORMAL, 1.5)
    AddEnemy(list, 4, ET.NORMAL, 1.5)
    AddEnemy(list, 3, ET.FAST, 1.5)
    AddEnemy(list, 1, ET.HEAVY, 1.5)
    AddEnemy(list, 5, ET.FAST, 1.5)
    AddEnemy(list, 3, ET.GHOST, 1.5)
    AddEnemy(list, 6, ET.NORMAL, 1.5)
    AddEnemy(list, 5, ET.GHOST, 1.5)
    AddEnemy(list, 3, ET.REGENERATE, 1.5)
    AddEnemy(list, 2, ET.NORMAL_BOSS, 2)
    AddEnemy(list, 5, ET.FAST, 1.5)
    AddEnemy(list, 2, ET.HEAVY, 2)
    AddEnemy(list, 4, ET.HEAVY, 2)
    AddEnemy(list, 5, ET.GHOST, 1.5)
    AddEnemy(list, 4, ET.REGENERATE, 1.5)
    AddEnemy(list, 6, ET.GHOST, 1.5)
    AddEnemy(list, 8, ET.NORMAL, 1)
    AddEnemy(list, 12, ET.NORMAL, 1)
    AddEnemy(list, 3, ET.HEAVY_BOSS, 1.5)
    AddEnemy(list, 10, ET.FAST, 1.5)
    AddEnemy(list, 5, ET.FAST_BOSS, 1.5)
    AddEnemy(list, 6, ET.REGENERATE, 1)
  else
    -- hard
    AddEnemy(list, 2, ET.NORMAL, 1)
  end

  return list
end

---@param seed number
---@return Wave[]
function CreateProceduralWaveList(seed)
  srand(seed)

  ---@type number
  local wave_count = flr(10 + rnd(91))

  ---@type Wave[]
  local list = {}

  local last_type = ET.NORMAL

  for wave_index = 1, wave_count do
    ---@type ET
    local type = flr(rnd(ET.HEAVY_BOSS + 1))
    if wave_index <= 10 or IsBossEnemy(last_type) then
      type = flr(rnd(ET.NORMAL_BOSS))
    end
    last_type = type

    local enemy_count = flr(1 + rnd(8))
    if IsBossEnemy(type) then
      enemy_count = flr(1 + rnd(3))
    end

    local value_mul = flr(1 + rnd(2))

    AddEnemy(list, enemy_count, type, value_mul)
  end

  return list
end

---@param list Wave[]
---@param count number
---@param type ET
---@param value_mul number
function AddEnemy(list, count, type, value_mul)
  add(list, Wave:New(count, Enemy:New(type, value_mul)))
end
