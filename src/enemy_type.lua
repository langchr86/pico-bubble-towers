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
---@field sprite_cnt number
---@field frame_cnt number
---@field speed number
---@field life number
---@field value_bonus number

---@class ENEMY_TABLE
---@field [ET] EnemyProperties
ENEMY_TABLE = {
  [ET_NORMAL] = {
    sprite = 8,
    frame_cnt = 8,
    speed = 1.0,
    life = 120,
    value = 4,
  },
  [ET_GHOST] = {
    sprite = 32,
    frame_cnt = 10,
    speed = 1.0,
    life = 100,
    value = 6,
  },
  [ET_FAST] = {
    sprite = 12,
    frame_cnt = 4,
    speed = 1.5,
    life = 100,
    value = 4,
  },
  [ET_REGENERATE] = {
    sprite = 28,
    frame_cnt = 6,
    speed = 1.0,
    life = 150,
    value = 6,
  },
  [ET_HEAVY] = {
    sprite = 24,
    frame_cnt = 6,
    speed = 0.6,
    life = 330,
    value = 6,
  },
  [ET_NORMAL_BOSS] = {
    sprite = 40,
    frame_cnt = 8,
    speed = 1.0,
    life = 360,
    value = 20,
  },
  [ET_GHOST_BOSS] = {
    sprite = 48,
    frame_cnt = 10,
    speed = 1.0,
    life = 280,
    value = 30,
  },
  [ET_FAST_BOSS] = {
    sprite = 44,
    frame_cnt = 4,
    speed = 1.5,
    life = 300,
    value = 20,
  },
  [ET_REGENERATE_BOSS] = {
    sprite = 60,
    frame_cnt = 6,
    speed = 1.0,
    life = 450,
    value = 30,
  },
  [ET_HEAVY_BOSS] = {
    sprite = 56,
    frame_cnt = 6,
    speed = 0.6,
    life = 900,
    value = 30,
  },
}
