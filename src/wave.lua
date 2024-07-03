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
function WaveNew(enemy_count, enemy_template)
  local o = {
    enemy_count = enemy_count,
    enemy_template = enemy_template,
    baby_list = {},
    active_list = {},
  }

  return setmetatable(o, Wave)
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
    local new_enemy = deli(self.baby_list, 1)
    add(existing_enemies, new_enemy)
    add(self.active_list, new_enemy)
  end

  if #self.active_list == 0 then
    SpawnEnemy()
    return
  end

  local last_enemy = self.active_list[#self.active_list]
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
    ParseWaveString(list, "0204,0404,0324,0144,0524,0314,0604,0514,0334,0254")
  elseif level == 1 then
    -- medium
    ParseWaveString(list, "0203,0403,0323,0143,0523,0313,0603,0513,0333,0253")
    ParseWaveString(list, "0254,0523,0244,0444,0513,0433,0613,0802,1202,0393")
    ParseWaveString(list, "1023,0573,0681,1003,0813")
  else
    -- hard
    ParseWaveString(list, "0202,0402,0322,0142,0522,0312,0602,0512,0332,0252")
    ParseWaveString(list, "0253,0522,0243,0443,0512,0432,0612,0802,1202,0392")
    ParseWaveString(list, "1023,0574,0684,1003,0812,1033,0642,0662,1222,0872")
    ParseWaveString(list, "1602,1043,1212,2003,1543,1052,1062,1072,1092,1082")
  end

  return list
end

--- Parse quadruples in form of "cctv" separated with a ",".
---@param list Wave[]
---@param data string
function ParseWaveString(list, data)
  local enemy_count = 0
  local enemy_type = 0

  for i = 1, #data do
    local current_num = char2num(sub(data, i, i))
    local mode = (i - 1) % 5

    if mode == 0 then
      enemy_count = 10 * current_num    --- c
    elseif mode == 1 then
      enemy_count += current_num        --- c
    elseif mode == 2 then
      enemy_type = current_num          --- t
    elseif mode == 3 then
      local value_mul = current_num / 2 --- v
      AddEnemy(list, enemy_count, enemy_type, value_mul)
    end
  end
end

---@param char string
function char2num(char)
  for num = 1, 10 do
    if char == sub("0123456789", num, num) then
      return num - 1
    end
  end
end

---@param list Wave[]
---@param count number
---@param type ET
---@param value_mul number
function AddEnemy(list, count, type, value_mul)
  add(list, WaveNew(count, EnemyNew(type, value_mul)))
end
