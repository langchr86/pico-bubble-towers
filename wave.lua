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
  local type = 0
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
