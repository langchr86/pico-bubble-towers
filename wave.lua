-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

Wave = {
  enemy_count=0,
  enemy_type=0,
}
Wave.__index = Wave

function Wave:New(enemy_count, enemy_type)
  o = {
    enemy_count=enemy_count,
    enemy_type=enemy_type,
  }

  return setmetatable(o, self)
end

function CreateWaveList(wave_count)
  local list = {}
  for i=1,wave_count do
    add(list, Wave:New(4, 0))
  end
  return list
end
