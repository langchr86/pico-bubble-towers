-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class Wave
---@field enemy_cnt number
---@field enemy_template Enemy
---@field baby_list Enemy[]
---@field active_list Enemy[]
Wave = {}
Wave.__index = Wave

---@param enemy_cnt number
---@param enemy_template Enemy
---@return Wave
function WaveNew(enemy_cnt, enemy_template)
  local o = {
    enemy_cnt = enemy_cnt,
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
  for _ = 1, self.enemy_cnt do
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
    ParseWaveString(list, "0208,0408,0328,0148,0528,0318,0608,0518,0338,0258")
  elseif level == 1 then
    -- medium
    ParseWaveString(list, "0206,0406,0326,0146,0526,0316,0606,0516,0336,0256")
    ParseWaveString(list, "0258,0526,0248,0448,0516,0436,0616,0804,1204,0396")
    ParseWaveString(list, "1026,0576,0684,1006,0816")
  else
    -- hard
    ParseWaveString(list, "0204,0404,0324,0144,0524,0314,0604,0514,0334,0254")
    ParseWaveString(list, "0256,0524,0246,0446,0514,0434,0614,0804,1204,0394")
    ParseWaveString(list, "1026,0578,0688,1006,0814,1036,0644,0664,1224,0874")
    ParseWaveString(list, "1604,1046,1214,2006,1546,1054,1064,1074,1094,1084")
  end

  return list
end

--- Parse quadruples in form of "cctv" separated with a ",".
---@param list Wave[]
---@param data string
function ParseWaveString(list, data)
  local enemy_cnt = 0
  local enemy_type = 0

  for i = 1, #data do
    local current_num = char2num(sub(data, i, i))
    local mode = (i - 1) % 5

    if mode == 0 then
      enemy_cnt = 10 * current_num    --- c
    elseif mode == 1 then
      enemy_cnt += current_num        --- c
    elseif mode == 2 then
      enemy_type = current_num          --- t
    elseif mode == 3 then
      local value_mul = current_num / 4 --- v
      AddEnemy(list, enemy_cnt, enemy_type, value_mul)
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
---@param cnt number
---@param type ET
---@param value_mul number
function AddEnemy(list, cnt, type, value_mul)
  add(list, WaveNew(cnt, EnemyNew(type, value_mul)))
end
