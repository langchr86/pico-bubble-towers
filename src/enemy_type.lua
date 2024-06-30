-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@alias ET number

ET_NORMAL = 0
ET_GHOST = 1
ET_FAST = 2
ET_REGENERATE = 3
ET_HEAVY = 4
ET_NORMAL_BOSS = 5
ET_GHOST_BOSS = 6
ET_FAST_BOSS = 7
ET_REGENERATE_BOSS = 8
ET_HEAVY_BOSS = 9

---@param type ET
---@return boolean
function IsBossEnemy(type)
  return type >= ET_NORMAL_BOSS
end

---@param type ET
---@return boolean
function IsHeavyEnemy(type)
  return type == ET_HEAVY or type == ET_HEAVY_BOSS
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
  [ET_NORMAL] = {
    sprite = 8,
    sprite_count = 4,
    frame_count = 8,
    speed = 1.0,
    life = 120,
    value = 4,
  },
  [ET_GHOST] = {
    sprite = 32,
    sprite_count = 2,
    frame_count = 10,
    speed = 1.0,
    life = 100,
    value = 6,
  },
  [ET_FAST] = {
    sprite = 12,
    sprite_count = 4,
    frame_count = 4,
    speed = 1.4,
    life = 100,
    value = 4,
  },
  [ET_REGENERATE] = {
    sprite = 28,
    sprite_count = 3,
    frame_count = 6,
    speed = 1.0,
    life = 150,
    value = 6,
  },
  [ET_HEAVY] = {
    sprite = 24,
    sprite_count = 4,
    frame_count = 6,
    speed = 0.6,
    life = 300,
    value = 6,
  },
  [ET_NORMAL_BOSS] = {
    sprite = 40,
    sprite_count = 4,
    frame_count = 8,
    speed = 1.0,
    life = 360,
    value = 20,
  },
  [ET_GHOST_BOSS] = {
    sprite = 48,
    sprite_count = 2,
    frame_count = 10,
    speed = 1.0,
    life = 300,
    value = 30,
  },
  [ET_FAST_BOSS] = {
    sprite = 44,
    sprite_count = 4,
    frame_count = 4,
    speed = 1.4,
    life = 300,
    value = 20,
  },
  [ET_REGENERATE_BOSS] = {
    sprite = 60,
    sprite_count = 3,
    frame_count = 6,
    speed = 1.0,
    life = 450,
    value = 30,
  },
  [ET_HEAVY_BOSS] = {
    sprite = 56,
    sprite_count = 4,
    frame_count = 6,
    speed = 0.6,
    life = 900,
    value = 30,
  },
}
