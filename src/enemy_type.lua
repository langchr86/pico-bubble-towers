-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@alias ET number

---@type table<string, ET>
ET = {
  NORMAL = 0,
  GHOST = 1,
  FAST = 2,
  REGENERATE = 3,
  HEAVY = 4,
  NORMAL_BOSS = 5,
  GHOST_BOSS = 6,
  FAST_BOSS = 7,
  REGENERATE_BOSS = 8,
  HEAVY_BOSS = 9,
}

---@param type ET
---@return boolean
function IsBossEnemy(type)
  return type >= ET.NORMAL_BOSS
end

---@param type ET
---@return boolean
function IsHeavyEnemy(type)
  return type == ET.HEAVY or type == ET.HEAVY_BOSS
end

---@class EnemyProperties
---@field sprite number
---@field sprite_count number
---@field frame_count number
---@field speed number
---@field life number
---@field value_bonus number

---@class ENEMY_TABLE
---@field [ET] EnemyProperties
ENEMY_TABLE = {
  [ET.NORMAL] = {
    sprite = 8,
    sprite_count = 4,
    frame_count = 8,
    speed = 1.0,
    life = 120,
    value = 4,
  },
  [ET.GHOST] = {
    sprite = 32,
    sprite_count = 2,
    frame_count = 10,
    speed = 1.0,
    life = 100,
    value = 6,
  },
  [ET.FAST] = {
    sprite = 12,
    sprite_count = 4,
    frame_count = 4,
    speed = 1.4,
    life = 100,
    value = 4,
  },
  [ET.REGENERATE] = {
    sprite = 28,
    sprite_count = 3,
    frame_count = 6,
    speed = 1.0,
    life = 150,
    value = 6,
  },
  [ET.HEAVY] = {
    sprite = 24,
    sprite_count = 4,
    frame_count = 6,
    speed = 0.6,
    life = 300,
    value = 6,
  },
  [ET.NORMAL_BOSS] = {
    sprite = 40,
    sprite_count = 4,
    frame_count = 8,
    speed = 1.0,
    life = 360,
    value = 20,
  },
  [ET.GHOST_BOSS] = {
    sprite = 48,
    sprite_count = 2,
    frame_count = 10,
    speed = 1.0,
    life = 300,
    value = 30,
  },
  [ET.FAST_BOSS] = {
    sprite = 44,
    sprite_count = 4,
    frame_count = 4,
    speed = 1.4,
    life = 300,
    value = 20,
  },
  [ET.REGENERATE_BOSS] = {
    sprite = 60,
    sprite_count = 3,
    frame_count = 6,
    speed = 1.0,
    life = 450,
    value = 30,
  },
  [ET.HEAVY_BOSS] = {
    sprite = 56,
    sprite_count = 4,
    frame_count = 6,
    speed = 0.6,
    life = 900,
    value = 30,
  },
}
