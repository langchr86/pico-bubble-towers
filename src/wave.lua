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
    ParseWaveString(list, "0208,0408,0328,0148,0528,0318,0608,0518,0338,0258,1206,0396,1026,0576,0686,1006,0816")
  elseif level == 1 then
    -- medium
    ParseWaveString(list, "0206,0406,0326,0146,0526,0316,0606,0516,0336,0256,0258,0526,0248,0448,0516,0436,0616,0804,1204,0396,1026,0576,0684,1006,0816,0664,0874")
  elseif level == 2 then
    -- hard
    ParseWaveString(list, "0204,0404,0324,0144,0524,0313,0603,0513,0334,0254,0354,0523,0244,0444,0514,0434,0614,0804,1203,0393,1024,0574,0683,1003,0813,1034,0643,0664,1224,0874,1603,1043,1213,2003,1543,0852,0862,0872,0892,0882")
  else
    -- insane
    ParseWaveString(list, "0304,0504,0424,0624,0244,0414,0703,0353,0512,0433,0352,0622,0244,0643,0514,0634,0813,0802,1202,0493,1023,0813,1033,0644,0574,0683,1002,0662,1224,0574,1603,1043,1213,0664,0574,0694,2003,1543,0854,0584,0803,1004,1024,1524,0542,0814,0602,0252,0512,0634,0652,0523,0443,0644,1014,0834,1413,1503,2003,0793,2023,1082")
  end

  return list
end

--- Parse quadruples in form of "cctv" separated with a ",".
---@param list Wave[]
---@param data string
function ParseWaveString(list, data)
  local cnt = 0
  local type = 0

  for i = 1, #data do
    local num = char2num(sub(data, i, i))
    local mode = (i - 1) % 5

    if mode == 0 then
      cnt = 10 * num            --- c
    elseif mode == 1 then
      cnt += num                --- c
    elseif mode == 2 then
      type = num                --- t
    elseif mode == 3 then
      local value_mul = num / 4 --- v
      add(list, WaveNew(cnt, EnemyNew(type, value_mul)))
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
